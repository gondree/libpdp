
/* 
* pdp.h
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

#ifndef __PDP_H__
#define __PDP_H__

#include <openssl/bn.h>
#include <openssl/hmac.h>
#include <openssl/rand.h>
#include <openssl/rsa.h>
#include <openssl/sha.h>
#include <string.h>

#include <time_it.h>

#define DEBUG_MODE

/* Using safe primes is required if you want PDP to be provably secure.  
 * Key generation is slower as a side effect */
//#define USE_SAFE_PRIMES

/* If USE_E_PDP is defined, the protocol is more efficient but offers
 * weaker guarantees of possesion; only a possesion of the sum of file blocks.
 * In general, however, this is practically secure as long as the number of 
 * sampled blocks is high. */
//#define USE_E_PDP

/* Tagging is "embarrassingly" parallelizable as each tag can be calculated
 * independenlty.  During tagging, N threads can be spawned, dividing the file
 * into N sections.  Each thread processes every Nth block of a file */
//#define THREADING

/* TODO: This should probably be set by autoconf based on some proc variables */
/* The number of threads should be about the number of cores a processor has.
 * Processing is the bottleneck in tagging, so launching more than the number of
 * of cores won't achieve much, if any, speedup. */
//#ifdef THREADING
//#define NUM_THREADS 2
//#endif

//#define PRF_KEY_SIZE 20
//#define PRP_KEY_SIZE 16
//#define RSA_KEY_SIZE 1024
#define RSA_E RSA_F4

//#define PDP_BLOCKSIZE 16384 /* 16Kbytes */

/* 460 blocks gives you 99% chance of detecting an error, 300 blocks givers you 95% chance*/
//#define MAGIC_NUM_CHALLENGE_BLOCKS 460

#define PDP_OP_NOOP 0x00
#define PDP_OP_TAG 0x01
#define PDP_OP_VERIFY 0x02
#define PDP_OP_S3 0x03

/* do loop per CERT PRE10-C */
//#define SILENT
#ifndef SILENT
#define COND_PRINT(...) do { if(!params.silent){ printf(__VA_ARGS__); fflush(stdout); } }while(0) 
#else
#define COND_PRINT(...) ;\

#endif

#define PRINT_ERR(x, ...) fprintf(stderr, "At %s:%d " x, __FILE__, __LINE__, ##__VA_ARGS__)


typedef struct PDP_parameters_struct PDP_params;

struct PDP_parameters_struct{
	
	/* Parameters */
	unsigned int pdp_block_size;	/* Message block size in bytes */
	unsigned int prf_key_size;
	unsigned int prp_key_size;
	unsigned int rsa_key_size;

	unsigned short use_e_pdp;
	unsigned short use_safe_primes;
	
	unsigned int num_challenge;	/* Number of blocks to challenge */
	
	unsigned int num_threads;	/* Number of tagging threads */
	
	char *filename;
	unsigned int filename_len;
	unsigned short newdata;
	unsigned short op;			/* The current operation */

	unsigned short silent;		/* Silence all messages */ 

#ifdef USE_S3
	char *s3_access_key;
	char *s3_secret_key;
	char *s3_hostname;
#endif
};

extern PDP_params params;

typedef BIGNUM PDP_generator;

typedef struct PDP_key_struct PDP_key;

struct PDP_key_struct{
	
	RSA *rsa;			/* RSA key pair */
	unsigned char *v;	/* PRF key */
	PDP_generator *g;	/* PDP generator */

};

typedef struct PDP_tag_struct PDP_tag;

struct PDP_tag_struct{
	
	BIGNUM *Tim;			/* The tag of the message block i T_i,m = (h(W_i) * g^m)^d */
	unsigned int index;     /* The index of the block, i */
	unsigned char *index_prf; /* The pseudo-random function output of the index W_i = w_v(i) */
	size_t index_prf_size;	/* The size of the prf output */

};


typedef struct PDP_challenge_struct PDP_challenge;

struct PDP_challenge_struct{

	unsigned int c;     /* Number of blocks to sample */
	unsigned int numfileblocks; /* Number of total blocks in the file */
	BIGNUM *g_s;		/* Random secret base g_s = g^s */
	BIGNUM *s;			/* Random secret */
	unsigned char *k1;	/* PRP key */
	unsigned char *k2;	/* PRF key */
};

typedef struct PDP_proof_struct PDP_proof;

struct PDP_proof_struct{
	
	BIGNUM *T;			/* The product of tags, T */
	BIGNUM *rho_temp;	/* A running tally of rho */
	unsigned char *rho;	/* Final rho */
	size_t rho_size;	/* size of the final rho */

};

/* PDP file operations in pdp-file.c */
int pdp_tag_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, PDP_key *key);

PDP_challenge *pdp_challenge_file(unsigned int numfileblocks, PDP_key *key);

/* NOTE: It's important that challenge->s must be kept secret from the server.  A server challenge is <c, k1, k2, g_s>. 
 * Also, the key structures should only contain the public components.  See: pdp_get_pubkey() */
PDP_proof *pdp_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, PDP_challenge *challenge, PDP_key *key);

int pdp_verify_file(PDP_challenge *challenge, PDP_proof *proof, PDP_key *keypair);

/* This function is really used more testing as it does challenging, proof generation and verification */
int pdp_challenge_and_verify_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len);
PDP_tag *read_pdp_tag(FILE *tagfile, unsigned int index);
PDP_tag *from_data_to_tag(unsigned char *tag_from_storage, unsigned int index);

/* PDP core primatives in pdp-core.c*/

PDP_tag *pdp_tag_block(PDP_key *key, unsigned char *block, size_t blocksize, 
	unsigned int index);

PDP_challenge *pdp_challenge(PDP_key *key, unsigned int numfileblocks);

PDP_proof *pdp_generate_proof_update(PDP_key *key, PDP_challenge *challenge, PDP_tag *tag,
	PDP_proof *proof, unsigned char *block, size_t blocksize, unsigned int j);

PDP_proof *pdp_generate_proof_final(PDP_key *key, PDP_challenge *challenge, PDP_proof *proof);

int pdp_verify_proof(PDP_key *key, PDP_challenge *challenge, PDP_proof *proof);


/* PDP keying functions pdp-key.c */

PDP_key *pdp_create_new_keypair();

PDP_key *pdp_get_keypair();

PDP_key *pdp_get_pubkey();

PDP_key *generate_pdp_key();
void destroy_pdp_key(PDP_key *key);

/* Helper functions in pdp-misc.c */

void sfree(void *ptr, size_t size);

PDP_challenge *sanitize_pdp_challenge(PDP_challenge *challenge);

unsigned int *generate_prp_pi(PDP_challenge *challenge);
unsigned char *generate_H(BIGNUM *input, size_t *H_result_size);
unsigned char *generate_prf_f(PDP_challenge *challenge, unsigned int j, size_t *prf_result_size);
unsigned char *generate_prf_w(PDP_key *key, unsigned int index, size_t *prf_result_size);
BIGNUM *generate_fdh_h(PDP_key *key, unsigned char *index_prf, size_t index_prf_size);

PDP_generator *pick_pdp_generator(BIGNUM *n);
void destroy_pdp_generator(PDP_generator *g);

PDP_tag *generate_pdp_tag();
void destroy_pdp_tag(PDP_tag *tag);

PDP_challenge *generate_pdp_challenge();
void destroy_pdp_challenge(PDP_challenge *challenge);

PDP_proof *generate_pdp_proof();
void destroy_pdp_proof(PDP_proof *proof);

/* S3 functions in pdp-s3.c */
#ifdef USE_S3
PDP_proof *pdp_s3_prove_file(char *filepath, size_t filepath_len, char *tagfilepath, size_t tagfilepath_len, PDP_challenge *challenge, PDP_key *key);
int pdp_s3_put_file(char *filepath, size_t filepath_len);
int pdp_s3_get_file(char *filepath, size_t filepath_len);
#endif

#endif
