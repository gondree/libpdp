/* 
* sepdp-cpu.c
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

#include <unistd.h>
#include <getopt.h>

#include "sepdp.h"

SEPDP_params params;

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
  
	params.prf_key_size = 20;
	params.prp_key_size = 16;
	params.ae_key_size = 16;
	params.block_size = 4096;
	params.magic_num_challenge_blocks = 512;
	params.year = 1;
	params.min = 525600;
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.silent = 0;

	int is_not_verified = -1; /* file has yet to be verified */

	SEPDP_challenge *challenge = NULL;
	SEPDP_proof *proof = NULL;
	SEPDP_key *key = NULL;
	int i = 0;
	int ret = 0;
	
	if(argc < 2){
		exit(64);
	}

	int s,numloops = atoi(argv[2]);

	if(!assign_file_name(argv[1]))
		return -1;

	const unsigned int sepdp_challenges = ((params.year * 365 * 24 * 60)/params.min);

	time_it_init();
TIC;
	key = sepdp_get_keys();
TOC("Get key");

	COND_PRINT("Tagging %s...", params.filename); 
	for(s = 0; s < numloops; s++) {
TIC;
		i = sepdp_setup_file(params.filename, params.filename_len, NULL, 0, sepdp_challenges, key);
TOC("Create tag");
	}

  	if(!i){
		COND_PRINT("Error\n");
	}else{
		COND_PRINT("Done\n");
	}

			
	COND_PRINT("Challenging file %s...\n", params.filename);
			
	COND_PRINT("\tCreating challenge %d for %s...", i, params.filename); 
	for(s = 0; s < numloops; s++) {
TIC;
		challenge = sepdp_challenge_file(params.filename, params.filename_len, 0, key);
TOC("Create challenge");		
	}

	if(!challenge){ 
		COND_PRINT("No challenge!\n"); 
		return -1;
	}else{
		COND_PRINT("Done.\n");
	}

	COND_PRINT("\tComputing proof...");
//TIC; Timing done inside function to disregard I/O cost
	for(s = 0; s < numloops; s++) {
		proof = sepdp_prove_file(params.filename, params.filename_len,  NULL, 0, challenge);
	}
//TOC("Create proof");

	if(!proof){ 
		COND_PRINT("No proof!\n"); 
		return -1;
	}else{
		COND_PRINT("Done.\n");
	}
	COND_PRINT("\tVerifying proof...");
	for(s = 0; s < numloops; s++) {
TIC;
		ret = sepdp_verify_file(proof, key);
TOC("Verify file");
	}
	if(ret == 0){ 
		is_not_verified = 0;
		COND_PRINT("Verified!\n");
	}else{
		COND_PRINT("Cheating!\n");
	}
	
	if(challenge) destroy_sepdp_challenge(challenge);
	if(proof) destroy_sepdp_proof(proof);
	if(key) destroy_sepdp_key(key);

	
	char meta[MAX_CSV_CELL] = {0};
	char *mode = NULL;
	if(params.newdata)
		mode = "w";
	else
		mode = "a";

	sprintf(meta, "SEPDP:Block size %d:PRF key size %u:PRP key size %u:AE key size %u:years %hu:minutes %hu:# challenge blocks %d:# threads %d:Filename %s",
		params.block_size, params.prf_key_size, params.prp_key_size,
		params.ae_key_size, params.year, params.min,
		params.magic_num_challenge_blocks, params.num_threads, params.filename);

	TIME_IT_ADD_META(meta);
	time_it_write_csv(time_it_ptr, "./times-sepdp", mode);	
	time_it_cleanup();


	return is_not_verified;
}
