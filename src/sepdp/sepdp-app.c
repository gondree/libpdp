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

#include <unistd.h>
#include <getopt.h>

#include "sepdp.h"

static struct option longopts[] = {
	{"blocksize", no_argument, NULL, 'b'},
	{"newdata", no_argument, NULL, 'w'},
	{"numchallenge", no_argument, NULL, 'l'},
	{"prfkeysize", no_argument, NULL, 'f'},
	{"prpkeysize", no_argument, NULL, 'p'},
	{"aekeysize", no_argument, NULL, 'a'},
	{"", no_argument, NULL, 't'}, // make experiments simpler
	{"year", no_argument, NULL, 'y'},
	{"min", no_argument, NULL, 'm'},
	{"silent", no_argument, NULL, 's'},
	{NULL, 0, NULL, 0}
};

SEPDP_params params;

void usage(){

	fprintf(stdout, "sepdp (scalable and efficient provable data possesion) 1.0\n");
	fprintf(stdout, "Copyright (c) 2008 Zachary N J Peterson <znpeters@nps.edu>\n");
	fprintf(stdout, "This program comes with ABSOLUTELY NO WARRANTY.\n");
	fprintf(stdout, "This is free software, and you are welcome to redistribute it\n");
	fprintf(stdout, "under certain conditions.\n\n");
	fprintf(stdout, "usage: sepdp [options] [file]\n\n");
	fprintf(stdout, "Commands:\n\n");
	fprintf(stdout, "-b, --blocksize\t\t set the block size to verify\n");
	fprintf(stdout, "-l, --magicnumchallengeblocks\t number of blocks to verify\n");
	fprintf(stdout, "-f, --prfkeysize\t size of the SEPDP PRF key\n");
	fprintf(stdout, "-p, --prpkeysize\t size of the SEPDP PRP key\n");
	fprintf(stdout, "-a, --aekeysize\t\t size of the authenticated encryption key\n");
	fprintf(stdout, "-s, --silent\t\t silence all nonessential messages going to stdout\n");
	fprintf(stdout, "-y, --year\t\t number of years we want to challenge\n");
	fprintf(stdout, "-m, --min\t\t number of minutes we want to challenge\n");
	
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
  
	params.prf_key_size = 20;
	params.prp_key_size = 16;
	params.ae_key_size = 16;
	params.block_size = 4096;
	params.magic_num_challenge_blocks = 512;
	params.year = 5;
	params.min = 60;
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.silent = 0;

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

	int is_not_verified = -1; /* file has yet to be verified */

	SEPDP_challenge *challenge = NULL;
	SEPDP_proof *proof = NULL;
	SEPDP_key *key = NULL;

	int i = 0;
	int ret = 0;
	int opt = -1;
#ifdef USE_S3
	char tokenfilepath[MAXPATHLEN];
#endif	
	
	if(argc < 2){
		usage();
		exit(64);
	}

	while((opt = getopt_long(argc, argv, "tb:f:l:p:a:y:m:", longopts, NULL)) != -1){
		switch(opt){
			case 'a':
				params.ae_key_size = atoi(optarg);				
				break;
			case 'b':
				params.block_size = atoi(optarg);
				break;
			case 'f':
				params.prf_key_size = atoi(optarg);
				break;
			case 'l':
				params.magic_num_challenge_blocks = atoi(optarg);
				break;
			case 'p':
				params.prp_key_size = atoi(optarg);
				break;
			case 's':
				params.silent = 1;
				break;
			case 'y':
				params.year = atoi(optarg);
				break;
			case 'm':
				params.min = atoi(optarg);
			case 't':
				break;
			default:
				usage();
				exit(64);
				break;
		}
	}
	if(!assign_file_name(argv[optind]))
		return -1;
	const unsigned int sepdp_challenges = ((params.year * 365 * 24 * 60)/params.min);

	time_it_init();
	
TIC;
	key = sepdp_get_keys();
TOC("Get key");

TIC;
	COND_PRINT("Tagging %s...", params.filename); 
  	if(!sepdp_setup_file(params.filename, params.filename_len, NULL, 0, sepdp_challenges, key)){
		COND_PRINT("Error\n");
	}else{
		COND_PRINT("Done\n");
	}
TOC("Create tag");

#ifdef USE_S3
TIC;
	COND_PRINT("Writing file %s to S3...", params.filename); 
	if(!sepdp_s3_put_file(params.filename, params.filename_len)){
		COND_PRINT("Couldn't write %s to S3.\n", params.filename);
	}else{
		COND_PRINT("Done.\n");
	}
TOC("Put file to S3")

TIC;
	memset(tokenfilepath, 0, MAXPATHLEN);
	snprintf(tokenfilepath, MAXPATHLEN, "%s.tok", params.filename);
	COND_PRINT("Writing token file %s to S3...", tokenfilepath);
	if(!sepdp_s3_put_file(tokenfilepath, strlen(tokenfilepath))){
		COND_PRINT("Couldn't write %s to S3.\n", params.filename);
	}else{
		COND_PRINT("Done.\n");				
	}
TOC("Put tok to S3");
#endif
			
	COND_PRINT("Challenging file %s...\n", params.filename);
			
TIC;
	COND_PRINT("\tCreating challenge %d for %s...", i, params.filename); 
	challenge = sepdp_challenge_file(params.filename, params.filename_len, i, key);
	if(!challenge){
		COND_PRINT("No challenge!\n"); 
		return -1;
	}else{
		COND_PRINT("Done.\n");
	}
TOC("Create challenge");		

TIC;
	COND_PRINT("\tComputing proof...");
#ifdef USE_S3	
	proof = sepdp_s3_prove_file(params.filename, params.filename_len,  NULL, 0, challenge);
#else
	proof = sepdp_prove_file(params.filename, params.filename_len,  NULL, 0, challenge);
#endif
TOC("Create proof");

	if(!proof){ 
		COND_PRINT("No proof!\n"); 
		return -1;
	}else{
		COND_PRINT("Done.\n");
	}
	COND_PRINT("\tVerifying proof...");
TIC;
	ret = sepdp_verify_file(proof, key);
TOC("Verify file");
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

#ifdef USE_S3
	free(params.s3_access_key);
	free(params.s3_secret_key);
	free(params.s3_hostname);
#endif

	return is_not_verified;
}
