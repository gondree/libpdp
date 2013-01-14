/* 
* sepdp-app.c
*
* Copyright (c) 2010, Zachary N J Peterson <znpeters@nps.edu>
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the Naval Postgraduate School nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY ZACHARY N J PETERSON ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL ZACHARY N J PETERSON BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifdef USE_S3

#include "sepdp.h"
#include <libs3.h>
#include <unistd.h>
#include <libgen.h>
#include <sys/stat.h>
#include <sys/param.h>

#define S3_BUCKET_NAME "sepdp"
#define S3_ACCESS_KEY "test:tester"
#define S3_SECRET_ACCESS_KEY "testing" 
#define S3_HOSTNAME "172.20.109.194:8080"

struct buffer_pointer{

	unsigned char *buf;
	int offset;
};

static int putObjectDataCallback(int bufferSize, char *buffer, void *callbackData)
{
	int ret = 0;

	ret = fread(buffer, 1, bufferSize, callbackData);

	return ret;
	
}

static S3Status getObjectDataCallbackFile(int bufferSize, const char *buffer, void *callbackData)
{

    FILE *outfile = (FILE *) callbackData;

    size_t wrote = fwrite(buffer, 1, bufferSize, outfile);
    
    return ((wrote < (size_t) bufferSize) ? 
            S3StatusAbortedByCallback : S3StatusOK);

}

static S3Status getObjectDataCallback(int bufferSize, const char *buffer, void *callbackData)
{

	struct buffer_pointer *bp = callbackData;

	memcpy((char *)bp->buf + bp->offset, (char *)buffer, bufferSize);
	bp->offset += bufferSize;
	
	return S3StatusOK;
}

static S3Status headresponsePropertiesCallback(const S3ResponseProperties *properties, void *callbackData){         

	if(properties->contentLength) memcpy((unsigned long long *)callbackData, &(properties->contentLength), sizeof(unsigned long long) );

	return S3StatusOK; 
}

static S3Status responsePropertiesCallback(const S3ResponseProperties *properties, void *callbackData){         

	return S3StatusOK; 
}


static void responseCompleteCallback(S3Status status, const S3ErrorDetails *error, void *callbackData){ }


static int sepdp_s3_get_block(char *filepath, size_t filepath_len, unsigned char *block, size_t block_len, unsigned int index){

	if(!filepath || !filepath_len || !block || !block_len) return 0;
	
	S3Status status;
    if ((status = S3_initialize("s3", S3_INIT_ALL, params.s3_hostname))
        != S3StatusOK) {
        PRINT_ERR("Failed to initialize libs3: %s\n", 
                S3_get_status_name(status));
        exit(-1);
    }

	S3BucketContext bucketContext =
    {
		0,
        S3_BUCKET_NAME, //bucket name
        S3ProtocolHTTP,
        S3UriStylePath,
        params.s3_access_key, //access key
        params.s3_secret_key //secret access key
    };

    S3GetConditions getConditions =
    {
        -1, //ifModifiedSince,
        -1, // ifNotModifiedSince,
        0, //ifMatch,
        0 //ifNotMatch
    };

    S3GetObjectHandler getObjectHandler =
    {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &getObjectDataCallback
    };

	struct buffer_pointer bp;
	bp.buf = block;
	bp.offset = 0;

	S3_get_object(&bucketContext, basename(filepath), &getConditions, (index * block_len), block_len, 0, &getObjectHandler, &bp);

	S3_deinitialize();

	return 1;
	
	
}

int sepdp_s3_put_file(char *filepath, size_t filepath_len){
	
	FILE *file = NULL;
	unsigned char *buffer;
	struct stat statbuf;
	
	if(!filepath || !filepath_len) return 0;
	
	if((buffer = malloc(params.block_size)) == NULL)
		goto cleanup;
	memset(buffer, 0, params.block_size);
	
	file = fopen(filepath, "r");
	if(file == NULL){
		printf("Couldn't open file %s\n", filepath);
		return -1;
	}
	
	/* Initialize the S3 library */
	S3Status status;
    if ((status = S3_initialize("s3", S3_INIT_ALL, params.s3_hostname)) != S3StatusOK) {
        PRINT_ERR("Failed to initialize libs3: %s\n", S3_get_status_name(status));
		goto cleanup;
    }
	
	/* Set the S3 context */
	S3BucketContext bucketContext =
    {
		0,
        S3_BUCKET_NAME,
        S3ProtocolHTTP,
        S3UriStylePath,
        params.s3_access_key,
        params.s3_secret_key
    };

	/* Set the object properties */
    S3PutProperties putProperties =
    {
        0, //content-type defaults to "binary/octet-stream"
        0, //md5 sum, not required
        0, //cacheControl, not required
        0, //contentDispositionFilename, This is only relevent for objects which are intended to be shared to users via web browsers and which is additionally intended to be downloaded rather than viewed.
        0, //contentEncoding, This is only applicable to encoded (usually, compressed) content, and only relevent if the object is intended to be downloaded via a browser.
        (int64_t)-1,  //expires, This information is typically only delivered to users who download the content via a web browser.
        S3CannedAclPrivate,
        0, //metaPropertiesCount, This is the number of values in the metaData field.
        0 //metaProperties
    };

	/* Set the callbacks */
    S3PutObjectHandler putObjectHandler =
    {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &putObjectDataCallback
    };

	/* Get the file size */
	if (stat(filepath, &statbuf) == -1) {
		PRINT_ERR("\nERROR: Failed to stat file %s: ", filepath);
		goto cleanup;
	}

	S3_put_object(&bucketContext, basename(filepath), statbuf.st_size, &putProperties, 0, &putObjectHandler, file);

	S3_deinitialize();
	if(file) fclose(file);
	
	return 1;

cleanup:
	if(file) fclose(file);
	S3_deinitialize();
	if(buffer) sfree(buffer, params.block_size);
	
	return 0;
}

int sepdp_s3_get_file(char *filepath, size_t filepath_len){

	FILE *file = NULL;

	if(!filepath || !filepath_len) return 0;
	
	file = fopen(filepath, "w");
	if(!file){
		PRINT_ERR("ERROR: Was not able to create %s.\n", filepath);
		goto cleanup;
	}
	
	S3Status status;
    if ((status = S3_initialize("s3", S3_INIT_ALL, params.s3_hostname))
        != S3StatusOK) {
        PRINT_ERR("Failed to initialize libs3: %s\n", 
                S3_get_status_name(status));
        exit(-1);
    }

	S3BucketContext bucketContext =
    {
		0,
        S3_BUCKET_NAME,
        S3ProtocolHTTP,
        S3UriStylePath,
        params.s3_access_key,
        params.s3_secret_key
    };

    S3GetConditions getConditions =
    {
        -1, //ifModifiedSince,
        -1, // ifNotModifiedSince,
        0, //ifMatch,
        0 //ifNotMatch
    };

    S3GetObjectHandler getObjectHandler =
    {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &getObjectDataCallbackFile
    };

	S3_get_object(&bucketContext, basename(filepath), &getConditions, 0, 0, 0, &getObjectHandler, file);

	S3_deinitialize();
	if(file) fclose(file);

	return 1;

cleanup:	
	if(file) fclose(file);
	return 0;
}


/* pdp_prove_file: Computes the server-side proof.
 * Takes in the file to be proven, its corresponding tag file, and a "sanitized" challenge and key structure.
 * Returns an allocated proof structure or NULL on error.
*/
SEPDP_proof *sepdp_s3_prove_file(char *filepath, size_t filepath_len, char *tokenfilepath, size_t tokenfilepath_len, SEPDP_challenge *challenge){

	SEPDP_proof *proof = NULL;
	unsigned char **D = NULL;
	char realtokenfilepath[MAXPATHLEN];
	//size_t realtokenfilepath_len = 0;
	unsigned int numfileblocks = 0;
	unsigned int r = 0;
	unsigned int *indices = NULL;
	int i = 0, j = 0;
	unsigned long long filesize = 0;
	
	if(!filepath || !filepath_len || !challenge) return NULL;
	
	proof = generate_sepdp_proof();
	if(!proof) goto cleanup;
	
	memset(realtokenfilepath, 0, MAXPATHLEN);
	/* If no token file path is specified, add a .tok extension to the filepath */
	if(!tokenfilepath && (filepath_len < MAXPATHLEN - 5)){
		if( snprintf(realtokenfilepath, MAXPATHLEN, "%s.tok", filepath) >= MAXPATHLEN) goto cleanup;
		//realtokenfilepath_len = filepath_len + 4;
	}else{
		memcpy(realtokenfilepath, tokenfilepath, tokenfilepath_len);
		//realtokenfilepath_len = tokenfilepath_len;
	}
	
	S3Status status;
    if ((status = S3_initialize("s3", S3_INIT_ALL, params.s3_hostname))
        != S3StatusOK) {
        PRINT_ERR("Failed to initialize libs3: %s\n", 
                S3_get_status_name(status));
        exit(-1);
    }

	/* Get the number of sepdp blocks in the file from S3 */ 
  	S3BucketContext bucketContext =
    {
		0,
        S3_BUCKET_NAME, //bucket name
        S3ProtocolHTTP,
        S3UriStylePath,
        params.s3_access_key, //access key
        params.s3_secret_key //secret access key
    };

    S3ResponseHandler responseHandler =
    { 
        &headresponsePropertiesCallback,
        &responseCompleteCallback
    };

	S3_head_object(&bucketContext, basename(filepath), 0, &responseHandler, &filesize);

	/* Calculate the number sepdp blocks in the file */
	numfileblocks = (filesize/params.block_size);
	if(filesize%params.block_size)
		numfileblocks++;

	/* Calculate the number of sepdp blocks to challenge */
	if(numfileblocks < params.magic_num_challenge_blocks)
		r = numfileblocks;
	else
		r = params.magic_num_challenge_blocks;

	/* Allocate room for the selected data blocks */
	if( ((D = malloc(r * sizeof(unsigned char *))) == NULL)) goto cleanup;
	memset(D, 0, r * sizeof(unsigned char *));
	for(i = 0; i < r; i++){
		if( ((D[i] = malloc(params.block_size)) == NULL)) goto cleanup;
		memset(D[i], 0, params.block_size);
	}
	
	/* Generate the block indices for this token */
	indices = generate_prp_g(challenge->ki, challenge->ki_size, numfileblocks, r);
	if(!indices) goto cleanup;
		
	/* Get block at indices[j] from S3 */
	for(j = 0; j < r; j++){
		if(!sepdp_s3_get_block(filepath, filepath_len, D[j], params.block_size, indices[j])) goto cleanup;		
	}
		
	/* Do the hash */
	proof->z = generate_H(challenge->ci, challenge->ci_size, D, r, &(proof->z_size));
	if(!proof->z) goto cleanup;
	
	/* Get the (encrypted) token from S3 to send back to the client */
	S3BucketContext bucketContext2 =
    {
		0,
        S3_BUCKET_NAME, //bucket name
        S3ProtocolHTTP,
        S3UriStylePath,
        params.s3_access_key, //access key
        params.s3_secret_key //secret access key
    };

    S3GetConditions getConditions =
    {
        -1, //ifModifiedSince,
        -1, // ifNotModifiedSince,
        0, //ifMatch,
        0 //ifNotMatch
    };

    S3GetObjectHandler getObjectHandler =
    {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &getObjectDataCallback
    };

	struct buffer_pointer bp;
							// |-- index --|-- iv_size --|-- iv --|-- token_size --|-- token --|-- mac_size --|-- mac --| ...
							// WARNING: MAGIC NUMBER 32 == the closest multiple of the ae_key_size (rounding up) to the token_vi hash
	size_t full_tag_size = sizeof(unsigned int) + sizeof(size_t) + params.ae_key_size + sizeof(size_t) + 32  + sizeof(size_t) + SHA_DIGEST_LENGTH;
	bp.buf = malloc(full_tag_size);
	bp.offset = 0;


	S3_get_object(&bucketContext2, basename(realtokenfilepath), &getConditions, (full_tag_size * challenge->i), full_tag_size, 0, &getObjectHandler, &bp);

	proof->iv_size = *(size_t*)(bp.buf + sizeof(unsigned int)) ;
	proof->token_size = *(size_t*)(bp.buf + sizeof(unsigned int) + sizeof(size_t) + proof->iv_size) ;
	proof->mac_size = *(size_t*)(bp.buf + sizeof(unsigned int) + sizeof(size_t) + proof->iv_size + sizeof(size_t) + proof->token_size);
	memcpy(proof->iv, (bp.buf + sizeof(unsigned int) + sizeof(size_t)), proof->iv_size);  
	memcpy(proof->token, (bp.buf + sizeof(unsigned int) + sizeof(size_t) + proof->iv_size + sizeof(size_t)), proof->token_size);  
	memcpy(proof->mac, (bp.buf + sizeof(unsigned int) + sizeof(size_t) + proof->iv_size + sizeof(size_t) + proof->token_size + sizeof(size_t)), proof->mac_size);  
	
	S3_deinitialize();
	if(indices) sfree(indices, sizeof(unsigned int) * r);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}
	
	return proof;
	
 cleanup:
	S3_deinitialize();
	if(proof) destroy_sepdp_proof(proof);
	if(indices) sfree(indices, sizeof(unsigned int) * r);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}
	
	return NULL;

}

#endif
