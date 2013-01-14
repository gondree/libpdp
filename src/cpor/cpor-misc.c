/* 
* cpor-misc.c
*
* Copyright (c) 2008, Zachary N J Peterson <znpeters@nps.edu>
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the <organization> nor the
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

void printhex(unsigned char *ptr, size_t size){

	size_t i = 0;
	for(i = 0; i < size; i++){
		COND_PRINT("%02X", *ptr);
		ptr++;
	}
	COND_PRINT("\n");
}

void sfree(void *ptr, size_t size){ memset(ptr, 0, size); free(ptr); ptr = NULL;}

#if 0
int get_rand_range(unsigned int min, unsigned int max, unsigned int *value){
	unsigned int rado;
	unsigned int range = max - min + 1;
	
	if(!value) return 0;
	if(max < min) return 0;
	do{
		if(!RAND_bytes((unsigned char *)&rado, sizeof(unsigned int))) return 0;
	}while(rado > UINT_MAX - (UINT_MAX % range));
	
	*value = min + (rado % range);
	
	return 1;
}
#endif

inline unsigned int prev_pow_2(unsigned int x) {
	register int count = -1;
	while(x != 0) {
		x = (x >> 1);
		count++;
	}
	return (1 << count);
}

static int rand_range_AES(unsigned int upper_bound, unsigned char *ki, unsigned int prp_key_size, unsigned int *keyidx, unsigned int *out) {
	unsigned char *prp_result = NULL;
	unsigned char *prp_input = NULL;
	unsigned int max, r;
	AES_KEY aes_key;

	/* Max mod is the next power of two, 
	 * any r s.t. upper_bound <= r < max is biased */
	max = prev_pow_2(upper_bound) << 1;
	r = 0;

	/* Allocate memory */
	if(((prp_result = calloc(1, prp_key_size)) == NULL)) goto cleanup;
	if(((prp_input = calloc(1, prp_key_size)) == NULL)) goto cleanup;

	memset(&aes_key, 0, sizeof(AES_KEY));

	/* Setup the AES key */
	AES_set_encrypt_key((const unsigned char *)ki, prp_key_size * 8, &aes_key);

	/* This could theoretically loop forever but each retry has
	 * p > 0.5 (worst case) of selecting a number inside the range we need, 
	 * so it should rarely need to re-roll.
	 */	
	do {
		/* Setup in the input buffer */
		memcpy(prp_input, keyidx, sizeof(int));

		/* Perform AES on the index */
		AES_encrypt(prp_input, prp_result, &aes_key);

		/* Turn the PRP result into a number */
		memcpy(&r, prp_result, sizeof(unsigned int));

		r %= max;

		(*keyidx)++;
	} while(r >= upper_bound);

	*out = r;

	free(prp_result);
	free(prp_input);
	memset(&aes_key, 0, sizeof(AES_KEY));

	return 1;

cleanup:
	if(prp_result) free(prp_result);
	if(prp_input) free(prp_input);
	memset(&aes_key, 0, sizeof(AES_KEY));
	
	return 0;
}

inline char check_bit(unsigned int *bv, unsigned int index) {
	return (char)(bv[index / (sizeof(unsigned int)*8)] & (1 << index));
}
inline void set_bit(unsigned int *bv, unsigned int index) {
	bv[index / (sizeof(unsigned int)*8)] |= (1 << index);
}

/* Sampling without replacement (Floyd's algorithm)
 * Uniformly samples samp_sz elements from a list of unsigned ints from [0, pop_sz-1] 
 * storing the result in output[]
 */
int sample_sans_replacement(unsigned int samp_sz, unsigned int pop_sz, unsigned int output[]) {
	unsigned int N, M, V, i, j, keyidx;
	unsigned int* hist = NULL;
	unsigned int ki_size = 16; // 16 bytes == 128 bits
	unsigned char *ki = malloc(ki_size);
	if(ki == NULL) goto cleanup;

	N = pop_sz;
	M = samp_sz;
	V = 0;
	keyidx = 0;
	
	if(!RAND_bytes(ki, ki_size)) return 0;

	/* A list of bits indicating set membership */
	hist = calloc(1, pop_sz / sizeof(unsigned int));
	if(hist == NULL) goto cleanup;

	for(j = 0, i = N - M; i < N; j++, i++) {
		
		if(rand_range_AES(i+1, ki, ki_size, &keyidx, &V) == 0) goto cleanup;

		if(check_bit(hist, V)) {
			output[j] = i;
			set_bit(hist, i);
		} else {
			output[j] = V;
			set_bit(hist, V);
		}
	}

	free(hist);

	return 1;

cleanup:
	if(ki) free(ki);
	if(hist) free(hist);

	return 0;
}

/* gereate_prf_i: the implementation of the pseudo-random funcation f_k(i).  It takes in
 * the MAC key key and a block index.
 * It returns an allocated BIGNUM containing the resulting PRF or NULL on failure.
 * In this implementation we use HMAC-SHA1.
 */
BIGNUM *generate_prf_i(unsigned char *key, unsigned int index){
	
	unsigned char *prf_result = NULL;
	size_t prf_result_size = 0;
	BIGNUM *prf_result_bn = NULL;
	
	if(!key) return NULL;
	
	/* Allocate memory */
	if( ((prf_result = malloc(EVP_MAX_MD_SIZE)) == NULL)) goto cleanup;
	memset(prf_result, 0, EVP_MAX_MD_SIZE);
	if( ((prf_result_bn = BN_new()) == NULL)) goto cleanup;
	
	/* Do the HMAC-SHA1 */
	if(!HMAC(EVP_sha1(), key, params.prf_key_size, (unsigned char *)&index, sizeof(unsigned int),
		prf_result, (unsigned int *)&prf_result_size)) goto cleanup;
		
	/* Convert PRF result into a BIGNUM */
	if(!BN_bin2bn(prf_result, prf_result_size, prf_result_bn)) goto cleanup;
	
	/* Free some memory */
	if(prf_result) sfree(prf_result, EVP_MAX_MD_SIZE);	
	
	return prf_result_bn;
	
cleanup:
	if(prf_result) sfree(prf_result, EVP_MAX_MD_SIZE);
	if(prf_result_bn) BN_clear_free(prf_result_bn);
	return NULL;
	
}

size_t get_ciphertext_size(size_t plaintext_len){

	size_t block_size = 0;

	EVP_CIPHER_CTX ctx;
	EVP_CIPHER_CTX_init(&ctx);
	if(!EVP_EncryptInit_ex(&ctx, EVP_aes_256_cbc(), NULL, NULL, NULL)) return 0;
	block_size = EVP_CIPHER_CTX_block_size(&ctx);
	EVP_CIPHER_CTX_cleanup(&ctx);
		
	return plaintext_len + block_size;
}

size_t get_authenticator_size(){

	return EVP_MAX_MD_SIZE;
}

int decrypt_and_verify_secrets(CPOR_key *key, unsigned char *input, size_t input_len, unsigned char *plaintext, size_t *plaintext_len, unsigned char *authenticator, size_t authenticator_len){

	EVP_CIPHER_CTX ctx;
	EVP_CIPHER *cipher = NULL;
	unsigned char mac[EVP_MAX_MD_SIZE];
	size_t mac_size = EVP_MAX_MD_SIZE;
	int len;
	
	if(!key || !key->k_enc || !key->k_mac || !input || !input_len || !plaintext || !plaintext_len || !authenticator || !authenticator_len) return 0; 
	
	OpenSSL_add_all_algorithms();
	memset(mac, 0, mac_size);
	
	/* Verify the HMAC-SHA1 */
	if(!HMAC(EVP_sha1(), key->k_mac, key->k_mac_size, input, input_len, mac, (unsigned int *)&mac_size)) goto cleanup;
	if(authenticator_len != mac_size) goto cleanup;
	if(memcmp(mac, authenticator, mac_size) != 0) goto cleanup;
	
	
	EVP_CIPHER_CTX_init(&ctx);
	switch(key->k_enc_size){
		case 16:
			cipher = (EVP_CIPHER *)EVP_aes_128_cbc();
			break;
		case 24:
			cipher = (EVP_CIPHER *)EVP_aes_192_cbc();
			break;
		case 32:
			cipher = (EVP_CIPHER *)EVP_aes_256_cbc();
			break;
		default:
			return 0;
	}
	if(!EVP_DecryptInit(&ctx, cipher, key->k_enc, NULL)) goto cleanup;
	
	*plaintext_len = 0;
	
	if(!EVP_DecryptUpdate(&ctx, plaintext, (int *)plaintext_len, input, input_len)) goto cleanup;
	EVP_DecryptFinal(&ctx, plaintext + *plaintext_len, &len);
	
	*plaintext_len += len;
	
	EVP_CIPHER_CTX_cleanup(&ctx);
	
	return 1;

cleanup:
	*plaintext_len = 0;

	return 0;
	
}

int encrypt_and_authentucate_secrets(CPOR_key *key, unsigned char *input, size_t input_len, unsigned char *ciphertext, size_t *ciphertext_len, unsigned char *authenticator, size_t *authenticator_len){
	
	EVP_CIPHER_CTX ctx;
	EVP_CIPHER *cipher = NULL;
	int len;
	
	if(!key || !key->k_enc || !key->k_mac || !input || !input_len || !ciphertext || !ciphertext_len || !authenticator || !authenticator_len) return 0;
	
	OpenSSL_add_all_algorithms();
	
	EVP_CIPHER_CTX_init(&ctx);
	switch(key->k_enc_size){
		case 16:
			cipher = (EVP_CIPHER *)EVP_aes_128_cbc();
			break;
		case 24:
			cipher = (EVP_CIPHER *)EVP_aes_192_cbc();
			break;
		case 32:
			cipher = (EVP_CIPHER *)EVP_aes_256_cbc();
			break;
		default:
			return 0;
	}
	//TODO: Fix the NULL IV
	if(!EVP_EncryptInit(&ctx, cipher, key->k_enc, NULL)) goto cleanup;

	*ciphertext_len = 0;
	
	if(!EVP_EncryptUpdate(&ctx, ciphertext, (int *)ciphertext_len, input, input_len)) goto cleanup;
	EVP_EncryptFinal(&ctx, ciphertext + *ciphertext_len, &len);
		
	*ciphertext_len += len;
	
	*authenticator_len = 0;
	/* Do the HMAC-SHA1 */
	if(!HMAC(EVP_sha1(), key->k_mac, key->k_mac_size, ciphertext, *ciphertext_len,
		authenticator, (unsigned int *)authenticator_len)) goto cleanup;
	
	EVP_CIPHER_CTX_cleanup(&ctx);	
	
	return 1;
	
cleanup:
	*ciphertext_len = 0;
	*authenticator_len = 0;
	
	return 0;
	
}

CPOR_t *cpor_create_t(CPOR_global *global, unsigned int n){

	CPOR_t *t = NULL;
	int i = 0;
	
	if( ((t = allocate_cpor_t()) == NULL)) goto cleanup;
	
	/* Generate a random PRF key, k_prf */
	if(!RAND_bytes(t->k_prf, params.prf_key_size)) goto cleanup;

	for(i = 0; i < params.num_sectors; i++)
		if(!BN_rand_range(t->alpha[i], global->Zp)) goto cleanup;
	
	t->n = n;
	
	return t;
	
cleanup:
	if(t) destroy_cpor_t(t);
	return NULL;
}


int verify_cpor_key(CPOR_key *key){

	if(!key->k_enc) return 0;
	if(!key->k_mac) return 0;
	
	return 1;
}

void destroy_cpor_global(CPOR_global *global){

	if(!global) return;
	if(global->Zp) BN_clear_free(global->Zp);
	sfree(global, sizeof(CPOR_global));
	
	return;
}

CPOR_global *allocate_cpor_global(){

	CPOR_global *global = NULL;
	
	if( ((global = malloc(sizeof(CPOR_global))) == NULL)) return NULL;
	if( ((global->Zp = BN_new()) == NULL)) goto cleanup;

	return global;
	
cleanup:
	destroy_cpor_global(global);
	return NULL;
}

void destroy_cpor_challenge(CPOR_challenge *challenge){

	int i;

	if(!challenge) return;
	if(challenge->I) sfree(challenge->I, sizeof(unsigned int) * challenge->l);
	if(challenge->nu){
		for(i = 0; i < challenge->l; i++){
			if(challenge->nu[i]) BN_clear_free(challenge->nu[i]);
		}
		sfree(challenge->nu, sizeof(BIGNUM *) * challenge->l);
	}
	challenge->l = 0;
	if(challenge->global) destroy_cpor_global(challenge->global);
	sfree(challenge, sizeof(CPOR_challenge));
	
	return;
}

CPOR_challenge *allocate_cpor_challenge(unsigned int l){
	
	CPOR_challenge *challenge = NULL;
	int i = 0;

	if( ((challenge = malloc(sizeof(CPOR_challenge))) == NULL)) return NULL;
	memset(challenge, 0, sizeof(CPOR_challenge));
	challenge->l = l;
	if( ((challenge->I = malloc(sizeof(unsigned int) * challenge->l)) == NULL)) goto cleanup;
	memset(challenge->I, 0, sizeof(unsigned int) * challenge->l);
	if( ((challenge->nu = malloc(sizeof(BIGNUM *) * challenge->l)) == NULL)) goto cleanup;	
	memset(challenge->nu, 0, sizeof(BIGNUM *) * challenge->l);
	for(i = 0; i < challenge->l; i++)
		if( ((challenge->nu[i] = BN_new()) == NULL)) goto cleanup;
	if( ((challenge->global = allocate_cpor_global()) == NULL)) goto cleanup;

	return challenge;
	
cleanup:
	destroy_cpor_challenge(challenge);
	return NULL;
}


void destroy_cpor_tag(CPOR_tag *tag){

	if(!tag) return;
	if(tag->sigma) BN_clear_free(tag->sigma);
	sfree(tag, sizeof(CPOR_tag));
	tag = NULL;
}

CPOR_tag *allocate_cpor_tag(){

	CPOR_tag *tag = NULL;
	
	if( ((tag = malloc(sizeof(CPOR_tag))) == NULL)) return NULL;
	memset(tag, 0, sizeof(CPOR_tag));
	if( ((tag->sigma = BN_new()) == NULL)) goto cleanup;
	tag->index = 0;
	
	return tag;
	
cleanup:
	if(tag) destroy_cpor_tag(tag);
	return NULL;
	
}

void destroy_cpor_t(CPOR_t *t){

	int i;

	if(!t) return;
	if(t->k_prf) sfree(t->k_prf, params.prf_key_size);
	if(t->alpha){
		for(i = 0; i < params.num_sectors; i++)
			if(t->alpha[i]) BN_clear_free(t->alpha[i]);
		 sfree(t->alpha, sizeof(BIGNUM *) * params.num_sectors);
	}
	t->n = 0;
	sfree(t, sizeof(CPOR_t));
	
	return;
}

CPOR_t *allocate_cpor_t(){

	CPOR_t *t = NULL;
	int i = 0;
	
	if( ((t = malloc(sizeof(CPOR_t))) == NULL)) return NULL;
	memset(t, 0, sizeof(CPOR_t));
	t->n = 0;
	if( ((t->k_prf = malloc(params.prf_key_size)) == NULL)) goto cleanup;
	if( ((t->alpha = malloc(sizeof(BIGNUM *) * params.num_sectors)) == NULL)) goto cleanup;
	memset(t->alpha, 0, sizeof(BIGNUM *) * params.num_sectors);	
	for(i = 0; i < params.num_sectors; i++){
		t->alpha[i] = BN_new();
	}
	
	return t;

cleanup:
	destroy_cpor_t(t);
	return NULL;
	
}

void destroy_cpor_proof(CPOR_proof *proof){

	int i = 0;

	if(!proof) return;
	if(proof->sigma) BN_clear_free(proof->sigma);
	if(proof->mu){
		for(i = 0; i < params.num_sectors; i++){
			if(proof->mu[i]) BN_clear_free(proof->mu[i]);
		}
		sfree(proof->mu, sizeof(BIGNUM *) * params.num_sectors);
	}
	sfree(proof, sizeof(CPOR_proof));

	return;	
}

CPOR_proof *allocate_cpor_proof(){

	CPOR_proof *proof = NULL;
	int i = 0;
		
	if( ((proof = malloc(sizeof(CPOR_proof))) == NULL)) return NULL;
	memset(proof, 0, sizeof(CPOR_proof));
	if( ((proof->sigma = BN_new()) == NULL )) goto cleanup;
	if( ((proof->mu = malloc(sizeof(BIGNUM *) * params.num_sectors)) == NULL)) goto cleanup;
	memset(proof->mu, 0, sizeof(BIGNUM *) * params.num_sectors);
	for(i = 0; i < params.num_sectors; i++)
		if( ((proof->mu[i] = BN_new()) == NULL)) goto cleanup;

	return proof;

cleanup:
	destroy_cpor_proof(proof);
	return NULL;	

	
}

