/* 
* por-misc.c
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

#include "por.h"
#include <openssl/aes.h>


/* Fight evil by converting to a positive power of 2. 
 * If x is already a power of 2, x is returned unchanged. */
unsigned int next_pow_2(int x){
	if(x < 0)
		x = -1*x;
	/* Convert all bits after the first "1" to ones */
	x--;
	x = (x >> 1) | x;
	x = (x >> 2) | x;
	x = (x >> 4) | x;
	x = (x >> 8) | x;
	x = (x >> 16) | x;
	x++; 
	/* Zero is not a power of 2, and we won't return 1 */
	return (x == 0) ? 2 : x;
}

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

/*
static void bubbleSort(unsigned int *numbers, unsigned int array_size){

	int i, j, temp;
 
	for (i = (array_size - 1); i >= 0; i--){
		for (j = 1; j <= i; j++){
      		if (numbers[j-1] > numbers[j]){
        		temp = numbers[j-1];
        		numbers[j-1] = numbers[j];
        		numbers[j] = temp;
      		}
    	}
  	}
}
*/

/* qsort int comparison function 
 * returns negative if b > a 
 * and positive if a > b */ 
int int_cmp(const void *a, const void *b){ 
	const unsigned int *ia = (const unsigned int *)a; // casting pointer types 
	const unsigned int *ib = (const unsigned int *)b;
	return *ia - *ib; 
} 

POR_challenge *por_create_challenge(unsigned int n){
	
	POR_challenge *challenge;
	//int i = 0;
	unsigned int l;
	unsigned int *random_indices = NULL;
	//unsigned int tmp = 0;
	//unsigned int swapwith = 0;
	

	if(n > params.magic_num_challenge_blocks)
		l = params.magic_num_challenge_blocks;
	else
		l = n;

	/* Allocate memory */
	if((challenge = allocate_por_challenge(l)) == NULL)
		goto cleanup;
	
#if 0
	/* Randomly choose l indices (without replacement) */
	/* To do this, we create an array with all indices 0 - n-1, shuffle it, and take the first l values */
	if((random_indices = malloc(sizeof(unsigned int) * n)) == NULL)
		goto cleanup;
		
	for(i = 0; i < n; i++)
		random_indices[i] = i;
	for(i = 0; i < n; i++){
		get_rand_range(0, n-1, &swapwith);
		tmp = random_indices[swapwith];
		random_indices[swapwith] = random_indices[i];
		random_indices[i] = tmp;
	}
	for(i = 0; i < l; i++)
		challenge->I[i] = random_indices[i];

	/* Sort the challenge for any potential efficiencies */
	// NO: //bubbleSort(challenge->I, l);
	qsort(challenge->I, l, sizeof(unsigned int), int_cmp);

	sfree(random_indices, sizeof(unsigned int) * n);
#endif

	sample_sans_replacement(l, n, challenge->I);

	return challenge;
	
cleanup:
	if(challenge) destroy_por_challenge(challenge);
	if(random_indices) sfree(random_indices, sizeof(unsigned int) * n);
	
	return NULL;
}

void destroy_por_challenge(POR_challenge *challenge){

	if(!challenge) return;
	if(challenge->I) sfree(challenge->I, sizeof(unsigned int) * challenge->l);
	challenge->l = 0;
	sfree(challenge, sizeof(POR_challenge));
	
	return;
}

POR_challenge *allocate_por_challenge(unsigned int l){
	
	POR_challenge *challenge = NULL;

	if((challenge = malloc(sizeof(POR_challenge))) == NULL)
		return NULL;

	memset(challenge, 0, sizeof(POR_challenge));
	challenge->l = l;

	if((challenge->I = malloc(sizeof(unsigned int) * challenge->l)) == NULL)
		goto cleanup;
		
	memset(challenge->I, 0, sizeof(unsigned int) * challenge->l);

	return challenge;
	
cleanup:
	destroy_por_challenge(challenge);
	return NULL;
}

