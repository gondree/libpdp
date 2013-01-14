/* 
* cpor-app.c
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

#include <getopt.h>
#include "cpor.h"

static struct option longopts[] = {
	{"numchallenge", no_argument, NULL, 'l'},
	{"lambda", no_argument, NULL, 'y'}, 
	{"Zp", no_argument, NULL, 'z'},
	{"prfkeysize", no_argument, NULL, 'p'},
	{"enckeysize", no_argument, NULL, 'e'},
	{"mackeysize", no_argument, NULL, 'm'},
	{"blocksize", no_argument, NULL, 'b'},
	{"sectorsize", no_argument, NULL, 'c'},
	{"newdata", no_argument, NULL, 'w'},
	{"numsectors", no_argument, NULL, 'n'},
	{"numthreads", no_argument, NULL, 'h'},
	{"keygen", no_argument, NULL, 'k'}, //TODO optional argument for key location
	{"tag", no_argument, NULL, 't'},
	{"verify", no_argument, NULL, 'v'},
	{"silent", no_argument, NULL, 's'},
	{NULL, 0, NULL, 0}
};

CPOR_params params;

void usage(){

	fprintf(stdout, "cpor (compact proofs of retrievability) 1.0\n");
	fprintf(stdout, "Copyright (c) 2008 Zachary N J Peterson <znpeters@nps.edu>\n");
	fprintf(stdout, "This program comes with ABSOLUTELY NO WARRANTY.\n");
	fprintf(stdout, "This is free software, and you are welcome to redistribute it\n");
	fprintf(stdout, "under certain conditions.\n\n");
	fprintf(stdout, "usage: cpor [options] [file]\n\n");
	fprintf(stdout, "Commands:\n\n");
	fprintf(stdout, "-t, --tag [file]\t tag a file\n");
	fprintf(stdout, "-v, --verify [file]\t verify data possession\n");
	fprintf(stdout, "-k, --keygen\t\t generate a new PDP key pair\n");
	fprintf(stdout, "-y, --lambda\t\t security parameter lambda\n");
	fprintf(stdout, "-z, --Zp\t\t bit-length of prime over which Z_p is generated\n");
	fprintf(stdout, "-p, --prfkeysize\t size (bytes) of the PRF key\n");
	fprintf(stdout, "-e, --enckeysize\t size (bytes) of the AES encryption key\n");
	fprintf(stdout, "-m, --mackeysize\t size (bytes) of the MAC key\n");
	fprintf(stdout, "-b, --blocksize\t\t set the block size to verify\n");
	fprintf(stdout, "-c, --sectorsize\t set the sector size to verify\n");
	fprintf(stdout, "-n, --numsectors\t set the sector size to verify\n");
	fprintf(stdout, "-w, --newdata\t write new data file\n");	
#ifdef THREADING
	fprintf(stdout, "-h, --numthreads\t number of threads, defaults to core count\n");
#endif
	fprintf(stdout, "-s, --silent\t\t silence all nonessential messages going to stdout\n");
#ifdef USE_S3
	fprintf(stdout, "-3, --s3\t\t use Amazon S3\n");
#endif
	
}

int assign_file_name(char *s){

	params.filename = s;
	params.filename_len = strlen(params.filename);
	if(params.filename_len == 0){
		PRINT_ERR("ERROR: No file selected.\n");
		usage();
		return 0;
	}
	if(params.filename_len >= MAXPATHLEN){
		PRINT_ERR("ERROR: File name is too long.\n");
		return 0;
	}
	return 1;
}


int main(int argc, char **argv){
	
	CPOR_challenge *challenge = NULL;
	CPOR_proof *proof = NULL;
	int i = -1;
	int opt = -1;
#ifdef USE_S3
	char tagfilepath[MAXPATHLEN];
	char tfilepath[MAXPATHLEN];
#endif	
#ifdef DEBUG_MODE
	struct timeval tv1, tv2;
	double values[26];
	
	memset(values, 0, sizeof(double) * 26);
#endif
	
	if(argc < 2){
		usage();
		exit(64);
	}
	
	/* Set default parameters */
	params.lambda = 80;						/* The security parameter lambda */

	params.prf_key_size = 20;				/* Size (in bytes) of an HMAC-SHA1 */
	params.enc_key_size = 32;				/* Size (in bytes) of the user's AES encryption key */
	params.mac_key_size = 20;				/* Size (in bytes) of the user's MAC key */

	params.block_size = 4096;				/* Message block size in bytes */				
	params.num_threads = 4;
	params.magic_num_challenge_blocks = params.lambda;	/* From the paper, a "conservative choice" for l is lamda, the number of bits to represent our group, Zp */

	params.filename = NULL;
	params.filename_len = 0;

	params.op = CPOR_OP_NOOP;

#ifdef USE_S3
	char *tmp;
	if((tmp = getenv("S3_ACCESS_KEY_ID")) == NULL) COND_PRINT("S3_ACCESS_KEY_ID variable not set");
	if((params.s3_access_key = malloc(strlen(tmp)+1)) == NULL) return -1;
	strcpy(params.s3_access_key, tmp);
	if((tmp = getenv("S3_SECRET_ACCESS_KEY")) == NULL) COND_PRINT("S3_SECRET_ACCESS_KEY variable not set");
	if((params.s3_secret_key = malloc(strlen(tmp)+1)) == NULL) return -1;
	strcpy(params.s3_secret_key, tmp);
	if((tmp = getenv("S3_HOSTNAME")) == NULL) COND_PRINT("S3_HOSTNAME variable not set");
	if((params.s3_hostname = malloc(strlen(tmp)+1)) == NULL) return -1;
	strcpy(params.s3_hostname, tmp);
#endif

	params.newdata = 0;

	while((opt = getopt_long(argc, argv, "swb:e:h:l:m:p:ktvy:", longopts, NULL)) != -1){
		switch(opt){
			case 'b':
				params.block_size = atoi(optarg);
				break;
			case 'e':
				params.enc_key_size = (unsigned int)atoi(optarg);
				if(params.enc_key_size != 16 && params.enc_key_size != 24 && params.enc_key_size != 32){
					PRINT_ERR("Invalid encryption key size.  Must be 16, 24 or 32 bytes.\n");
					return -1;
				}
				break;
			case 'w':
				params.newdata = 1;;
				break;
			case 'h':
				params.num_threads = atoi(optarg);
				break;
			case 'k':
				params.op = CPOR_OP_KEYGEN;
				break;
			case 'l':
				params.magic_num_challenge_blocks = atoi(optarg);
				break;
			case 'm':
				params.mac_key_size = atoi(optarg);
				break;
			case 'p':
				params.prf_key_size = atoi(optarg);
				break;
			case 's':
				params.silent = 1;
				break;
			case 't':
				params.op = CPOR_OP_TAG;
				break;
			case 'v':
				params.op = CPOR_OP_VERIFY;
				break;
			case 'y':
				params.lambda = atoi(optarg);
				break;				
			default:
				usage();
				exit(64);
		}
	}

	if(params.op == CPOR_OP_TAG || params.op == CPOR_OP_VERIFY)
		if(!assign_file_name(argv[optind]))
			return -1;


	/* The message sector size 1 byte smaller than the size of Zp so that it 
	 * is guaranteed to be an element of the group Zp */
	params.sector_size = ((params.Zp_bits/8) - 1);
	/* Number of sectors per block */
	params.num_sectors = ( (params.block_size/params.sector_size) + ((params.block_size % params.sector_size) ? 1 : 0) );
	/* The size (in bits) of the prime that creates the field Z_p */
	params.Zp_bits = params.lambda;



	CPOR_key *key = NULL;

	switch(params.op){
		case CPOR_OP_KEYGEN:
#ifdef DEBUG_MODE
			COND_PRINT("Using the following settings:\n");
			COND_PRINT("\tLambda: %u\n", params.lambda);
			COND_PRINT("\tPRF Key Size: %u bytes\n", params.prf_key_size);
			COND_PRINT("\tENC Key Size: %u bytes\n", params.enc_key_size);
			COND_PRINT("\tMAC Key Size: %u bytes\n", params.mac_key_size);
#endif
			COND_PRINT("Generating keys...");
			if(!(key = cpor_create_new_keys())) 
				COND_PRINT("Couldn't create keys\n");
			else 
				COND_PRINT("Done\n");
			/* I'm suspicious that we don't need the key later, and that it 
			 * may be scrubbed before this point. */
			destroy_cpor_key(key);
			break;
		
		case CPOR_OP_TAG:
time_it_init();
#ifdef DEBUG_MODE
			/* TODO: This is duplicate  code (location should be elsewhere) */
			if(!(key = cpor_create_new_keys())) 
				COND_PRINT("Couldn't create keys\n");
			else 
				COND_PRINT("Done\n");

			/* I'm suspicious that we don't need the key later, and that it 
			 * may be scrubbed before this point. */
			destroy_cpor_key(key);

			COND_PRINT("Using the following settings:\n");
			COND_PRINT("\tBlock Size: %u bytes\n", params.block_size);
			COND_PRINT("\tNumber of Threads: %u \n", params.num_threads);
#endif			
			COND_PRINT("Tagging %s...", params.filename); fflush(stdout);
#ifdef DEBUG_MODE
			gettimeofday(&tv1, NULL);
#endif
TIC;
			if(!cpor_tag_file(params.filename, params.filename_len, NULL, 0, NULL, 0)) 
				COND_PRINT("No tag\n");
			else 
				COND_PRINT("Done\n");
TOC("Create tag");
#ifdef DEBUG_MODE
			gettimeofday(&tv2, NULL);
			COND_PRINT("%lf\n", (double)( (double)(double)(((double)tv2.tv_sec) + (double)((double)tv2.tv_usec/1000000)) - (double)((double)((double)tv1.tv_sec) + (double)((double)tv1.tv_usec/1000000)) ) );
#endif

#ifdef USE_S3
			COND_PRINT("\tWriting file %s to S3...", params.filename);
TIC;
			if(!cpor_s3_put_file(params.filename, params.filename_len))
				COND_PRINT("Couldn't write %s to S3.\n", params.filename);
			else 
				COND_PRINT("Done.\n");
TOC("Put file to S3")

			memset(tagfilepath, 0, MAXPATHLEN);
			snprintf(tagfilepath, MAXPATHLEN, "%s.tag", params.filename);
			COND_PRINT("\tWriting tag file %s to S3...", tagfilepath); fflush(stdout);
TIC;
			if(!cpor_s3_put_file(tagfilepath, strlen(tagfilepath))) 
				COND_PRINT("Couldn't write %s.tag to S3.\n", params.filename);
			else 
				COND_PRINT("Done.\n");
TOC("Put tag to S3");

			memset(tfilepath, 0, MAXPATHLEN);
			snprintf(tfilepath, MAXPATHLEN, "%s.t", params.filename);
			COND_PRINT("\tWriting t file %s to S3...", tfilepath); 
TIC;
			if(!cpor_s3_put_file(tfilepath, strlen(tfilepath))) 
				COND_PRINT("Couldn't write %s.t to S3.\n", params.filename);
			else 
				COND_PRINT("Done.\n");			
TOC("Put t file to S3");
#endif
		/*
			break;
		*/	
			
		case CPOR_OP_VERIFY:
#ifdef DEBUG_MODE
			COND_PRINT("Using the following settings:\n");
			COND_PRINT("\tBlock Size: %u bytes\n", params.block_size);
			COND_PRINT("\tNumber of Threads: %u \n", params.num_threads);
			COND_PRINT("\tNumber of Challenge blocks: %u \n", params.magic_num_challenge_blocks);
#endif		
			COND_PRINT("Challenging file %s...\n", params.filename); fflush(stdout);				

#ifdef USE_S3
			COND_PRINT("\tGetting tag file...");
			memset(tagfilepath, 0, MAXPATHLEN);
			snprintf(tagfilepath, MAXPATHLEN, "%s.tag", params.filename);
			COND_PRINT("\tWriting tag file %s to S3...", tagfilepath);
TIC;
			if(!cpor_s3_get_file(tagfilepath, strlen(tagfilepath))) 
				COND_PRINT("Couldn't get tag file.\n");
			else 
				COND_PRINT("Done.\n");
TOC("Get tag from S3");

			COND_PRINT("\tGetting t file...");
			memset(tfilepath, 0, MAXPATHLEN);
			snprintf(tfilepath, MAXPATHLEN, "%s.t", params.filename);
TIC;
			if(!cpor_s3_get_file(tfilepath, strlen(tfilepath))) 
				COND_PRINT("Cloudn't get t file.\n");
			else 
				COND_PRINT("Done.\n");
TOC("Get t file from S3");
#endif

			COND_PRINT("\tCreating challenge for %s...", params.filename); 
TIC;
			challenge = cpor_challenge_file(params.filename, params.filename_len, NULL, 0);
			if(!challenge) 
				COND_PRINT("No challenge\n");
			else 
				COND_PRINT("Done.\n");
TOC("Create challenge");

			COND_PRINT("\tComputing proof...");
TIC;
#ifdef USE_S3
			proof = cpor_s3_prove_file(params.filename, params.filename_len, NULL, 0, challenge);
#else	
			proof = cpor_prove_file(params.filename, params.filename_len, NULL, 0, challenge);
#endif
TOC("Create proof");
			if(!proof)
				COND_PRINT("No proof\n");
			else 
				COND_PRINT("Done.\n");

			COND_PRINT("\tVerifying proof..."); 
TIC;
			if((i = cpor_verify_file(params.filename, params.filename_len, NULL, 0, challenge, proof)) == 1) 
				COND_PRINT("Verified\n");
			else if(i == 0) 
				COND_PRINT("Cheating!\n");
			else 
				PRINT_ERR("Error\n");
TOC("Verify file");

			if(challenge) destroy_cpor_challenge(challenge);
			if(proof) destroy_cpor_proof(proof);		
			break;

		case CPOR_OP_NOOP:
		default:
			break;
	}

	char meta[MAX_CSV_CELL] = {0};
	char *mode = NULL;
	if(params.newdata)
		mode = "w";
	else
		mode = "a";
	sprintf(meta, "CPOR:Block size %d:PRF key size %u:ENC key size %u:MAC key size %u:lambda %u:Zp bits %u:# challenge blocks %d:# threads %d:Filename %s",
		params.block_size, params.prf_key_size, params.enc_key_size,
		params.mac_key_size, params.lambda, params.Zp_bits,
		params.magic_num_challenge_blocks, params.num_threads, params.filename);

	TIME_IT_ADD_META(meta);
	time_it_write_csv(time_it_ptr, "./times-cpor", mode);	
	time_it_cleanup();

#ifdef USE_S3
	free(params.s3_access_key);
	free(params.s3_secret_key);
	free(params.s3_hostname);
#endif

	/* OpenSSL cleanup */
	EVP_cleanup();
	
	return 0;
	
}









/*
	unsigned char k_prf[CPOR_PRF_KEY_SIZE];
	unsigned char block[CPOR_BLOCK_SIZE];
	CPOR_global *global = NULL;
	CPOR_tag *tag;
	BIGNUM **alpha = NULL;

	printf("Blocksize: %d Sector size: %d Num sectors: %d\n", CPOR_BLOCK_SIZE, CPOR_SECTOR_SIZE, CPOR_NUM_SECTORS);
	
	global = cpor_create_global(CPOR_ZP_BITS);
	if(!global) printf("No global\n");
	
	RAND_bytes(k_prf, CPOR_PRF_KEY_SIZE);
	RAND_bytes(block, CPOR_BLOCK_SIZE);
	
	alpha = malloc(sizeof(BIGNUM *) * CPOR_NUM_SECTORS);
	memset(alpha, 0, sizeof(BIGNUM *) * CPOR_NUM_SECTORS);
	
	for(i = 0; i < CPOR_NUM_SECTORS; i++){
		alpha[i] = BN_new();
		BN_rand_range(alpha[i], global->Zp);
	}
	
	tag = cpor_tag_block(global, k_prf, alpha, block, CPOR_BLOCK_SIZE, 0);
	if(!tag) printf("No tag\n");
	
	
	challenge = cpor_create_challenge(global, 1);
	if(!challenge) printf("No challenge\n");
		
	proof = cpor_create_proof_update(global, challenge, proof, tag, block, CPOR_BLOCK_SIZE, 0);
	if(!proof) printf("No proof\n");
	
	if(( i = cpor_verify_proof(global, proof, challenge, k_prf, alpha)) == 1 ) printf("Verified!\n");
	else if (i == 0) printf("Cheating!\n");
	else printf("Error!\n");
	
	for(i = 0; i < CPOR_NUM_SECTORS; i++){
		if(alpha[i]) BN_clear_free(alpha[i]);
	}
	sfree(alpha, sizeof(BIGNUM *) * CPOR_NUM_SECTORS);
	
	destroy_cpor_global(global);
	destroy_cpor_tag(tag);
	destroy_cpor_challenge(challenge);
	destroy_cpor_proof(proof);
*/
