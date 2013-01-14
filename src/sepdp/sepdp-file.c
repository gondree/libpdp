/* 
* sepdp-file.c
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

#include "sepdp.h"

/* Create t tokens */
int sepdp_setup_file(char *filepath, size_t filepath_len, char *tokenfilepath, size_t tokenfilepath_len, unsigned int t, SEPDP_key *key){
	
	//SEPDP_key *key = NULL;
	FILE *file = NULL;
	FILE *tokenfile = NULL;
	char realtokenfilepath[MAXPATHLEN];
	unsigned char *ki = NULL;
	unsigned char *ci = NULL;
	unsigned char **D = NULL;
	unsigned char *token_vi = NULL;
	unsigned char *AE_token_vi = NULL;
	unsigned char *mac = NULL;
	unsigned char *iv = NULL;
	unsigned int *indices = NULL;
	size_t ki_size = 0;
	size_t ci_size = 0;
	size_t token_vi_size = 0;
	size_t AE_token_vi_size = 0;
	size_t mac_size = 0;
	size_t iv_size = params.ae_key_size;
	unsigned int i = 0;
	unsigned int j = 0;
	unsigned int numfileblocks = 0;
	unsigned int r = 0;
	struct stat st;
	
	if(!filepath || !filepath_len || !t) return 0;
	
	file = fopen(filepath, "r");
	if(!file){
		PRINT_ERR("ERROR: Was unable to open %s\n", filepath);
		return 0;
	}
	
	memset(realtokenfilepath, 0, MAXPATHLEN);
	/* If no token file path is specified, add a .tok extension to the filepath */
	if(!tokenfilepath && (filepath_len < MAXPATHLEN - 5)){
		if( snprintf(realtokenfilepath, MAXPATHLEN, "%s.tok", filepath) >= MAXPATHLEN) goto cleanup;
	}else{
		memcpy(realtokenfilepath, tokenfilepath, tokenfilepath_len);
	}
	
	tokenfile = fopen(realtokenfilepath, "w");
	if(!tokenfile) goto cleanup;

	/* Calculate the number sepdp blocks in the file */
	if(stat(filepath, &st) < 0) goto cleanup;
	numfileblocks = (st.st_size/params.block_size);
	if(st.st_size%params.block_size)
		numfileblocks++;

	/* Calculate the numbe of sepdp blocks to challenge */
	if(numfileblocks < params.magic_num_challenge_blocks)
		r = numfileblocks;
	else
		r = params.magic_num_challenge_blocks;

	/* Allocate room for the selected data blocks */
	if((D = calloc(1, r * sizeof(unsigned char *))) == NULL) goto cleanup;
	for(i = 0; i < r; i++){
		if((D[i] = calloc(1, params.block_size)) == NULL) goto cleanup;
	}

	/* Allocate space for encrypted token and MAC, note these are max sizes, 
	 * actual sizes may differ, and are returned in pointers from encrypt_then_mac_token */
	if((AE_token_vi = calloc(1, params.block_size)) == NULL) goto cleanup;
	if((mac = calloc(1, EVP_MAX_MD_SIZE)) == NULL) goto cleanup; 
	if((iv = calloc(1, params.ae_key_size)) == NULL) goto cleanup; 

#if 0
	/* Create a new PRF, PRP and AE keys */
	key = generate_sepdp_key();
	if(!key) goto cleanup;
#endif

	/* Generate each of the t tokens */
	for(i = 0; i < t; i++){
		/* Generate the psuedo-random permutation key k_i */
		ki = generate_prf_f(key->W, i, &ki_size);
		if(!ki) goto cleanup;
		/* Generate the pseudo-random challenge nonce c_i */
		ci = generate_prf_f(key->Z, i, &ci_size);
		if(!ci) goto cleanup;
		/* Generate the block indices for this token */
		indices = generate_prp_g(ki, ki_size, numfileblocks, r);
		if(!indices) goto cleanup;
		
		/* Seek to start of data file */
		if(fseek(file, 0, SEEK_SET) < 0) goto cleanup;
		for(j = 0; j < r; j++){
			/* Seek to data block at indices[j] */
			if(fseek(file, (params.block_size * (indices[j])), SEEK_SET) < 0) goto cleanup;
			
			/* Read data block */
			fread(D[j], params.block_size, 1, file);
			if(ferror(file)) goto cleanup;				
		}
		
		token_vi = generate_H(ci, ci_size, D, r, &token_vi_size);
		
		//encrypt then MAC the token.
		encrypt_then_mac_token(key, token_vi, token_vi_size, AE_token_vi, &AE_token_vi_size, mac, &mac_size, iv, iv_size);

		/* Write the token 	*/
		fwrite(&i, sizeof(unsigned int), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(&iv_size, sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(iv, iv_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(&AE_token_vi_size, sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(AE_token_vi, AE_token_vi_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(&mac_size, sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fwrite(mac, mac_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		
		/* Cleanup */
		if(ki) sfree(ki, ki_size);
		if(ci) sfree(ci, ci_size);
		if(token_vi) sfree(token_vi, token_vi_size);
		if(indices) sfree(indices, r * sizeof(unsigned int));
		memset(AE_token_vi, 0, AE_token_vi_size);
		memset(mac, 0, mac_size);
		for(j = 0; j < r; j++) memset(D[j], 0, params.block_size);	
	}


	//if(key) destroy_sepdp_key(key);
	if(AE_token_vi) sfree(AE_token_vi, AE_token_vi_size);
	if(mac) sfree(mac, mac_size);
	if(iv) sfree(iv, iv_size);
	if(file) fclose(file);
	if(tokenfile) fclose(tokenfile);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}

	return 1;

 cleanup:
	//if(key) destroy_sepdp_key(key);
	if(file) fclose(file);
	if(AE_token_vi) sfree(AE_token_vi, AE_token_vi_size);
	if(mac) sfree(mac, mac_size);
	if(iv) sfree(iv, iv_size);
	if(tokenfile) fclose(tokenfile);
	if(indices) sfree(indices, sizeof(unsigned int) * r);
	if(ki) sfree(ki, ki_size);
	if(ci) sfree(ci, ci_size);
	if(token_vi) sfree(token_vi, token_vi_size);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}
	
	return 0;
	
}

/* Challenge the ith token */
SEPDP_challenge *sepdp_challenge_file(char *filepath, size_t filepath_len, unsigned int i, SEPDP_key *key){
	
	//SEPDP_key *key = NULL;
	SEPDP_challenge *challenge = NULL;
	
	/* Allocate space for the challenge */
	challenge = generate_sepdp_challenge();
	if(!challenge) goto cleanup;
	
#if 0
	/* Get the PRF, PRP and AE keys for the file to challenge */
	key = sepdp_get_keys();
	if(!key) goto cleanup;
#endif

	/* Generate the psuedo-random permutation key k_i */
	challenge->ki = generate_prf_f(key->W, i, &(challenge->ki_size));
	if(!challenge->ki) goto cleanup;
	/* Generate the pseudo-random challenge nonce c_i */
	challenge->ci = generate_prf_f(key->Z, i, &(challenge->ci_size));
	if(!challenge->ci) goto cleanup;
	challenge->i = i;

	//if(key) destroy_sepdp_key(key);

	return challenge;
	
 cleanup:
	if(challenge) destroy_sepdp_challenge(challenge);
	//if(key) destroy_sepdp_key(key);

	return NULL;
}

SEPDP_proof *sepdp_prove_file(char *filepath, size_t filepath_len, char *tokenfilepath, size_t tokenfilepath_len, SEPDP_challenge *challenge){
	
	SEPDP_proof *proof = NULL;
	FILE *file = NULL;
	FILE *tokenfile = NULL;
	unsigned char **D = NULL;
	char realtokenfilepath[MAXPATHLEN];
	unsigned int numfileblocks = 0;
	unsigned int r = 0;
	unsigned int *indices = NULL;
	int i = 0, j = 0;
	struct stat st;
	
	if(!filepath || !filepath_len || !challenge) return NULL;
	
	proof = generate_sepdp_proof();
	if(!proof) goto cleanup;
	
	file = fopen(filepath, "r");
	if(!file){
		PRINT_ERR("ERROR: Was unable to open %s\n", filepath);
		return NULL;
	}
	
	memset(realtokenfilepath, 0, MAXPATHLEN);
	/* If no token file path is specified, add a .tok extension to the filepath */
	if(!tokenfilepath && (filepath_len < MAXPATHLEN - 5)){
		if( snprintf(realtokenfilepath, MAXPATHLEN, "%s.tok", filepath) >= MAXPATHLEN) goto cleanup;
	}else{
		memcpy(realtokenfilepath, tokenfilepath, tokenfilepath_len);
	}
	
	tokenfile = fopen(realtokenfilepath, "r");
	if(!tokenfile) goto cleanup;
	
	//TODO: This is cheating a little, unless the server has easy access to the entire file.  If not, this needs
	// to be changed to accomdate the specific storage service API for file size.
	/* Calculate the number sepdp blocks in the file */
	if(stat(filepath, &st) < 0) goto cleanup;
	numfileblocks = (st.st_size/params.block_size);
	if(st.st_size%params.block_size)
		numfileblocks++;

	/* Calculate the numbe of sepdp blocks to challenge */
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
		
	/* Seek to start of file */
	if(fseek(file, 0, SEEK_SET) < 0) goto cleanup;
	for(j = 0; j < r; j++){
		/* Seek to data block at indices[j] */
		if(fseek(file, (params.block_size * (indices[j])), SEEK_SET) < 0) goto cleanup;
			
		/* Read data block */
		fread(D[j], params.block_size, 1, file);
		if(ferror(file)) goto cleanup;				
	}
#ifdef CPU_TEST	
TIC;
	/* If we are testing throughput with no I/O, just run this again 
	 * to get the sum of non-I/O work in this funciton */
	generate_prp_g(challenge->ki, challenge->ki_size, numfileblocks, r);
#endif
	/* Do the hash */
	proof->z = generate_H(challenge->ci, challenge->ci_size, D, r, &(proof->z_size));
	if(!proof->z) goto cleanup;
#ifdef CPU_TEST
TOC("Create proof");
#endif
	
	/* Get the (encrypted) token to send back to the client */
	/* Seek to start of token file */
	if(fseek(tokenfile, 0, SEEK_SET) < 0) goto cleanup;
	for(j = 0; j < challenge->i + 1; j++){
		/* Read the token */
		fread(&i, sizeof(unsigned int), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;

		fread(&(proof->iv_size), sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fread(proof->iv, proof->iv_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;

		fread(&(proof->token_size), sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fread(proof->token, proof->token_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;

		fread(&(proof->mac_size), sizeof(size_t), 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
		fread(proof->mac, proof->mac_size, 1, tokenfile);
		if(ferror(tokenfile)) goto cleanup;
	}
	

	if(file) fclose(file);
	if(tokenfile) fclose(tokenfile);
	if(indices) sfree(indices, sizeof(unsigned int) * r);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}
	return proof;
	
 cleanup:
	if(file) fclose(file);
	if(tokenfile) fclose(tokenfile);
	if(proof) destroy_sepdp_proof(proof);
	if(indices) sfree(indices, sizeof(unsigned int) * r);
	if(D){
		for(i = 0; i < r; i++) sfree(D[i], params.block_size);
		sfree(D, r * sizeof(unsigned char *));
	}
	
	return NULL;
}

int sepdp_verify_file(SEPDP_proof *proof, SEPDP_key *key){

	int ret = 0;
	unsigned char plaintext[SHA_DIGEST_LENGTH] = {0};
	size_t plaintext_size = 0;

	if(!proof) return -1;
	
	if(!decrypt_and_verify_token(key, proof->token, proof->token_size, plaintext, &plaintext_size, proof->mac, proof->mac_size, proof->iv)) return -1;
	
	if(proof->z_size != plaintext_size) return -1;

#ifdef DEBUG
	printf("z: ");
	printhex(proof->z, proof->z_size);
	printf("token: ");
	printhex(proof->token, proof->token_size);
#endif

	ret = memcmp(proof->z, plaintext, proof->z_size);

	return ret;
}

