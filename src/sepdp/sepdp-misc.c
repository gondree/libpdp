
/* 
* sepdp-misc.c
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



#include "sepdp.h"

void printhex(unsigned char *ptr, size_t size){

	int i = 0;
	for(i = 0; i < size; i++){
		printf("%02X", *ptr);
		ptr++;
	}
	printf("\n");
}

void sfree(void *ptr, size_t size){ memset(ptr, 0, size); free(ptr); ptr = NULL;}


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

/* Bitvector indexing functions */
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
static int sample_sans_replacement(unsigned char *ki, unsigned int ki_size, unsigned int samp_sz, unsigned int pop_sz, unsigned int output[]) {
	unsigned int N, M, V, i, j, keyidx;
	unsigned int* hist = NULL;

	N = pop_sz;
	M = samp_sz;
	V = 0;
	keyidx = 0;
	
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
	if(hist) free(hist);

	return 0;
}

/* generate_prf_f: an pseudo-random function (PRF) indexed on secret key W.
*  In this implementation, we use HMAC-SHA1
*/
unsigned char *generate_prf_f(unsigned char *key, unsigned int i, size_t *prf_result_size){

	unsigned char *prf_result = NULL;

	if(!key) return NULL;
	
	/* Allocate memory */
	if( ((prf_result = malloc(SHA_DIGEST_LENGTH)) == NULL)) goto cleanup;

	memset(prf_result, 0, SHA_DIGEST_LENGTH);

	/* Perform the HMAC on the index */
	if(!HMAC(EVP_sha1(), key, params.prf_key_size, (unsigned char *)&i, sizeof(unsigned int), 
		prf_result, (unsigned int *)prf_result_size)) goto cleanup;

	return prf_result;

cleanup:
	if(prf_result) sfree(prf_result, SHA_DIGEST_LENGTH);
	if(prf_result_size) *prf_result_size = 0;

	return NULL;	
}

#if 0 // This is the old way
/* key ki (generated by f_W() above), d blocks in the file, r indicies */
unsigned int *generate_prp_g(unsigned char *ki, size_t ki_size, unsigned int d, unsigned int r){

	unsigned char *prp_result = NULL;
	unsigned char *prp_input = NULL;
	AES_KEY aes_key;
	unsigned int index = 0;
	double result = 0.0;
	int x = 0, j = 0;
	unsigned int *indices = NULL;
	
	if(!ki || ki_size < params.prp_key_size) return NULL;

	/* Allocate memory */
	if( ((prp_result = malloc(params.prp_key_size)) == NULL)) goto cleanup;
	if( ((prp_input = malloc(params.prp_key_size)) == NULL)) goto cleanup;
	if( ((indices = malloc(r * sizeof(unsigned int))) == NULL)) goto cleanup;
	
	memset(prp_result, 0, params.prp_key_size);
	memset(prp_input, 0, params.prp_key_size);
	memset(&aes_key, 0, sizeof(AES_KEY));
	
	/* Setup the AES key */
	AES_set_encrypt_key(ki, params.prp_key_size * 8, &aes_key);
	
	/* Choose r blocks from 0 to d - 1 (file blocks) without replacement */
	for(x = 0; x < d && j < r; x++){
	
		/* Setup in the input buffer */
		memcpy(prp_input, &x, sizeof(int));
	
		/* Perform AES on the index */
		AES_encrypt(prp_input, prp_result, &aes_key);
	
		/* Turn the PRP result into a number */
		memcpy(&index, prp_result, sizeof(unsigned int));
	
		/* Make that number between 0 and 1 */
		result = ((double)index/(double)UINT_MAX);
	
		if( (d - x) * result < r - j){
			indices[j] = x;
			j++;
		}
	}
	
	/* Clear and free variables */
	if(prp_input) sfree(prp_input, params.prp_key_size);
	if(prp_result) sfree(prp_result, params.prp_key_size);
	memset(&aes_key, 0, sizeof(AES_KEY));
	
	return indices;

cleanup:
	if(prp_result) sfree(prp_result, params.prp_key_size);
	if(prp_input) sfree(prp_input, params.prp_key_size);
	if(indices) sfree(indices, (r * sizeof(unsigned int)));
	memset(&aes_key, 0, sizeof(AES_KEY));

	return NULL;
}
#endif

/* key ki (generated by f_W() above), d blocks in the file, r indicies */
unsigned int *generate_prp_g(unsigned char *ki, size_t ki_size, unsigned int d, unsigned int r){
	unsigned int *indices = NULL;
	if(((indices = malloc(r * sizeof(unsigned int))) == NULL)) return NULL;
	sample_sans_replacement(ki, params.prp_key_size, r, d, indices);
	return indices;
}

unsigned char *generate_H(unsigned char *c_i, size_t c_i_len, unsigned char **D, unsigned int r, size_t *vi_len){

	SHA_CTX ctx;
	unsigned char *vi = NULL; /* The token, aka hash result */
	int i = 0;

	if(!c_i || !D || !r) return NULL;
	
	if( ((vi = malloc(SHA_DIGEST_LENGTH)) == NULL)) goto cleanup;
	memset(vi, 0, SHA_DIGEST_LENGTH);
	
	if(!SHA1_Init(&ctx)) return NULL;
	
	/* Add c_i to the hash */
	if(!SHA1_Update(&ctx, c_i, c_i_len)) goto cleanup;
	
	for(i = 0; i < r; i++){
		if(!D[i]) goto cleanup;
		if(!SHA1_Update(&ctx, D[i], params.block_size)) goto cleanup;
	}
	
	if(!SHA1_Final(vi, &ctx)) goto cleanup;
	
	*vi_len = SHA_DIGEST_LENGTH;
	return vi;
	
 cleanup:
	if(vi) sfree(vi, SHA_DIGEST_LENGTH);
	if(vi_len) *vi_len = 0;
	
	return NULL;
}



int decrypt_and_verify_token(SEPDP_key *key, unsigned char *input, size_t input_len, unsigned char *plaintext, size_t *plaintext_len, unsigned char *authenticator, size_t authenticator_len, unsigned char *iv){

	EVP_CIPHER_CTX ctx;
	EVP_CIPHER *cipher = NULL;
	unsigned char mac[EVP_MAX_MD_SIZE];
	size_t mac_size = EVP_MAX_MD_SIZE;
	int len;
	
	if(!key || !key->K || !input || !input_len || !authenticator || !authenticator_len) return 0; 
	
	OpenSSL_add_all_algorithms();
	memset(mac, 0, mac_size);
	
	/* Verify the HMAC-SHA1 */
	if(!HMAC(EVP_sha1(), key->K, key->K_size, input, input_len, mac, (unsigned int *)&mac_size)) goto cleanup;
	if(authenticator_len != mac_size) goto cleanup;
	if(memcmp(mac, authenticator, mac_size) != 0) goto cleanup;
	
	EVP_CIPHER_CTX_init(&ctx);
	switch(key->K_size){
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
	if(!EVP_DecryptInit(&ctx, cipher, key->K, iv)) goto cleanup;
	
	*plaintext_len = 0;
	if(!EVP_DecryptUpdate(&ctx, plaintext, (int *)plaintext_len, input, input_len)) goto cleanup;
	if(!EVP_DecryptFinal(&ctx, plaintext + *plaintext_len, &len)) goto cleanup;
	*plaintext_len += len;
	EVP_CIPHER_CTX_cleanup(&ctx);
	

	CRYPTO_cleanup_all_ex_data();
	EVP_cleanup();
	
	return 1;

cleanup:
	CRYPTO_cleanup_all_ex_data();
	EVP_cleanup();
	*plaintext_len = 0;

	return 0;
	
}

int encrypt_then_mac_token(SEPDP_key *key, unsigned char *input, size_t input_len, unsigned char *ciphertext, size_t *ciphertext_len, unsigned char *authenticator, size_t *authenticator_len, unsigned char *iv, size_t iv_size){
	
	EVP_CIPHER_CTX ctx;
	EVP_CIPHER *cipher = NULL;
	int len;
	
	if(!key || !key->K || !input || !input_len) return 0;
	
	OpenSSL_add_all_algorithms();
	
	EVP_CIPHER_CTX_init(&ctx);
	switch(key->K_size){
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
			goto cleanup;
	}

	if(!RAND_bytes(iv, iv_size)) goto cleanup;
	if(!EVP_EncryptInit(&ctx, cipher, key->K, iv)) goto cleanup;

	*ciphertext_len = 0;
	

	if(!EVP_EncryptUpdate(&ctx, ciphertext, (int *)ciphertext_len, input, input_len)) goto cleanup;
	if(!EVP_EncryptFinal(&ctx, ciphertext + *ciphertext_len, &len)) goto cleanup;
	*ciphertext_len += len;
	EVP_CIPHER_CTX_cleanup(&ctx);
	
	*authenticator_len = 0;
	/* Do the HMAC-SHA1 */
	//TODO: Add MAC key
	if(!HMAC(EVP_sha1(), key->K, key->K_size, ciphertext, *ciphertext_len, authenticator, (unsigned int *)authenticator_len)) goto cleanup;

	CRYPTO_cleanup_all_ex_data();
	EVP_cleanup();
	
	return 1;
	
cleanup:
	CRYPTO_cleanup_all_ex_data();
	EVP_cleanup();
	if(iv) sfree(iv, key->K_size);
	*ciphertext_len = 0;
	*authenticator_len = 0;
	
	return 0;
	
}

void destroy_sepdp_challenge(SEPDP_challenge *challenge){
	
	if(!challenge) return;
	if(challenge->i) challenge->i = 0;
	if(challenge->ki) sfree(challenge->ki, challenge->ki_size);
	if(challenge->ci) sfree(challenge->ci, challenge->ci_size);
	sfree(challenge, sizeof(SEPDP_challenge));
	
	return;
}


SEPDP_challenge *generate_sepdp_challenge(){
	
	SEPDP_challenge *challenge = NULL;
	
	if( ((challenge = malloc(sizeof(SEPDP_challenge))) == NULL)) goto cleanup;
	memset(challenge, 0, sizeof(SEPDP_challenge));

	return challenge;
	
 cleanup:
	if(challenge) destroy_sepdp_challenge(challenge);
	return NULL;
}

void destroy_sepdp_proof(SEPDP_proof *proof){

	if(!proof) return;
	if(proof->z) sfree(proof->z, proof->z_size);
	if(proof->token) sfree(proof->token, proof->token_size);
	if(proof->mac) sfree(proof->mac, proof->mac_size);
	if(proof->iv) sfree(proof->iv, proof->iv_size);
	proof->z_size = proof->token_size = proof->mac_size = 0;
	sfree(proof, sizeof(SEPDP_proof));
	
	return;
}

SEPDP_proof *generate_sepdp_proof(){
	
	SEPDP_proof *proof = NULL;

	if((proof = calloc(1, sizeof(SEPDP_proof))) == NULL) goto cleanup;
	/* We don't allocate z because generate_H() allocates the memory for us */
	if((proof->token = calloc(1, params.block_size + SHA_DIGEST_LENGTH - 1)) == NULL) goto cleanup;
	proof->token_size = params.block_size + SHA_DIGEST_LENGTH - 1;

	/* Is this the right size to make the MAC (defined to be the max possible size)? 
	 * mac_size is reset later */
	if((proof->mac = calloc(1, EVP_MAX_MD_SIZE)) == NULL) goto cleanup;
	proof->mac_size = EVP_MAX_MD_SIZE;

	if((proof->iv = calloc(1, params.ae_key_size)) == NULL) goto cleanup;
	proof->iv_size = params.ae_key_size;
	
	return proof;

cleanup:
	if(proof) destroy_sepdp_proof(proof);
	return NULL;
}
