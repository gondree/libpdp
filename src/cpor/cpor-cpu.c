/* 
* cpor-cpu.c
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

#include "cpor.h"

CPOR_params params;

int assign_file_name(char *s){

	params.filename = s;
	params.filename_len = strlen(params.filename);
	if(params.filename_len == 0){
		PRINT_ERR("ERROR: No file selected.\n");
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
	
	if(argc < 2){
		exit(64);
	}
	
	/* Set default parameters */
	params.lambda = 80;						/* The security parameter lambda */

	params.prf_key_size = 20;				/* Size (in bytes) of an HMAC-SHA1 */
	params.enc_key_size = 32;				/* Size (in bytes) of the user's AES encryption key */
	params.mac_key_size = 20;				/* Size (in bytes) of the user's MAC key */

	params.block_size = 4096;				/* Message block size in bytes */				
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.magic_num_challenge_blocks = params.lambda;	/* From the paper, a "conservative choice" for l is lamda, the number of bits to represent our group, Zp */

	params.filename = NULL;
	params.filename_len = 0;

	params.newdata = 0;
	params.silent = 1;
	
	int s, numloops = atoi(argv[2]);
	

	if(!assign_file_name(argv[1]))
		return -1;

	/* The message sector size 1 byte smaller than the size of Zp so that it 
	 * is guaranteed to be an element of the group Zp */
	params.sector_size = ((params.Zp_bits/8) - 1);
	/* Number of sectors per block */
	params.num_sectors = ( (params.block_size/params.sector_size) + ((params.block_size % params.sector_size) ? 1 : 0) );
	/* The size (in bits) of the prime that creates the field Z_p */
	params.Zp_bits = params.lambda;

	CPOR_key *key = NULL;

	COND_PRINT("Using the following settings:\n");
	COND_PRINT("\tLambda: %u\n", params.lambda);
	COND_PRINT("\tPRF Key Size: %u bytes\n", params.prf_key_size);
	COND_PRINT("\tENC Key Size: %u bytes\n", params.enc_key_size);
	COND_PRINT("\tMAC Key Size: %u bytes\n", params.mac_key_size);
	COND_PRINT("\tNumber of Challenge blocks: %u \n", params.magic_num_challenge_blocks);
	COND_PRINT("\tBlock Size: %u bytes\n", params.block_size);
	COND_PRINT("\tNumber of Threads: %u \n", params.num_threads);

	time_it_init();

	COND_PRINT("Generating keys...");

	for(s = 0; s < numloops; s++) {
		key = cpor_create_new_keys();
	}

	if(!key) 
		COND_PRINT("Couldn't create keys\n");
	else 
		COND_PRINT("Done\n");

	/* I'm suspicious that we don't need the key later, and that it 
	 * may be scrubbed before this point. */
	destroy_cpor_key(key);

	COND_PRINT("Tagging %s...", params.filename); fflush(stdout);
	for(s = 0; s < numloops; s++) {
TIC;
		i = cpor_tag_file(params.filename, params.filename_len, NULL, 0, NULL, 0);
TOC("Create tag");
	}

	if(!i) 
		COND_PRINT("No tag\n");
	else 
		COND_PRINT("Done\n");

	
	COND_PRINT("Challenging file %s...\n", params.filename); fflush(stdout);				

	COND_PRINT("\tCreating challenge for %s...", params.filename); 
	
	for(s = 0; s < numloops; s++) {
TIC;
		challenge = cpor_challenge_file(params.filename, params.filename_len, NULL, 0);
TOC("Create challenge");
	}
		if(!challenge) 
			COND_PRINT("No challenge\n");
		else 
			COND_PRINT("Done.\n");

	COND_PRINT("\tComputing proof...");
	for(s = 0; s < numloops; s++) {	
//TIC;
		proof = cpor_prove_file(params.filename, params.filename_len, NULL, 0, challenge);
//TOC("Create proof");
	}
	if(!proof)
		COND_PRINT("No proof\n");
	else 
		COND_PRINT("Done.\n");


	COND_PRINT("\tVerifying proof..."); 

	for(s = 0; s < numloops; s++) {	
TIC;
		i = cpor_verify_file(params.filename, params.filename_len, NULL, 0, challenge, proof);
TOC("Verify file");
	}
	if(i == 1) 
		COND_PRINT("Verified\n");
	else if(i == 0) 
		COND_PRINT("Cheating!\n");
	else 
		PRINT_ERR("Error\n");



	if(challenge) destroy_cpor_challenge(challenge);
	if(proof) destroy_cpor_proof(proof);		


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
