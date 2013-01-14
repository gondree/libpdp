/* 
* cpor-core.c
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

CPOR_params params;

CPOR_global *cpor_create_global(unsigned int bits){

	CPOR_global *global = NULL;
	BN_CTX *ctx = NULL;
	
	if(!bits) return NULL;
	
	if( ((global = allocate_cpor_global()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
		
	/* Generate a bits-sized safe prime for our group Zp */
	if(!BN_generate_prime(global->Zp, bits, 1, NULL, NULL, NULL, NULL)) goto cleanup;
	/* Check to see it's prime afterall */
	if(!BN_is_prime(global->Zp, BN_prime_checks, NULL, ctx, NULL)) goto cleanup;

	if(ctx) BN_CTX_free(ctx);
		
	return global;
	
cleanup:
	if(global) destroy_cpor_global(global);
	if(ctx) BN_CTX_free(ctx);
	return NULL;
}

/* cpor_tag_block: A client-side function that takes in a block, its size and its respecitve index and 
* return an allocated tag structure, or NULL on failure.
* NOTE: the tag structure contains two secrets, k_prf (the key to the PRF) and alpha (a randomly chosen value to
* blind the message.
*/
CPOR_tag *cpor_tag_block(CPOR_global *global, unsigned char *k_prf, BIGNUM **alpha, unsigned char *block, size_t blocksize, unsigned int index){

	CPOR_tag *tag = NULL;
	BN_CTX * ctx = NULL;
	BIGNUM *prf_i = NULL;
	BIGNUM *message = NULL;
	BIGNUM *product = NULL;
	BIGNUM *sum = NULL;
	int j = 0;
	
	if(!global || !block || !blocksize || !alpha || !k_prf) return NULL;
	
	if(!global->Zp) return NULL;
	
	/* Allocate memory */
	if( ((tag = allocate_cpor_tag()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	if( ((message = BN_new()) == NULL)) goto cleanup;
	if( ((product = BN_new()) == NULL)) goto cleanup;
	if( ((sum = BN_new()) == NULL)) goto cleanup;
	
	/* compute PRF_k(i) */
	if( ((prf_i = generate_prf_i(k_prf, index)) == NULL)) goto cleanup;
	
	BN_clear(sum);
	/* Sum all alpha * sector products */
	for(j = 0; j < params.num_sectors; j++){
		size_t sector_size = 0;
		unsigned char *sector = block + (j * params.sector_size);

		if( (blocksize - (j * params.sector_size)) > params.sector_size)
			sector_size = params.sector_size;
		else
			sector_size = (blocksize - (j * params.sector_size));
		
		/* Convert the sector into a BIGNUM */
		if(!BN_bin2bn(sector, sector_size, message)) goto cleanup;

		/* Check to see if the message is still an element of Zp */
		if(BN_ucmp(message, global->Zp) == 1) goto cleanup;

		/* multiply alpha and m */
		if(!BN_mod_mul(product, alpha[j], message, global->Zp, ctx)) goto cleanup;
		
		/* Sum the alpha_j-sector_ij products together */
		if(!BN_mod_add(sum, product, sum, global->Zp, ctx)) goto cleanup;
		
	}
	
	/* add alpha*m and PRF_k(i) mod p to make it an element of Z_p */
    if(!BN_mod_add(tag->sigma, prf_i, sum, global->Zp, ctx)) goto cleanup;

	/* Set the index */
	tag->index = index;
	
	/* We're done, cleanup and return tag */
	if(prf_i) BN_clear_free(prf_i);
	if(message) BN_clear_free(message);
	if(product) BN_clear_free(product);	
	if(sum) BN_clear_free(sum);	
	if(ctx) BN_CTX_free(ctx);
	
	return tag;

cleanup:
	if(tag) destroy_cpor_tag(tag);
	if(prf_i) BN_clear_free(prf_i);
	if(message) BN_clear_free(message);
	if(product) BN_clear_free(product);	
	if(sum) BN_clear_free(sum);
	if(ctx) BN_CTX_free(ctx);
	
	return NULL;
}

/* cpor_create_challenge: Create a random challenge to send to the prover.  Takes in n, the number of blocks in the file.
*  Returns an allocated and populated CPOR_challenge struct or NULL on failure.
*/
CPOR_challenge *cpor_create_challenge(CPOR_global *global, unsigned int n){

	CPOR_challenge *challenge;
	int i = 0;
	unsigned int l;
	unsigned int *random_indices = NULL;
	
	if(!global || !n) return NULL;
	if(!global->Zp) return NULL;
	
	/* Set l, the number of challenge blocks. */
	if(n > params.magic_num_challenge_blocks)
		l = params.magic_num_challenge_blocks;
	else
		l = n;
	
	/* Allocate memory */
	if( ((challenge = allocate_cpor_challenge(l)) == NULL)) goto cleanup;
	
#if 0
	unsigned int tmp = 0;
	unsigned int swapwith = 0;
	/* Randomly choose l indices (without replacement) */
	/* To do this, we create an array with all indices 0 - n-1, shuffle it, and take the first l values */
	if( ((random_indices = malloc(sizeof(unsigned int) * n)) == NULL)) goto cleanup;
	for(i = 0; i < n; i++)
		random_indices[i] = i;
	for(i = 0; i < n; i++){
		get_rand_range(0, n-1, &swapwith);
		tmp = random_indices[swapwith];
		random_indices[swapwith] = random_indices[i];
		random_indices[i] = tmp;
	}
	for(i = 0; i < l; i++){
		challenge->I[i] = random_indices[i];
	}

	sfree(random_indices, sizeof(unsigned int) * n);
#endif


	sample_sans_replacement(l, n, challenge->I);

	/* Randomly choose l elements of Zp (with replacement) */
	for(i = 0; i < l; i++)
		if(!BN_rand_range(challenge->nu[i], global->Zp)) goto cleanup;
	
	/* Set the global */
	if(!BN_copy(challenge->global->Zp, global->Zp)) goto cleanup;
	
	return challenge;
	
cleanup:
	if(challenge) destroy_cpor_challenge(challenge);
	if(random_indices) sfree(random_indices, sizeof(unsigned int) * n);
	
	return NULL;
}

CPOR_proof *cpor_create_proof_final(CPOR_proof *proof){

	return proof;
}

/* For each message index i, call update (we're going to call this challenge->l times */
CPOR_proof *cpor_create_proof_update(CPOR_challenge *challenge, CPOR_proof *proof, CPOR_tag *tag, unsigned char *block, size_t blocksize, unsigned int index, unsigned int i){

	BN_CTX * ctx = NULL;
	BIGNUM *message = NULL;
	BIGNUM *product = NULL;
	int j = 0;	
	
	if(!challenge || !tag || !block) goto cleanup;
	
	if(!proof)
		if( ((proof = allocate_cpor_proof()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	if( ((message = BN_new()) == NULL)) goto cleanup;
	if( ((product = BN_new()) == NULL)) goto cleanup;
	
	/* Calculate and update the mu's */	
	for(j = 0; j < params.num_sectors; j++){
		size_t sector_size = 0;
		unsigned char *sector = block + (j * params.sector_size);

		if( (blocksize - (j * params.sector_size)) > params.sector_size)
			sector_size = params.sector_size;
		else
			sector_size = (blocksize - (j * params.sector_size));

		/* Convert the sector into a BIGNUM */
		if(!BN_bin2bn(sector, (unsigned int)sector_size, message)) goto cleanup;

		/* Check to see if the message is still an element of Zp */
		if(BN_ucmp(message, challenge->global->Zp) == 1) goto cleanup;

		/* multiply nu_i and m_ij */
		if(!BN_mod_mul(product, challenge->nu[i], message, challenge->global->Zp, ctx)) goto cleanup;

		/* Sum the nu_i-m_ij products together */
		if(!BN_mod_add(proof->mu[j], proof->mu[j], product, challenge->global->Zp, ctx)) goto cleanup;
		
	}
	
	/* Calculate sigma */
	/* multiply nu_i (challenge) and sigma_i (tag) */
	if(!BN_mod_mul(product, challenge->nu[i], tag->sigma, challenge->global->Zp, ctx)) goto cleanup;

	/* Sum the nu_i-sigma_i products together */
	if(!BN_mod_add(proof->sigma, proof->sigma, product, challenge->global->Zp, ctx)) goto cleanup;
	
	if(message) BN_clear_free(message);
	if(product) BN_clear_free(product);	
	if(ctx) BN_CTX_free(ctx);
	
	return proof;

cleanup:
	if(proof) destroy_cpor_proof(proof);
	if(message) BN_clear_free(message);
	if(product) BN_clear_free(product);
	if(ctx) BN_CTX_free(ctx);
		
	return NULL;
}


int cpor_verify_proof(CPOR_global *global, CPOR_proof *proof, CPOR_challenge *challenge, unsigned char *k_prf, BIGNUM **alpha){

	BN_CTX * ctx = NULL;
	BIGNUM *prf_i = NULL;
	BIGNUM *product = NULL;
	BIGNUM *sigma = NULL;
	int i = 0, j = 0, ret = -1;

	if(!global || !proof || !challenge || !k_prf || !alpha) return -1;

	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	if( ((product = BN_new()) == NULL)) goto cleanup;
	if( ((sigma = BN_new()) == NULL)) goto cleanup;
		
	/* Compute the summation of all the products (nu_i * PRF_k(i)) */
	for(i = 0; i < challenge->l; i++){
		/* compute PRF_k(i) */
		if( ((prf_i = generate_prf_i(k_prf, challenge->I[i])) == NULL)) goto cleanup;

		/* Multiply prf_i by nu_i */
		if(!BN_mod_mul(product, challenge->nu[i], prf_i, global->Zp, ctx)) goto cleanup;
		
		/* Sum the results */
		if(!BN_mod_add(sigma, sigma, product, global->Zp, ctx)) goto cleanup;
		
		if(prf_i) BN_clear_free(prf_i);
	}
	
	/* Compute the summation of all the products (alpha_j * mu_j) */
	for(j = 0; j < params.num_sectors; j++){
		
		/* Multiply alpha_j by mu_j */
		if(!BN_mod_mul(product, alpha[j], proof->mu[j], global->Zp, ctx)) goto cleanup;	
		
		/* Sum the results */
		if(!BN_mod_add(sigma, sigma, product, global->Zp, ctx)) goto cleanup;
	}

	if(BN_ucmp(sigma, proof->sigma) == 0) ret = 1;
	else ret = 0;
	

	if(product) BN_clear_free(product);
	if(sigma) BN_clear_free(sigma);
	if(ctx) BN_CTX_free(ctx);
		
	return ret;
	
cleanup:
	if(prf_i) BN_clear_free(prf_i);
	if(product) BN_clear_free(product);
	if(sigma) BN_clear_free(sigma);
	if(ctx) BN_CTX_free(ctx);
		
	return -1;

}







