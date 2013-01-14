/* 
* pdp-core.c
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

static struct option longopts[] = {
	{"blocksize", no_argument, NULL, 'b'},
	{"noepdp", no_argument, NULL, 'e'},
	{"gen-key", no_argument, NULL, 'g'}, //TODO optional argument for key location
	{"newdata", no_argument, NULL, 'w'},
	{"nosafeprimes", no_argument, NULL, 'i'},
	{"numchallenge", no_argument, NULL, 'l'},
	{"numthreads", no_argument, NULL, 'h'},
	{"prfkeysize", no_argument, NULL, 'f'},
	{"prpkeysize", no_argument, NULL, 'p'},
	{"rsakeysize", no_argument, NULL, 'r'},
	{"silent", no_argument, NULL, 's'},
	{"tag", no_argument, NULL, 't'},
	{"verify", no_argument, NULL, 'v'},
	{NULL, 0, NULL, 0}
};

PDP_params params;

void usage(){

	fprintf(stdout, "pdp (provable data possesion) 1.0\n");
	fprintf(stdout, "Copyright (c) 2008 Zachary N J Peterson <znpeters@nps.edu>\n");
	fprintf(stdout, "This program comes with ABSOLUTELY NO WARRANTY.\n");
	fprintf(stdout, "This is free software, and you are welcome to redistribute it\n");
	fprintf(stdout, "under certain conditions.\n\n");
	fprintf(stdout, "usage: pdp [options] [file]\n\n");
	fprintf(stdout, "Commands:\n\n");
	fprintf(stdout, "-t, --tag [file]\t tag a file\n");
	fprintf(stdout, "-v, --verify [file]\t verify data possession\n");
	fprintf(stdout, "-k, --gen-key\t\t generate a new PDP key pair\n");
	fprintf(stdout, "-b, --blocksize\t\t set the block size to verify\n");
	fprintf(stdout, "-e, --noepdp\t\t do not use more weaker protocol\n\t\t\t which only tests the sum of the blocks\n");
	fprintf(stdout, "-i, --nosafeprimes\t abandon provable security for\n\t\t\t faster key generation\n");
	fprintf(stdout, "-l, --numchallenge\t number of blocks to verify\n");
	fprintf(stdout, "-w, --newdata\t write new data file\n");	
#ifdef THREADING
	fprintf(stdout, "-h, --numthreads\t number of threads, defaults to core count\n");
#endif
	fprintf(stdout, "-f, --prfkeysize\t size of the PDP PRF key\n");
	fprintf(stdout, "-p, --prpkeysize\t size of the PDP PRP key\n");
	fprintf(stdout, "-r, --rsakeysize\t size of the PDP RSA key\n");
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

	params.op = PDP_OP_NOOP;

	int is_not_verified = -1; /* file has yet to be verified */
	int opt = -1;
	unsigned int numfileblocks = 0;
	struct stat st;
#ifdef USE_S3
	char tagfilepath[MAXPATHLEN];
#endif
#ifdef DEBUG_MODE
	struct timeval tv1, tv2;
#endif
	
	if(argc < 2){
		usage();
		exit(64);
	}


	while((opt = getopt_long(argc, argv, "b:ewf:h:ikl:p:r:stv3", longopts, NULL)) != -1){
		switch(opt){
			case 'k':
				OpenSSL_add_all_algorithms();
				key = pdp_create_new_keypair();
				if(key) destroy_pdp_key(key);
				EVP_cleanup();
				exit(0);
				break;
			case 't':
				params.op = PDP_OP_TAG;
				break;
			case 'w':
				params.newdata = 1;;
				break;
			case 'v':
				params.op = PDP_OP_VERIFY;
				break;
			case 'b':
				params.pdp_block_size = atoi(optarg);
				break;
			case 'e':
				params.use_e_pdp = 0;
				break;
			case 'i':
				params.use_safe_primes = 0;
				break;	
			case 'l':
				params.num_challenge = atoi(optarg);
				break;	
			case 'h':
				params.num_threads = atoi(optarg);	
				break;	
			case 'f':
				params.prf_key_size = atoi(optarg);	
				break;	
			case 'p':
				params.prp_key_size = atoi(optarg);	
				break;	
			case 'r':
				params.rsa_key_size = atoi(optarg);	
				break;	
			case 's':
				params.silent = 1;
				break;	
#ifdef USE_S3
			case '3':
				params.op = PDP_OP_S3;
				break;
#endif				
			default:
				printf("usage!\n");
				usage();
				exit(64);
		}
	}
	
	if(!assign_file_name(argv[optind])) 
		return -1;

	time_it_init();

	OpenSSL_add_all_algorithms();

	switch(params.op){
#if 0
		/* 
		 * Create tag for the file then exit 
		 */
		case PDP_OP_TAG:
			COND_PRINT("Tagging %s...\n", params.filename);
#ifdef DEBUG_MODE
			gettimeofday(&tv1, NULL);
#endif
			if(pdp_tag_file(params.filename, params.filename_len, NULL, 0))
				COND_PRINT("Done!\n");
#ifdef DEBUG_MODE
			gettimeofday(&tv2, NULL);
#endif
			/*
			EVP_cleanup();
			exit(0);
			break;
			*/
		/* 
		 * Verify that the file we tagged is the same 
		 */
		case PDP_OP_VERIFY:
			COND_PRINT("Verifying %s...\n", params.filename);

			/* Calculate the number pdp blocks in the file */
			stat(params.filename, &st);
			numfileblocks = (st.st_size/params.pdp_block_size);
			if(st.st_size%params.pdp_block_size)
				numfileblocks++;
			
			challenge = pdp_challenge_file(numfileblocks);
			if(!challenge){
				PRINT_ERR("No challenge\n");
				return -1;
			}
			key = pdp_get_pubkey();
			server_challenge = sanitize_pdp_challenge(challenge);
			proof = pdp_prove_file(params.filename, params.filename_len, NULL, 0, server_challenge, key);
#endif

#ifdef USE_S3
		/* 
		 * Tag the file, upload both tag and file, then get the tag and challenge it.
		 */
		case PDP_OP_S3:
			memset(tagfilepath, 0, MAXPATHLEN);
			
			snprintf(tagfilepath, MAXPATHLEN, "%s.tag", params.filename);
			
TIC;
			/* Get the PDP key */
			keypair = pdp_get_keypair();
			if(!keypair) PRINT_ERR("Couldn't get keypair\n");
TOC("Get key");

			COND_PRINT("Tagging %s...", params.filename);
TIC;
			if(pdp_tag_file(params.filename, params.filename_len, NULL, 0, keypair)) 
				COND_PRINT("Done.\n");
TOC("Create tag");
			
			COND_PRINT("Writing file %s to S3...", params.filename);
TIC;
			if(!pdp_s3_put_file(params.filename, params.filename_len)) 
				PRINT_ERR("Couldn't write %s to S3.\n", params.filename);
			else 
				COND_PRINT("Done.\n");
TOC("Put file to S3");
			
			COND_PRINT("Writing tag %s to S3...", params.filename);

TIC;
			if(!pdp_s3_put_file(tagfilepath, strlen(tagfilepath))) 
				PRINT_ERR("Couldn't write %s to S3.\n", params.filename);
			else 
				COND_PRINT("Done.\n");				
TOC("Put tag to S3");

			
			COND_PRINT("Verifying %s...\n\tCreating challenge %s...", params.filename, params.filename);

			/* Calculate the number pdp blocks in the file */
			stat(params.filename, &st);
			numfileblocks = (st.st_size/params.pdp_block_size);
			if(st.st_size%params.pdp_block_size)
				numfileblocks++;
			
TIC;
			challenge = pdp_challenge_file(numfileblocks, keypair);
TOC("Create challenge");

			if(!challenge) 
				PRINT_ERR("No challenge\n");

TIC;
			server_challenge = sanitize_pdp_challenge(challenge);
TOC("Sanitize challenge");
			
			COND_PRINT("Done.\n\tGetting tag file...");
	
			key = pdp_get_pubkey();
			COND_PRINT("\tComputing proof...");
TIC;
			proof = pdp_s3_prove_file(params.filename, params.filename_len, tagfilepath, strlen(tagfilepath), server_challenge, key);
TOC("Create proof");
#endif	
			break;

	}

	if(!proof) 
		PRINT_ERR("No proof\n");
TIC;
	if(pdp_verify_file(challenge, proof, keypair)){
		COND_PRINT("Verified!\n");
		is_not_verified = 0;
	}else{
		COND_PRINT("Cheating!\n");
	}
TOC("Verify file");
	
	destroy_pdp_key(key);
	destroy_pdp_key(keypair);
	destroy_pdp_challenge(challenge);
	destroy_pdp_challenge(server_challenge);
	destroy_pdp_proof(proof);
	EVP_cleanup();

#ifdef USE_S3
	free(params.s3_access_key);
	free(params.s3_secret_key);
	free(params.s3_hostname);
#endif

	char meta[MAX_CSV_CELL] = {0};
	char *mode = NULL;
	if(params.newdata)
		mode = "w";
	else
		mode = "a";
	sprintf(meta, "APDP:Block size %d:PRF key size %u:PRP key size %u:RSA key size %u:use E-PDP %hu:use safe primes %hu:# challenges %d:# threads %d:Filename %s",
		params.pdp_block_size, params.prf_key_size, params.prp_key_size,
		params.rsa_key_size, params.use_e_pdp, params.use_safe_primes,
		params.num_challenge, params.num_threads, params.filename);

	TIME_IT_ADD_META(meta);
	time_it_write_csv(time_it_ptr, "./times-pdp", mode);	
	time_it_cleanup();

#ifdef DEBUG_MODE
	printf("%lf\n", (double)( (double)(double)(((double)tv2.tv_sec) + (double)((double)tv2.tv_usec/1000000)) - (double)((double)((double)tv1.tv_sec) + (double)((double)tv1.tv_usec/1000000)) ) );
#endif

	return is_not_verified;
}

