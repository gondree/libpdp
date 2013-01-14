
/*
 * For testing proofs per minute at CPU saturation MAC-PDP
 */

#include <time_it.h>
#include "por.h"

POR_params params;

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
	POR_challenge *challenge = NULL;
	struct stat statbuf;
	unsigned int numfileblocks = 0;
	unsigned char *block = NULL;
	unsigned char tag[SHA_DIGEST_LENGTH];
	char tagfilepath[MAXPATHLEN];
	//int opt = -1;
	int i = 0, t = 0;
	int is_not_verified = 0;

	if(argc < 2) {
		exit(64);
	}
	time_it_init();

	/* Set default parameters */
	params.block_size = 4096;				/* Message block size in bytes */				
	params.num_threads = sysconf(_SC_NPROCESSORS_ONLN); /* default to the number of processors */
	params.magic_num_challenge_blocks = 460;
	params.silent = 1;

	params.filename = NULL;
	params.filename_len = 0;
	params.newdata = 0;

	int numloops = atoi(argv[2]);

	if(!assign_file_name(argv[1]))
		return -1;

    if((block = malloc(params.block_size)) == NULL)
		return -1;
	memset(block, 0, params.block_size);
	memset(tag, 0, SHA_DIGEST_LENGTH);
	memset(tagfilepath, 0, MAXPATHLEN);

	snprintf(tagfilepath, MAXPATHLEN, "%s.tag", params.filename);

	COND_PRINT("Blocksize: %d\nNumber of threads: %d\nNumber of challenges: %d\nFilename: %s\nTagging file...", 
		params.block_size, params.num_threads, params.magic_num_challenge_blocks, params.filename);
	
	/* Tagging */
	for(t = 0; t < numloops; t++){
TIC;
		if(!por_tag_file(params.filename, params.filename_len, NULL, 0)) 
			PRINT_ERR("Tag error\n");
		else 
			;//COND_PRINT("Done.\n");
TOC("Create tag");
	}

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

	for(t = 0; t < numloops; t++){
TIC;
		challenge = por_create_challenge(numfileblocks);	
TOC("Create challenge");
	}

	if(!challenge){
		PRINT_ERR("Couldn't create challenge.\n"); 
		return -1;
	}
	else 
		COND_PRINT("Done.\n");

	COND_PRINT("Challenging file...");

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
#else
	if(stat(tagfilepath, &statbuf) == -1) {
		PRINT_ERR("\nERROR: Failed to stat file %s: ", params.filename);
		perror(0);
		exit(-1);
	}
	all_tags_len = statbuf.st_size;
	all_challenge_tags = calloc(1, all_tags_len);
	if(all_challenge_tags == NULL) return -1;
	/* read in the whole tag file */
	if(!get_por_block(tagfilepath, strlen(tagfilepath), all_challenge_tags, all_tags_len, 0)) 
		PRINT_ERR("Couldn't get tag\n");
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
	for(t = 0; t < numloops; t++){
TIC;
// Eliminating I/O leaves us with nothing to measure
TOC("Create proof");
	}

	for(t = 0; t < numloops; t++){
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
	}

	if(is_not_verified)
		COND_PRINT("Didn't verify %d\n", challenge->I[i]); 
	else
		COND_PRINT("Verified!\n");

	sfree(block, params.block_size);

	if(challenge) 
		destroy_por_challenge(challenge);

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

	return is_not_verified;
}
