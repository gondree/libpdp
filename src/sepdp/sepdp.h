
/* 
* sepdp.h
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

#ifndef __SEPDP_H__
#define __SEPDP_H__

#include <limits.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <openssl/hmac.h>
#include <openssl/sha.h>
#include <openssl/aes.h>
#include <openssl/evp.h>
#include <openssl/rand.h>

#include <time_it.h>

//#define SEPDP_PRF_KEY_SIZE 20 /* Size (in bytes) of an HMAC-SHA1 */
//#define SEPDP_PRP_KEY_SIZE 16 /* Size (in bytes) of an AES key */
//#define SEPDP_AE_KEY_SIZE 16  /* Size (in bytes) of the authenticated encryption key */

//#define SEPDP_BLOCK_SIZE 4096

//#define SEPDP_YEAR 5 /* Number of years we want to challenge */
//#define SEPDP_MIN 60 /* Number of minutes we want to challenge a file */
//#define SEPDP_NUM_CHALLENGES ((SEPDP_YEAR * 365 * 24 * 60)/SEPDP_MIN)

/* 512 blocks gives you 99.4% chance of detecting an error */
//#define MAGIC_NUM_CHALLENGE_BLOCKS 512

/* do loop per CERT PRE10-C */
//#define SILENT
#ifndef SILENT 
#define COND_PRINT(...) do { if(!params.silent){ printf(__VA_ARGS__); fflush(stdout); } }while(0) 
#else
#define COND_PRINT(...) ; \

#endif 

#define PRINT_ERR(x, ...) fprintf(stderr, "At %s:%d " x, __FILE__, __LINE__, ##__VA_ARGS__)

//extern const unsigned int sepdp_challenges;

typedef struct SEPDP_parameters_struct SEPDP_params;

struct SEPDP_parameters_struct{
	
	/* Parameters */
	unsigned int block_size;	/* Message block size in bytes */

	unsigned int prf_key_size; 	/* Size (in bytes) of an HMAC-SHA1 */
	unsigned int prp_key_size; 	/* Size (in bytes) of an AES key */
	unsigned int ae_key_size; 	/* Size (in bytes) of the authenticated encryption key */

	unsigned int year;
	unsigned int min;
	
	unsigned int magic_num_challenge_blocks;	/* Number of blocks to challenge */
	
	unsigned int num_threads;	/* Number of tagging threads */

	unsigned short newdata;
	
	char *filename;
	unsigned int filename_len;

	unsigned short silent;		/* Silence all messages */ 

#ifdef USE_S3
	char *s3_access_key;
	char *s3_secret_key;
	char *s3_hostname;
#endif
};

extern SEPDP_params params;

typedef struct SEPDP_key_struct SEPDP_key;

struct SEPDP_key_struct{

	unsigned char *W;
	size_t W_size;
	unsigned char *Z;
	size_t Z_size;
	unsigned char *K;
	size_t K_size;

};

typedef struct SEPDP_challenge_struct SEPDP_challenge;

struct SEPDP_challenge_struct{

	unsigned int i;
	unsigned char *ki;
	size_t ki_size;
	unsigned char *ci;
	size_t ci_size;
};

typedef struct SEPDP_proof_struct SEPDP_proof;

struct SEPDP_proof_struct{

	size_t z_size;
	unsigned char *z;
	size_t iv_size;
	unsigned char *iv;
	size_t token_size;
	unsigned char *token;
	size_t mac_size;
	unsigned char *mac;
};

/* From sepdp-file.c */
int sepdp_setup_file(char *filepath, size_t filepath_len,  char *tokenfilepath, size_t tokenfilepath_len, unsigned int t, SEPDP_key *key);

SEPDP_challenge *sepdp_challenge_file(char *filepath, size_t filepath_len, unsigned int i, SEPDP_key *key);

SEPDP_proof *sepdp_prove_file(char *filepath, size_t filepath_len, char *tokenfilepath, size_t tokenfilepath_len, SEPDP_challenge *challenge);

int sepdp_verify_file(SEPDP_proof *proof, SEPDP_key *key);

/* From sepdp-key.c */
SEPDP_key *sepdp_get_keys();
SEPDP_key *generate_sepdp_key();
void destroy_sepdp_key(SEPDP_key *key);

/* From sepdp-misc.c */
void printhex(unsigned char *ptr, size_t size);

void sfree(void *ptr, size_t size);

int decrypt_and_verify_token(SEPDP_key *key, unsigned char *input, size_t input_len, unsigned char *plaintext, size_t *plaintext_len, unsigned char *authenticator, size_t authenticator_len, unsigned char *iv);

int encrypt_then_mac_token(SEPDP_key *key, unsigned char *input, size_t input_len, unsigned char *ciphertext, size_t *ciphertext_len, unsigned char *authenticator, size_t *authenticator_len, unsigned char *iv, size_t iv_size);

unsigned char *generate_prf_f(unsigned char *W, unsigned int i, size_t *prf_result_size);

unsigned int *generate_prp_g(unsigned char *ki, size_t ki_size, unsigned int d, unsigned int r);

unsigned char *generate_H(unsigned char *c_i, size_t c_i_len, unsigned char **D, unsigned int r, size_t *vi_len);

void destroy_sepdp_challenge(SEPDP_challenge *challenge);
SEPDP_challenge *generate_sepdp_challenge();

void destroy_sepdp_proof(SEPDP_proof *proof);
SEPDP_proof *generate_sepdp_proof();

/* From sepdp-s3.c */
#ifdef USE_S3
int sepdp_s3_put_file(char *filepath, size_t filepath_len);
int sepdp_s3_get_file(char *filepath, size_t filepath_len);
SEPDP_proof *sepdp_s3_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, SEPDP_challenge *challenge);
#endif

#endif
