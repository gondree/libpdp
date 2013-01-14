/* 
* cpor.h
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

#ifndef __CPOR_H__
#define __CPOR_H__

#include <openssl/bn.h>
#include <openssl/hmac.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/aes.h>
#include <openssl/evp.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/param.h>
#include <sys/time.h>

#include <time_it.h>

#define DEBUG_MODE
//#define THREADING

/* Modes of operation */
#define CPOR_OP_NOOP 0x00
#define CPOR_OP_TAG 0x01
#define CPOR_OP_VERIFY 0x02
#define CPOR_OP_KEYGEN 0x03

//#define NUM_THREADS 4

//#define CPOR_LAMBDA 80 /* The security parameter lambda */
//#define CPOR_ZP_BITS CPOR_LAMBDA /* The size (in bits) of the prime that creates the field Z_p */

//#define CPOR_PRF_KEY_SIZE 20 /* Size (in bytes) of an HMAC-SHA1 */
//#define CPOR_ENC_KEY_SIZE 32 /* Size (in bytes) of the user's AES encryption key */
//#define CPOR_MAC_KEY_SIZE 20 /* Size (in bytes) of the user's MAC key */

//#define CPOR_BLOCK_SIZE 4096 //((CPOR_ZP_BITS/8) - 1) /* Message block size in bytes */

/* The sector size 1 byte smaller than the size of Zp so that it 
 * is guaranteed to be an element of the group Zp */
//#define CPOR_SECTOR_SIZE ((CPOR_ZP_BITS/8) - 1) /* Message sector size in bytes */

//#define CPOR_NUM_SECTORS ( (CPOR_BLOCK_SIZE/CPOR_SECTOR_SIZE) + ((CPOR_BLOCK_SIZE % CPOR_SECTOR_SIZE) ? 1 : 0) ) /* Number of sectors per block */

/* do loop per CERT PRE10-C */
//#define SILENT
#ifndef SILENT
#define COND_PRINT(...) do { if(!params.silent){ printf(__VA_ARGS__); fflush(stdout); } }while(0)
#else
#define COND_PRINT(...) ;\

#endif

#define PRINT_ERR(x, ...) fprintf(stderr, "At %s:%d " x, __FILE__, __LINE__, ##__VA_ARGS__)

typedef struct CPOR_parameters_struct CPOR_params;

struct CPOR_parameters_struct{
	
	/* Parameters */
	unsigned int lambda;		/* The security parameter lambda */
	unsigned int Zp_bits;		/* The size (in bits) of the prime that creates the field Z_p */
	unsigned int prf_key_size;	/* Size (in bytes) of an HMAC-SHA1 */
	unsigned int enc_key_size;	/* Size (in bytes) of the user's AES encryption key */
	unsigned int mac_key_size;	/* Size (in bytes) of the user's MAC key */

	unsigned int block_size;	/* Message block size in bytes */
	unsigned int sector_size;	/* Message sector size in bytes */
	unsigned int num_sectors;	/* Number of sectors per block */
	unsigned int magic_num_challenge_blocks;	/* Number of blocks to challenge */
	
	unsigned int num_threads;	/* Number of tagging threads */
	
	char *filename;
	unsigned int filename_len;
	
	unsigned short newdata;
	unsigned int op;

	unsigned short silent;		/* Silence all messages */ 

#ifdef USE_S3
	char *s3_access_key;
	char *s3_secret_key;
	char *s3_hostname;
#endif
};

extern CPOR_params params;

/* Global settings */
typedef struct CPOR_global_struct CPOR_global;

struct CPOR_global_struct{
	BIGNUM *Zp;					/* The prime p that defines the field Zp */
};

/* This is the client's secret key */
typedef struct CPOR_key_struct CPOR_key;

struct CPOR_key_struct{
	unsigned char *k_enc;	/* The user's secret encryption key */
	size_t k_enc_size;		/* Encryption size in bytes */
	unsigned char *k_mac;	/* The user's secret MAC key */
	size_t k_mac_size;		/* MAC key size in bytes */
	CPOR_global *global;
};

typedef struct CPOR_tag_struct CPOR_tag;

struct CPOR_tag_struct{
	BIGNUM *sigma;			/* The resulting authenticator, sigma_i*/
	unsigned int index;		/* The index for the authenticator, i */
};

typedef struct CPOR_t_struct CPOR_t;

struct CPOR_t_struct{
	
	unsigned int n;			/* The number of blocks in the file */
	unsigned char *k_prf;	/* The randomly generated PRF key for this file */
	BIGNUM **alpha;
};


typedef struct CPOR_challenge_struct CPOR_challenge;

struct CPOR_challenge_struct{

	unsigned int l;			/* The number of elements to be tested */
	unsigned int *I;		/* An array of l indicies to be tested */
	BIGNUM **nu;			/* An array of l random elements */
	CPOR_global *global;
};

typedef struct CPOR_proof_struct CPOR_proof;

struct CPOR_proof_struct{
	BIGNUM *sigma;
	BIGNUM **mu;
};

/* File-level CPOR functions from cpor-file.c */
int cpor_tag_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, char *tfilepath, size_t tfilepath_len);

CPOR_challenge *cpor_challenge_file(char *filepath, size_t filepath_len, char *tfilepath, size_t tfilepath_len);

CPOR_proof *cpor_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, CPOR_challenge *challenge);

int cpor_verify_file(char *filepath, size_t filepath_len, char *tfilepath, size_t tfilepath_len, CPOR_challenge *challenge, CPOR_proof *proof);

CPOR_tag *read_cpor_tag(FILE *tagfile, unsigned int index);

/* Key management from cpor-keys.c */

CPOR_key *cpor_create_new_keys();

/* Core CPOR functions from cpor-core.c */
CPOR_global *cpor_create_global(unsigned int bits);

CPOR_tag *cpor_tag_block(CPOR_global *global, unsigned char *k_prf, BIGNUM **alpha, unsigned char *block, size_t blocksize, unsigned int index);

CPOR_challenge *cpor_create_challenge(CPOR_global *global, unsigned int n);

CPOR_proof *cpor_create_proof_update(CPOR_challenge *challenge, CPOR_proof *proof, CPOR_tag *tag, unsigned char *block, size_t blocksize, unsigned int index, unsigned int i);

CPOR_proof *cpor_create_proof_final(CPOR_proof *proof);

int cpor_verify_proof(CPOR_global *global, CPOR_proof *proof, CPOR_challenge *challenge, unsigned char *k_prf, BIGNUM **alpha);

/* Key functions from cpor-keys.c */
CPOR_key *cpor_get_keys();

void destroy_cpor_key(CPOR_key *key);

/* Helper functions from cpor-misc.c */

void sfree(void *ptr, size_t size);

int get_rand_range(unsigned int min, unsigned int max, unsigned int *value);

int sample_sans_replacement(unsigned int samp_sz, unsigned int pop_sz, unsigned int output[]);

size_t get_ciphertext_size(size_t plaintext_len);

size_t get_authenticator_size();

int decrypt_and_verify_secrets(CPOR_key *key, unsigned char *input, size_t input_len, unsigned char *plaintext, size_t *plaintext_len, unsigned char *authenticator, size_t authenticator_len);

int encrypt_and_authentucate_secrets(CPOR_key *key, unsigned char *input, size_t input_len, unsigned char *ciphertext, size_t *ciphertext_len, unsigned char *authenticator, size_t *authenticator_len);

CPOR_t *cpor_create_t(CPOR_global *global, unsigned int n);

BIGNUM *generate_prf_i(unsigned char *key, unsigned int index);

CPOR_proof *allocate_cpor_proof();
void destroy_cpor_proof(CPOR_proof *proof);

void destroy_cpor_challenge(CPOR_challenge *challenge);
CPOR_challenge *allocate_cpor_challenge(unsigned int l);

void destroy_cpor_tag(CPOR_tag *tag);
CPOR_tag *allocate_cpor_tag();

void destroy_cpor_t(CPOR_t *t);
CPOR_t *allocate_cpor_t();

void destroy_cpor_global(CPOR_global *global);
CPOR_global *allocate_cpor_global();

/* From cpor-s3.c */
#ifdef USE_S3
int cpor_s3_put_file(char *filepath, size_t filepath_len);
int cpor_s3_get_file(char *filepath, size_t filepath_len);
CPOR_proof *cpor_s3_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, CPOR_challenge *challenge);
#endif

#endif
