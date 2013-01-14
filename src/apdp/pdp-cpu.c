/* 
* pdp-cpu.c
*
* Copyright (c) 2008, Zachary N J Peterson <zachary@jhu.edu>
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * The name of the Zachary N J Peterson may be used to endorse or promote products
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

/* pdp-app is a simple user interface providing the fundemental PDP file operations and
*  basic key management.  The application allows you to generate a PDP key pair, tag
*  files and challenge and verify files that have been tagged.
*/

#include "pdp.h"
#include <stdio.h>
#include <getopt.h>
#include <sys/param.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <unistd.h>

PDP_params params;

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

	PDP_key *key = NULL;
	PDP_key *keypair = NULL;
	PDP_challenge *challenge = NULL, *server_challenge = NULL;
	PDP_proof *proof = NULL;

	/* Set default params */
	params.prf_key_size = 20;
	params.prp_key_size = 16;
	params.rsa_key_size = 1024;
	params.pdp_block_size = 16384;
	params.num_challenge = 460;
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.silent = 0;
 	params.use_safe_primes = 1;
	params.use_e_pdp = 1;

	params.newdata = 0;

	int is_not_verified = -1; /* file has yet to be verified */
	unsigned int numfileblocks = 0;
	struct stat st;
	
	if(argc < 2){
		exit(64);
	}


	int i, s, numloops = atoi(argv[2]);
	if(!assign_file_name(argv[1])) 
		return -1;

	time_it_init();

	OpenSSL_add_all_algorithms();
TIC;
	/* Get the PDP key */
	keypair = pdp_get_keypair();
	if(!keypair) PRINT_ERR("Couldn't get keypair\n");
TOC("Get key");

	/* 
	 * Create tag for the file
	 */
	COND_PRINT("Tagging %s...\n", params.filename);
	for(s = 0; s < numloops; s++) {
TIC;
		i = pdp_tag_file(params.filename, params.filename_len, NULL, 0, keypair);
TOC("Create tag");
	}

	if(i)
		COND_PRINT("Done!\n");
	/* 
	 * Verify that the file we tagged is the same 
	 */
	COND_PRINT("Verifying %s...\n", params.filename);

	/* Calculate the number pdp blocks in the file */
	stat(params.filename, &st);
	numfileblocks = (st.st_size/params.pdp_block_size);
	if(st.st_size%params.pdp_block_size)
		numfileblocks++;

	for(s = 0; s < numloops; s++) {
TIC;			
		challenge = pdp_challenge_file(numfileblocks, keypair);
TOC("Create challenge");
	}

	if(!challenge){
		PRINT_ERR("No challenge\n");
		return -1;
	}
	key = pdp_get_pubkey();

	for(s = 0; s < numloops; s++) {
TIC;
		server_challenge = sanitize_pdp_challenge(challenge);
TOC("Sanitize challenge");
	}

/* Timing occurs inside this function to prevent I/O interferance */
	for(s = 0; s < numloops; s++) {
		proof = pdp_prove_file(params.filename, params.filename_len, NULL, 0, server_challenge, key);
	}
//TOC("Create proof");


	if(!proof) 
		PRINT_ERR("No proof\n");
	for(s = 0; s < numloops; s++) {
TIC;
		i = pdp_verify_file(challenge, proof, keypair);
TOC("Verify file");
	}

	if(i){
		COND_PRINT("Verified!\n");
		is_not_verified = 0;
	}else{
		COND_PRINT("Cheating!\n");
	}
	
	destroy_pdp_key(key);
	destroy_pdp_challenge(challenge);
	destroy_pdp_challenge(server_challenge);
	destroy_pdp_proof(proof);
	EVP_cleanup();

	char meta[MAX_CSV_CELL] = {0};
	char *mode = NULL;
	if(params.newdata)
		mode = "w";
	else
		mode = "a";

	sprintf(meta, "PDP:Block size %d:PRF key size %u:PRP key size %u:RSA key size %u:use E-PDP %hu:use safe primes %hu:# challenges %d:# threads %d:Filename %s",
		params.pdp_block_size, params.prf_key_size, params.prp_key_size,
		params.rsa_key_size, params.use_e_pdp, params.use_safe_primes,
		params.num_challenge, params.num_threads, params.filename);

	TIME_IT_ADD_META(meta);
	time_it_write_csv(time_it_ptr, "./times-pdp", mode);	
	time_it_cleanup();

	return is_not_verified;
}

