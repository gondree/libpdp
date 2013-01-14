/* 
* por-app.c
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
#include "por.h"

static struct option longopts[] = {
	{"numchallenge", no_argument, NULL, 'l'},
	{"blocksize", no_argument, NULL, 'b'},
	{"newdata", no_argument, NULL, 'w'},
	{"numthreads", no_argument, NULL, 'h'},
	{"keygen", no_argument, NULL, 'k'}, //TODO optional argument for key location
	{"tag", no_argument, NULL, 't'},
	{"verify", no_argument, NULL, 'v'},
	{"silent", no_argument, NULL, 's'},
	{NULL, 0, NULL, 0}
};

POR_params params;

void usage(){

	fprintf(stdout, "por (proof of retrievability -- MAC-pdp) 1.0\n");
	fprintf(stdout, "Copyright (c) 2008 Zachary N J Peterson <znpeters@nps.edu>\n");
	fprintf(stdout, "This program comes with ABSOLUTELY NO WARRANTY.\n");
	fprintf(stdout, "This is free software, and you are welcome to redistribute it\n");
	fprintf(stdout, "under certain conditions.\n\n");
	fprintf(stdout, "usage: por [options] [file]\n\n");
	fprintf(stdout, "Commands:\n\n");
	fprintf(stdout, "-t, --tag [file]\t tag a file\n");
	fprintf(stdout, "-v, --verify [file]\t verify data possession\n");
	fprintf(stdout, "-b, --blocksize\t\t set the block size to verify\n");
	fprintf(stdout, "-l, --numchallenge\t number of blocks to verify\n");
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
	POR_challenge *challenge = NULL;
	struct stat statbuf;
	unsigned int numfileblocks = 0;
	unsigned char *block = NULL;
	unsigned char tag[SHA_DIGEST_LENGTH];
	char tagfilepath[MAXPATHLEN];
	int opt = -1;
	int i = 0;
	int is_not_verified = 0;

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

	if(argc < 2){
		usage();
		exit(64);
	}
	time_it_init();

	params.op = POR_OP_NOOP;

	/* Set default parameters */
	params.block_size = 4096;				/* Message block size in bytes */				
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.magic_num_challenge_blocks = 460;
	params.silent = 0;

	params.filename = NULL;
	params.filename_len = 0;
	params.newdata = 0;

	while((opt = getopt_long(argc, argv, "ktvwb:c:h:s", longopts, NULL)) != -1){
		switch(opt){
			case 't':
				params.op = POR_OP_TAG;
				break;
			case 'v':
				params.op = POR_OP_VERIFY;
				break;
			case 'w':
				params.newdata = 1;;
				break;
			case 'b':
				params.block_size = next_pow_2(atoi(optarg));
				params.block_size = (params.block_size <= 128) ? 256 : params.block_size; 
				break;
			case 'c':
				params.block_size = atoi(optarg);
				break;
			case 'h':
				params.num_threads = atoi(optarg);
				break;
			case 's':
				params.silent = 1;
				break;
			case '3':
				// Nothing for now
				break;
			default:
				usage();
				exit(64);
				break;
		}
	}

	if(!assign_file_name(argv[optind]))
		return -1;

    if((block = malloc(params.block_size)) == NULL)
		return -1;
	memset(block, 0, params.block_size);
	memset(tag, 0, SHA_DIGEST_LENGTH);
	memset(tagfilepath, 0, MAXPATHLEN);

	snprintf(tagfilepath, MAXPATHLEN, "%s.tag", params.filename);

	switch(params.op){
		/* Tag the file */
		case POR_OP_TAG:
			COND_PRINT("Blocksize: %d\nNumber of threads: %d\nNumber of challenges: %d\nFilename: %s\nTagging file...", 
				params.block_size, params.num_threads, params.magic_num_challenge_blocks, params.filename);
			
TIC;
			if(!por_tag_file(params.filename, params.filename_len, NULL, 0)) 
				PRINT_ERR("Tag error\n");
			else 
				COND_PRINT("Done.\n");
TOC("Create tag");

#ifdef USE_S3
			/* Write the file to S3 */
			COND_PRINT("Writing file to S3...");
TIC;
			if(!por_s3_write_file(params.filename, params.filename_len)) 
				PRINT_ERR("Couldn't write file to S3.\n");
			else 
				COND_PRINT("Done.\n");
TOC("Put file to S3");
			/* Write tag file to S3 */
			COND_PRINT("Writing tag to S3...");
TIC;
			if(!por_s3_write_file(tagfilepath, strlen(tagfilepath))) 
				PRINT_ERR("Couldn't write tag to S3.\n");	
			else 
				COND_PRINT("Done.\n");
TOC("Put tag to S3");
#endif
			//break;

		/* Verify the file */
		case POR_OP_VERIFY:
			/* Create the challenge */
			if(stat(params.filename, &statbuf) == -1) {
				PRINT_ERR("\nERROR: Failed to stat file %s: ", params.filename);
				perror(0);
				exit(-1);
			}
			numfileblocks = (statbuf.st_size/params.block_size);
			if(statbuf.st_size%params.block_size) 
				numfileblocks++;

			COND_PRINT("Creating challenge...");
TIC;
			challenge = por_create_challenge(numfileblocks);	
			if(!challenge){
				PRINT_ERR("Couldn't create challenge.\n"); 
				return -1;
			}
			else 
				COND_PRINT("Done.\n");
TOC("Create challenge");

			
			COND_PRINT("Challenging file...\n");
TIC;
			unsigned char *block_ptr, *tag_ptr;
			unsigned char *all_challenge_blocks = calloc(1, challenge->l * params.block_size);
			if(all_challenge_blocks == NULL) return -1;
			unsigned char *all_challenge_tags = NULL;
			size_t all_tags_len = 0;
#ifdef USE_S3
			COND_PRINT("Retrieving tags...");
			if(!s3_get_chunk(tagfilepath, strlen(tagfilepath), &all_challenge_tags, &all_tags_len, 0))
				PRINT_ERR("Couldn't get tags.\n");
			else  
				COND_PRINT("Done.\n");
#endif

			for(i = 0; i < challenge->l; i++){
				block_ptr = all_challenge_blocks + i * params.block_size;
#ifdef USE_S3
				
				if(!por_s3_get_block(params.filename, params.filename_len, block_ptr, params.block_size, challenge->I[i])) 
					PRINT_ERR("Couldn't get block from S3\n");
#else
				if(!get_por_block(params.filename, params.filename_len, block_ptr, params.block_size, challenge->I[i])) 
					PRINT_ERR("Couldn't get read block\n");
#endif
			}
TOC("Create proof");

TIC;
			for(i = 0; i < challenge->l; i++){
				block_ptr = all_challenge_blocks + i * params.block_size;
				tag_ptr = all_challenge_tags + sizeof(unsigned int) + (challenge->I[i] * (SHA_DIGEST_LENGTH + sizeof(unsigned int))); 
				if(!por_verify_block(params.filename, params.filename_len, block_ptr, params.block_size, challenge->I[i], tag_ptr, SHA_DIGEST_LENGTH)){
					is_not_verified = -1;
					break;
				}
			}
TOC("Verify file");

			if(is_not_verified)
				COND_PRINT("Didn't verify %d\n", challenge->I[i]); 
			else
				COND_PRINT("Verified!\n");

			sfree(all_challenge_blocks, challenge->l * params.block_size);
			sfree(block, params.block_size);

			if(challenge) 
				destroy_por_challenge(challenge);

			break;
		default:
			break;
	}

	char meta[MAX_CSV_CELL] = {0};
	char *mode = NULL;
	if(params.newdata)
		mode = "w";
	else
		mode = "a";
	sprintf(meta, "MAC-PDP:Block size %d:# challenges %d:# threads %d:Filename %s", 
		params.block_size, params.magic_num_challenge_blocks, 
		params.num_threads, params.filename);

	TIME_IT_ADD_META(meta);

	time_it_write_csv(time_it_ptr, "./times-por", mode);	
	time_it_cleanup();

#ifdef USE_S3
	free(params.s3_access_key);
	free(params.s3_secret_key);
	free(params.s3_hostname);
#endif

	return is_not_verified;
}
