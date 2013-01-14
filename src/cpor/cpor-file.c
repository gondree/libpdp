/* 
* cpor-file.c
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
#ifdef THREADING
#include <pthread.h>
#endif

static int write_cpor_tag(FILE *tagfile, CPOR_tag *tag){
	
	unsigned char *sigma = NULL;
	size_t sigma_size = 0;
	
	if(!tagfile || !tag) return 0;
	
	/* Write sigma (size of sigma, then sigma itself) */
	sigma_size = BN_num_bytes(tag->sigma);
	fwrite(&sigma_size, sizeof(size_t), 1, tagfile);
	if(ferror(tagfile)) goto cleanup;
	if( ((sigma = malloc(sigma_size)) == NULL)) goto cleanup;
	memset(sigma, 0, sigma_size);
	if(!BN_bn2bin(tag->sigma, sigma)) goto cleanup;
	fwrite(sigma, sigma_size, 1, tagfile);
	if(ferror(tagfile)) goto cleanup;
	
	/* write index */
	fwrite(&(tag->index), sizeof(unsigned int), 1, tagfile);
	if(ferror(tagfile)) goto cleanup;	
	
	if(sigma) sfree(sigma, sigma_size);
		
	return 1;
	
cleanup:
	if(sigma) sfree(sigma, sigma_size);
	return 0;
}

CPOR_tag *read_cpor_tag(FILE *tagfile, unsigned int index){

	CPOR_tag *tag = NULL;
	size_t sigma_size = 0;
	unsigned char *sigma = NULL;
	int i = 0;

	if(!tagfile) return NULL;
	
	/* Allocate memory */
	if( ((tag = allocate_cpor_tag()) == NULL)) goto cleanup;
	
	/* Seek to start of tag file */
	if(fseek(tagfile, 0, SEEK_SET) < 0) goto cleanup;
	
	/* Seek to tag offset index */
	for(i = 0; i < index; i++){
		fread(&sigma_size, sizeof(size_t), 1, tagfile);
		if(ferror(tagfile)) goto cleanup;
		if(fseek(tagfile, (sigma_size + sizeof(unsigned int)), SEEK_CUR) < 0) goto cleanup;
	}
	
	/* Read in the sigma we're looking for */
	fread(&sigma_size, sizeof(size_t), 1, tagfile);
	if(ferror(tagfile)) goto cleanup;
	if( ((sigma = malloc(sigma_size)) == NULL)) goto cleanup;
	memset(sigma, 0, sigma_size);
	fread(sigma, sigma_size, 1, tagfile);
	if(ferror(tagfile)) goto cleanup;
	if(!BN_bin2bn(sigma, sigma_size, tag->sigma)) goto cleanup;
	
	/* read index */
	fread(&(tag->index), sizeof(unsigned int), 1, tagfile);
	if(ferror(tagfile)) goto cleanup;
	
	if(sigma) sfree(sigma, sigma_size);
	
	return tag;
	
cleanup:
	if(sigma) sfree(sigma, sigma_size);
	if(tag) destroy_cpor_tag(tag);
	
	return NULL;
}

static int write_cpor_t(FILE *tfile, CPOR_key *key, CPOR_t *t){
	
	unsigned char *enc_input = NULL;
	unsigned char *tbytes = NULL;
	unsigned char *t0 = NULL;
	unsigned char *t0_mac = NULL;
	unsigned char *alpha = NULL;
	size_t enc_input_size = 0;
	size_t tbytes_size = 0;
	size_t t0_size = 0;
	size_t t0_mac_size = 0;
	size_t alpha_size = 0;
	int i = 0;
	
	if(!tfile || !key || !t) return 0;

	/* Prepare to encrypt k_prf and alphas */ 
	enc_input_size = params.prf_key_size;
	if( ((enc_input = malloc(enc_input_size)) == NULL)) goto cleanup;
	memcpy(enc_input, t->k_prf, params.prf_key_size);

	for(i=0; i < params.num_sectors; i++){
		alpha_size = BN_num_bytes(t->alpha[i]);
		if( ((alpha = malloc(alpha_size)) == NULL)) goto cleanup;
		memset(alpha, 0, alpha_size);
		if(!BN_bn2bin(t->alpha[i], alpha)) goto cleanup;
		enc_input_size += sizeof(size_t) + alpha_size;
		if( ((enc_input = realloc(enc_input, enc_input_size)) == NULL)) goto cleanup;
		memcpy(enc_input + (enc_input_size - alpha_size - sizeof(size_t)), &alpha_size, sizeof(size_t));
		memcpy(enc_input + (enc_input_size - alpha_size), alpha, alpha_size);
		sfree(alpha, alpha_size);
	}

	/* t0_size is the size of our index, n, plus the resulting ciphertext */
	t0_size = sizeof(unsigned int) + get_ciphertext_size(enc_input_size);
	if( ((t0 = malloc(t0_size)) == NULL)) goto cleanup;
	memset(t0, 0, t0_size);
	/* Copy the number of blocks in the file into t0 */
	memcpy(t0, &(t->n), sizeof(unsigned int));
	
	t0_mac_size = get_authenticator_size();
	if( ((t0_mac = malloc(t0_mac_size)) == NULL)) goto cleanup;
	memset(t0_mac, 0, t0_mac_size);
	/* Encrypt and authenticate k_prf and alphas */
	if(!encrypt_and_authentucate_secrets(key, enc_input, enc_input_size, t0 + sizeof(unsigned int), &t0_size, t0_mac, &t0_mac_size))
		goto cleanup;
	/* Adjust size to account for index */
	t0_size += sizeof(unsigned int);


	/* Create t */
	tbytes_size = t0_size + sizeof(size_t) + t0_mac_size + sizeof(size_t);
	if( ((tbytes = malloc(tbytes_size)) == NULL)) goto cleanup;
	memcpy(tbytes, &t0_size, sizeof(size_t));
	memcpy(tbytes + sizeof(size_t), t0, t0_size);
	memcpy(tbytes + sizeof(size_t) + t0_size, &t0_mac_size, sizeof(size_t));
	memcpy(tbytes + sizeof(size_t) + t0_size + sizeof(size_t), t0_mac, t0_mac_size);

	fwrite(&tbytes_size, sizeof(size_t), 1, tfile);
	if(ferror(tfile)) goto cleanup;
	fwrite(tbytes, tbytes_size, 1, tfile);
	if(ferror(tfile)) goto cleanup;
	
	if(enc_input) sfree(enc_input, enc_input_size);
	if(tbytes) sfree(tbytes, tbytes_size);
	if(t0) sfree(t0, t0_size);
	if(t0_mac) sfree(t0_mac, t0_mac_size);
	
	return 1;
	
cleanup:
	if(enc_input) sfree(enc_input, enc_input_size);
	if(tbytes) sfree(tbytes, tbytes_size);
	if(t0) sfree(t0, t0_size);
	if(t0_mac) sfree(t0_mac, t0_mac_size);

	return 0;
}

static CPOR_t *read_cpor_t(FILE *tfile, CPOR_key *key){
	
	CPOR_t *t = NULL;
	unsigned char *tbytes = NULL;
	unsigned char *t0 = NULL;
	unsigned char *t0_mac = NULL;
	unsigned char *plaintext = NULL;
	unsigned char *ptp = NULL;
	unsigned char *alpha = NULL;
	size_t tbytes_size = 0;
	size_t t0_size = 0;
	size_t t0_mac_size = 0;
	size_t plaintext_size = 0;
	size_t alpha_size = 0;
	int i = 0;
	
	if(!tfile) return 0;
	
	if( ((t = allocate_cpor_t()) == NULL)) goto cleanup;
	
	/* Read t out of the file */
	fread(&tbytes_size, sizeof(size_t), 1, tfile);
	if(ferror(tfile)) goto cleanup;
	if( ((tbytes = malloc(tbytes_size)) == NULL)) goto cleanup;
	fread(tbytes, tbytes_size, 1, tfile);
	if(ferror(tfile)) goto cleanup;	



	/* Parse t */
	memcpy(&t0_size, tbytes, sizeof(size_t));
	if( ((t0 = malloc(t0_size)) == NULL)) goto cleanup;
	memcpy(t0, tbytes + sizeof(size_t), t0_size);
	memcpy(&t0_mac_size, tbytes + sizeof(size_t) + t0_size, sizeof(size_t));
	if( ((t0_mac = malloc(t0_mac_size)) == NULL)) goto cleanup;
	memcpy(t0_mac, tbytes + sizeof(size_t) + t0_size + sizeof(size_t), t0_mac_size);
	
	/* Verify and decrypt t0 */
	if( ((plaintext = malloc(t0_size)) == NULL)) goto cleanup;
	memset(plaintext, 0, t0_size);
	if(!decrypt_and_verify_secrets(key, t0 + sizeof(unsigned int), t0_size - sizeof(unsigned int), plaintext, &plaintext_size, t0_mac, t0_mac_size)) goto cleanup;
	
	/* Populate the CPOR_t struct */
	memcpy(&(t->n), t0, sizeof(unsigned int));
	ptp = plaintext;
	memcpy(t->k_prf, plaintext, params.prf_key_size);
	ptp += params.prf_key_size;
	for(i=0; i < params.num_sectors; i++){
		memcpy(&alpha_size, ptp, sizeof(size_t));
		ptp += sizeof(size_t);
		if( ((alpha = malloc(alpha_size)) == NULL)) goto cleanup;
		memset(alpha, 0, alpha_size);
		memcpy(alpha, ptp, alpha_size);
		ptp += alpha_size;
		if(!BN_bin2bn(alpha, alpha_size, t->alpha[i])) goto cleanup;
		sfree(alpha, alpha_size);
	}	

	if(plaintext) sfree(plaintext, plaintext_size);
	if(tbytes) sfree(tbytes, tbytes_size);
	if(t0) sfree(t0, t0_size);
	if(t0_mac) sfree(t0_mac, t0_mac_size);
	
	return t;
	
cleanup:
	if(plaintext) sfree(plaintext, plaintext_size);
	if(alpha) sfree(alpha, alpha_size);
	if(tbytes) sfree(tbytes, tbytes_size);
	if(t0) sfree(t0, t0_size);
	if(t0_mac) sfree(t0_mac, t0_mac_size);
	if(t) destroy_cpor_t(t);

	return NULL;
}

#ifdef THREADING

struct thread_arguments{

	FILE *file;		/* File to tag; a unique file descriptor to this thread */
	CPOR_key *key;	/* CPOR keys */
	CPOR_t *t;		/* Per-file secretes */
	int threadid;	/* The ID of the thread used to determine which blocks to tag */
	int numblocks;	/* The number blocks this thread needs to tag */
	CPOR_tag **tags;	/* Shared memory between threads used to store the result tags */
};

void *cpor_tag_thread(void *threadargs_ptr){

	CPOR_tag *tag = NULL;
	int block;
	int *ret = NULL;
	unsigned char buf[params.block_size];
	struct thread_arguments *threadargs = threadargs_ptr;
	int i = 0;
	
	if(!threadargs || !threadargs->file || !threadargs->tags || !threadargs->key || !threadargs->numblocks) goto cleanup;
	
	/* Allocate memory for return value - this should be freed by the checker */
	ret = malloc(sizeof(int));
	if(!ret) goto cleanup;
	*ret = 0;
	
	/* For N threads, read in and tag each Nth block */
	block = threadargs->threadid;
	for(i = 0; i < threadargs->numblocks; i++){
		memset(buf, 0, params.block_size);
		fseek(threadargs->file, block*params.block_size, SEEK_SET);
		fread(buf, params.block_size, 1, threadargs->file);
		if(ferror(threadargs->file))goto cleanup;
		//tag = cpor_tag_block(threadargs->key, buf, params.block_size, block);
		tag = cpor_tag_block(threadargs->key->global, threadargs->t->k_prf, threadargs->t->alpha, buf, params.block_size, block);
		if(!tag) goto cleanup;
		/* Store the tag in a buffer until all threads are done. Writer should destroy tags. */
		threadargs->tags[block] = tag;
		block += params.num_threads;
	}

	*ret = 1;
	pthread_exit(ret);

cleanup:
	pthread_exit(ret);
	
}

#endif 


/* cpor_tag_file:
*/
int cpor_tag_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, char *tfilepath, size_t tfilepath_len){

	CPOR_key *key = NULL;

	CPOR_t *t = NULL;
	FILE *file = NULL;
	FILE *tagfile = NULL;
	FILE *tfile = NULL;
	unsigned int numfileblocks = 0;
	unsigned int index = 0;
#ifndef DEBUG_MODE
	char yesorno = 0;
#endif
	char realtagfilepath[MAXPATHLEN];
	char realtfilepath[MAXPATHLEN];
	struct stat st;
#ifdef THREADING
	pthread_t threads[params.num_threads];
	int *thread_return = NULL;
	struct thread_arguments threadargs[params.num_threads];

	CPOR_tag **tags = NULL;

	memset(threads, 0, sizeof(pthread_t) * params.num_threads);
	memset(&st, 0, sizeof(struct stat));
#else
	unsigned char buf[params.block_size];
	CPOR_tag *tag = NULL;
#endif

	memset(realtagfilepath, 0, MAXPATHLEN);
	memset(realtfilepath, 0, MAXPATHLEN);

	if(!filepath) return 0;
	if(filepath_len >= MAXPATHLEN) return 0;
	if(tagfilepath_len >= MAXPATHLEN) return 0;
	if(tfilepath_len >= MAXPATHLEN) return 0;
	
	/* If no tag file path is specified, add a .tag extension to the filepath */
	if(!tagfilepath && (filepath_len < MAXPATHLEN - 5)){
		if( snprintf(realtagfilepath, MAXPATHLEN, "%s.tag", filepath) >= MAXPATHLEN ) goto cleanup;
	}else{
		memcpy(realtagfilepath, tagfilepath, tagfilepath_len);
	}
	
	/* If no t file path is specified, add a .t extension to the filepath */
	if(!tfilepath && (filepath_len < MAXPATHLEN - 3)){
		if( snprintf(realtfilepath, MAXPATHLEN, "%s.t", filepath) >= MAXPATHLEN ) goto cleanup;
	}else{
		memcpy(realtfilepath, tfilepath, tfilepath_len);
	}
	
	/* Check to see if the tag file exists */
#ifndef DEBUG_MODE
	if( (access(realtagfilepath, F_OK) == 0) || (access(realtfilepath, F_OK) == 0)){
		fprintf(stdout, "WARNING: Tag files for %s already exist; do you want to overwite (y/N)?", filepath);
		scanf("%c", &yesorno);
		if(yesorno != 'y') goto exit;
	}
#endif
	
	tagfile = fopen(realtagfilepath, "w");
	if(!tagfile){
		PRINT_ERR("ERROR: Was not able to create %s.\n", realtagfilepath);
		goto cleanup;
	}
	tfile = fopen(realtfilepath, "w");
	if(!tfile){
		PRINT_ERR("ERROR: Was not able to create %s.\n", realtfilepath);
		goto cleanup;
	}

	/* Get the CPOR keys */
	key = cpor_get_keys();
	if(!key) goto cleanup;

	/* Calculate the number cpor blocks in the file */
	if(stat(filepath, &st) < 0) return 0;
	numfileblocks = (st.st_size/params.block_size);
	if(st.st_size%params.block_size) numfileblocks++;
	
	/* Generate the per-file secrets */
	t = cpor_create_t(key->global, numfileblocks);
	if(!t) goto cleanup;

#ifdef THREADING

	/* Allocate buffer to hold tags until we write them out */
	if( ((tags = malloc( (sizeof(CPOR_tag *) * numfileblocks) )) == NULL)) goto cleanup;
	memset(tags, 0, (sizeof(CPOR_tag *) * numfileblocks));

	for(index = 0; index < params.num_threads; index++){
		/* Open a unique file descriptor for each thread to avoid race conditions */
		threadargs[index].file = fopen(filepath, "r");
		if(!threadargs[index].file) goto cleanup;
		threadargs[index].key = key;
		threadargs[index].t = t;		
		threadargs[index].threadid = index;
		threadargs[index].numblocks = (numfileblocks/params.num_threads);
		threadargs[index].tags = tags;
		
		/* If there is not an equal number of blocks to tag, add the extra blocks to
		 * the corresponding threads */
		if(index < (numfileblocks%params.num_threads))
			threadargs[index].numblocks++;
		/* If the thread has blocks to tag, spawn it */
		if(threadargs[index].numblocks > 0)
			if(pthread_create(&threads[index], NULL, cpor_tag_thread, (void *) &threadargs[index]) != 0) goto cleanup;
	}
	/* Check to see all tags were generated */
	for(index = 0; index < params.num_threads; index++){
		if(threads[index]){
			if(pthread_join(threads[index], (void **)&thread_return) != 0) goto cleanup;
			if(!thread_return || !(*thread_return))goto cleanup;
			else free(thread_return);
		}
	}
	
	/* Close the file */
	for(index = 0; index < params.num_threads; index++){
		if(threadargs[index].file)
			fclose(threadargs[index].file);
	}
	
	/* Write the tags out */
	for(index = 0; index < numfileblocks; index++){
		if(!tags[index]) goto cleanup;
		if(!write_cpor_tag(tagfile, tags[index])) goto cleanup;
		destroy_cpor_tag(tags[index]);
		tags[index] = NULL;
	}
	sfree(tags, (sizeof(CPOR_tag *) * numfileblocks));

#else
	/* Open the file for reading */
	file = fopen(filepath, "r");
	if(!file){
		PRINT_ERR("ERROR: Was not able to open %s for reading.\n", filepath);
		goto cleanup;
	}

	do{
		memset(buf, 0, params.block_size);
		fread(buf, params.block_size, 1, file);
		if(ferror(file)) goto cleanup;
		tag = cpor_tag_block(key->global, t->k_prf, t->alpha, buf, params.block_size, index);
		if(!tag) goto cleanup;
		if(!write_cpor_tag(tagfile, tag)) goto cleanup;
		index++;
		destroy_cpor_tag(tag);
	}while(!feof(file));
#endif

	/* Write t to the tfile */
	if(!write_cpor_t(tfile, key, t)) goto cleanup;

#ifndef DEBUG_MODE
exit:
#endif
	destroy_cpor_key(key);
	destroy_cpor_t(t);
	if(file) fclose(file);
	if(tagfile) fclose(tagfile);
	if(tfile) fclose(tfile);
	return 1;
	
cleanup:

	PRINT_ERR("ERROR: Was unable to create tag file.\n");
	if(key) destroy_cpor_key(key);	
	if(t) destroy_cpor_t(t);
	if(file) fclose(file);
	if(tagfile){ 
		ftruncate(fileno(tagfile), 0);
		unlink(realtagfilepath);
		fclose(tagfile);
	}
	if(tfile){ 
		ftruncate(fileno(tfile), 0);
		unlink(realtfilepath);
		fclose(tfile);
	}	
	return 0;
}

CPOR_challenge *cpor_challenge_file(char *filepath, size_t filepath_len, char *tfilepath, size_t tfilepath_len){

	CPOR_key *key = NULL;
	CPOR_challenge *challenge = NULL;
	FILE *tfile = NULL;
	CPOR_t *t = NULL;
	char realtfilepath[MAXPATHLEN];

	if(!filepath) return NULL;
	
	memset(realtfilepath, 0, MAXPATHLEN);
	
	/* If no t file path is specified, add a .t extension to the filepath */
	if(!tfilepath && (filepath_len < MAXPATHLEN - 3)){
		if( snprintf(realtfilepath, MAXPATHLEN, "%s.t", filepath) >= MAXPATHLEN ) goto cleanup;
	}else{
		memcpy(realtfilepath, tfilepath, tfilepath_len);
	}
	
	/* Open the t file for reading */
	tfile = fopen(realtfilepath, "r");
	if(!tfile){
		PRINT_ERR("ERROR: Was not able to open %s for reading.\n", realtfilepath);
		goto cleanup;
	}
	
	/* Get the CPOR keys */
	key = cpor_get_keys();
	if(!key) goto cleanup;
	
	/* Get t for n (the number of blocks) */
	t = read_cpor_t(tfile, key);
	if(!t){ PRINT_ERR("Could not get t.\n"); goto cleanup; }

	challenge = cpor_create_challenge(key->global, t->n);
	if(!challenge) goto cleanup;

	if(key) destroy_cpor_key(key);
	if(tfile) fclose(tfile);
	if(t) destroy_cpor_t(t);
	
	return challenge;

cleanup:
	if(key) destroy_cpor_key(key);
	if(tfile) fclose(tfile);
	if(t) destroy_cpor_t(t);
	return NULL;
	
}

CPOR_proof *cpor_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, CPOR_challenge *challenge){

	CPOR_tag *tag = NULL;
	CPOR_proof *proof = NULL;
	FILE *file = NULL;
	FILE *tagfile = NULL;
	char realtagfilepath[MAXPATHLEN];
	unsigned char block[params.block_size];
	unsigned char *file_blocks = NULL;
	CPOR_tag **all_tags_in_challenge = NULL;
	int i = 0;
	
	if(!filepath || !challenge) return 0;
	if(filepath_len >= MAXPATHLEN) return 0;
	if(tagfilepath_len >= MAXPATHLEN) return 0;
	
	memset(block, 0, params.block_size);
	memset(realtagfilepath, 0, MAXPATHLEN);	

	file = fopen(filepath, "r");
	if(!file){
		PRINT_ERR("ERROR: Was unable to open %s\n", filepath);
		return 0;
	}
	if((file_blocks = calloc(1, challenge->l * params.block_size)) == NULL) {
		PRINT_ERR("ERROR: Out of memory");
		goto cleanup;
	}
	for(i = 0; i < challenge->l; i++) {
		if(fseek(file, params.block_size * challenge->I[i], SEEK_SET) < 0) goto cleanup;
		fread(file_blocks + (i * params.block_size), 1, params.block_size, file);
		if(ferror(file)) goto cleanup;
	}
	
	/* If no tag file path is specified, add a .tag extension to the filepath */
	if(!tagfilepath && (filepath_len < MAXPATHLEN - 5)){
		if( snprintf(realtagfilepath, MAXPATHLEN, "%s.tag", filepath) >= MAXPATHLEN) goto cleanup;
	}else{
		memcpy(realtagfilepath, tagfilepath, tagfilepath_len);
	}
	
	tagfile = fopen(realtagfilepath, "r");
	if(!tagfile){
		PRINT_ERR("ERROR: Was unable to open %s\n", realtagfilepath);
		return 0;
	}
	/* Read in tags */
	tagfile = fopen(realtagfilepath, "r");
	if(!tagfile) goto cleanup;
	if((all_tags_in_challenge = calloc(1, sizeof(CPOR_tag*) * (challenge->l))) == NULL) {
		PRINT_ERR("ERROR: Out of memory");
		goto cleanup;
	}
	for(i = 0; i < challenge->l; i++) {
		if(!(all_tags_in_challenge[i] = read_cpor_tag(tagfile, challenge->I[i]))) goto cleanup;
	}
	
#ifdef CPU_TEST
TIC;
#endif
	for(i = 0; i < challenge->l; i++){
		proof = cpor_create_proof_update(challenge, proof, all_tags_in_challenge[i], file_blocks + (i * params.block_size), params.block_size, challenge->I[i], i);
		
		if(!proof) goto cleanup;
		
		destroy_cpor_tag(all_tags_in_challenge[i]);
		all_tags_in_challenge[i] = NULL;
	}
	
	proof = cpor_create_proof_final(proof);
#ifdef CPU_TEST
TOC("Create proof");
#endif
	
	if(file) fclose(file);
	if(tagfile) fclose(tagfile);

	return proof;

cleanup:
	if(file) fclose(file);
	if(tagfile) fclose(tagfile);
	if(tag) destroy_cpor_tag(tag);

	return NULL;
}

int cpor_verify_file(char *filepath, size_t filepath_len, char *tfilepath, size_t tfilepath_len, CPOR_challenge *challenge, CPOR_proof *proof){
	
	CPOR_key *key = NULL;
	CPOR_t *t = NULL;
	FILE *tfile = NULL;
	int ret = -1;
	char realtfilepath[MAXPATHLEN];
	
	if(!filepath || !challenge || !proof) return -1;
	
	memset(realtfilepath, 0, MAXPATHLEN);
	
	/* If no t file path is specified, add a .t extension to the filepath */
	if(!tfilepath && (filepath_len < MAXPATHLEN - 3)){
		if( snprintf(realtfilepath, MAXPATHLEN, "%s.t", filepath) >= MAXPATHLEN ) goto cleanup;
	}else{
		memcpy(realtfilepath, tfilepath, tfilepath_len);
	}
	
	/* Open the t file for reading */
	tfile = fopen(realtfilepath, "r");
	if(!tfile){
		PRINT_ERR("ERROR: Was not able to open %s for reading.\n", realtfilepath);
		goto cleanup;
	}
	
	/* Get the CPOR keys */
	key = cpor_get_keys();
	if(!key) goto cleanup;
	
	/* Get t */
	t = read_cpor_t(tfile, key);
	if(!t) goto cleanup;
	
	ret = cpor_verify_proof(challenge->global, proof, challenge, t->k_prf, t->alpha);

cleanup:
	if(key) destroy_cpor_key(key);
	if(t) destroy_cpor_t(t);
	fclose(tfile);
	
	return ret;
}
