/* 
* pdp-core.c
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

#include "pdp.h"


/* pdp_tag_block: Client-side function that takes pdp-keys, a generator of QR_N, and block of data, its
 * size and its logical index and creates a pdp tag to be stored with it at the server.  Returns an allocated 
 * pdp-tag structure.
 */
PDP_tag *pdp_tag_block(PDP_key *key, unsigned char *block, size_t blocksize, unsigned int index){
	
	PDP_tag *tag = NULL;
	BN_CTX * ctx = NULL;
	BIGNUM *phi = NULL;
	BIGNUM *fdh_hash = NULL;
	BIGNUM *message  = NULL;
	BIGNUM *r0 = NULL;
	BIGNUM *r1 = NULL;
	
	if(!key || !block || !blocksize) return NULL;

	/* Verify keys */
	if(!key->rsa->d) return NULL;
	if(!key->rsa->n) return NULL;
	if(!key->rsa->p) return NULL;
	if(!key->rsa->q) return NULL;
	if(!key->g) return NULL;
	
	/* Allocate memory */
	if( ((tag = generate_pdp_tag()) == NULL)) goto cleanup;
	if( ((phi = BN_new()) == NULL)) goto cleanup;
	if( ((r0 = BN_new()) == NULL)) goto cleanup;
	if( ((r1 = BN_new()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	
	/* Set the index */
	tag->index = index;
	
	/* Perform the pseudo-random function (prf) Wi = w_v(i) */
	tag->index_prf = generate_prf_w(key, tag->index, &(tag->index_prf_size));
	if(!tag->index_prf) goto cleanup;
	
	/* Peform the full-domain hash function h(Wi) */
	fdh_hash = generate_fdh_h(key, tag->index_prf, tag->index_prf_size);
	if(!fdh_hash) goto cleanup;
	
	/* Turn the data block into a BIGNUM */
	message = BN_bin2bn(block, blocksize, NULL);
	if(!message) goto cleanup;
	
	/* Calculate phi */
	if (!BN_sub(r0, key->rsa->p, BN_value_one())) goto cleanup;	/* p-1 */
	if (!BN_sub(r1, key->rsa->q, BN_value_one())) goto cleanup;	/* q-1 */
	if (!BN_mul(phi, r0, r1, ctx)) goto cleanup;	/* phi = (p-1)(q-1) */
	
	/* Reduce the message by modulo phi(N) */
	if(!BN_mod(message, message, phi, ctx)) goto cleanup;
	
	/* r0 = g^m */
	if(!BN_mod_exp(r0, key->g, message, key->rsa->n, ctx)) goto cleanup;
	/* r1 = h(W_i) * g^m */
	if(!BN_mul(r1, fdh_hash, r0, ctx)) goto cleanup;
	/* T_im = (h(W_i) * g^m)^d mod N */
	if(!BN_mod_exp(tag->Tim, r1, key->rsa->d, key->rsa->n, ctx)) goto cleanup;
	
	if(message) BN_clear_free(message);
	if(phi) BN_clear_free(phi);
	if(r0) BN_clear_free(r0);
	if(r1) BN_clear_free(r1);
	if(ctx) BN_CTX_free(ctx);
	if(fdh_hash) BN_clear_free(fdh_hash);
		
	return tag;
	
cleanup:
	if(message) BN_clear_free(message);
	if(phi) BN_clear_free(phi);
	if(r0) BN_clear_free(r0);
	if(r1) BN_clear_free(r1);
	if(ctx) BN_CTX_free(ctx);
	if(fdh_hash) BN_clear_free(fdh_hash);	
	if(tag) destroy_pdp_tag(tag);

	return NULL;
}

/* pdp_challenge: A client-side function to generate a random challenge for the server to prove data possession.
 *  Takes pdp-keys, the generator of QR_N and the filesize in blocks.  
 *  Returns an allocated pdp-challenge structure.
 *  It's important to note that s must be kept secret from the server.  A server challenge is <c, k1, k2, g_s>.
 */
PDP_challenge *pdp_challenge(PDP_key *key, unsigned int numfileblocks){
	
	PDP_challenge *challenge = NULL;
	BIGNUM *r0 = NULL;
	BN_CTX *ctx = NULL;
	
	if(!key || !numfileblocks) return NULL;

	/* Verify keys */
	if(!key->rsa->n) return NULL;
	if(!key->g) return NULL;

	/* Allocate memory */
	if( ((challenge = generate_pdp_challenge()) == NULL)) goto cleanup;
	if( ((r0 = BN_new()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	
	/* Generate a random secret s of RSA modulus size from Z*N */
	do{
		if(!BN_rand_range(challenge->s, key->rsa->n)) goto cleanup;
		if(!BN_gcd(r0, challenge->s, key->rsa->n, ctx)) goto cleanup;
	} while(!BN_is_one(r0));

	/* Generate the secret base g_s = g^s */
	if(!BN_mod_exp(challenge->g_s, key->g, challenge->s, key->rsa->n, ctx)) goto cleanup;

	/* Generate random bytes for symmetric challenge keys */
	if(!RAND_bytes(challenge->k1, params.prp_key_size)) goto cleanup;
	if(!RAND_bytes(challenge->k2, params.prf_key_size)) goto cleanup;

	/* Challenge the server to test at least 460 blocks (params.num_challenge) of the file 
	*  (see paper for details on choice of c ) */
	if(numfileblocks < params.num_challenge)
		challenge->c = numfileblocks;
	else
		challenge->c = params.num_challenge;

	challenge->numfileblocks = numfileblocks;

	//challenge->I = generate_prp_pi(challenge);

	if(r0) BN_clear_free(r0);	
	if(ctx) BN_CTX_free(ctx);

	return challenge;

cleanup:
	if(challenge) destroy_pdp_challenge(challenge);
	if(r0) BN_clear_free(r0);
	if(ctx) BN_CTX_free(ctx);

	return NULL;
}

/* pdp_generate_proof_update: Creates or updates a PDP proof structure.  It should be called
*  for each block of the file challenged.  A called to pdp_generate_proof_final must be called
*  after all calls to update are finished.  It takes in a PDP key, a challenge, the tag of challenged
*  block, a proof, the block of data corresponding to the tag, the block size and challenge index.  
*  If the passed in proof structure is NULL, a new proof structure will be allocated.  An updated or 
*  new proof structure is returned, or NULL on failure.  Note that this is a server side function
*  so the key and challenge structures should only contain the public components.
*/
PDP_proof *pdp_generate_proof_update(PDP_key *key, PDP_challenge *challenge, PDP_tag *tag,
	PDP_proof *proof, unsigned char *block, size_t blocksize, unsigned int j){
	
	BIGNUM *coefficient_a = NULL;
	BIGNUM *message = NULL;
	BIGNUM *r0 = NULL;
	BN_CTX *ctx = NULL;
	unsigned char *prf_result = NULL;
	size_t prf_result_size = 0;
	
	if(!key || !challenge || !tag || !block || !blocksize) return NULL;
	
	/* Verify keys */
	if(!key->rsa->n) return NULL;
	
	/* Allocate memory */
	if(!proof) /* If the proof is NULL, create one */
		if( ((proof = generate_pdp_proof()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
	if( ((coefficient_a = BN_new()) == NULL)) goto cleanup;
	if( ((message = BN_new()) == NULL)) goto cleanup;
	if( ((r0 = BN_new()) == NULL)) goto cleanup;
		
	/* Data block into a BIGNUM */
	if(!BN_bin2bn(block, blocksize, message)) goto cleanup;
	
//#ifdef USE_E_PDP /* Use E-PDP */
	if(params.use_e_pdp) {

		/* No coefficients to calculate in E-PDP, so T is just product of tags */
		if(BN_is_zero(proof->T)){
			if(!BN_copy(proof->T, tag->Tim)) goto cleanup;
		}else{
			if(!BN_mul(proof->T, proof->T, tag->Tim, ctx)) goto cleanup;
		}

		/* Copy message into r0 for summing */
		if(!BN_copy(r0, message)) goto cleanup;

//#else /* Use S-PDP */
	}else{
		/* Compute the coefficient for block tag->index, where a_j = f_k2(j) */
		prf_result = generate_prf_f(challenge, j, &prf_result_size);
		if(!prf_result) goto cleanup;
		
		/* Convert prf result to a big number */
		if(!BN_bin2bn(prf_result, prf_result_size, coefficient_a)) goto cleanup;
			
		/* Compute T_im ^ coefficient_a */
		if(!BN_mod_exp(r0, tag->Tim, coefficient_a, key->rsa->n, ctx)) goto cleanup;
		/* Update T, where T = T1m^a1 * ... * Tim^aj */
		if(BN_is_zero(proof->T)){
			if(!BN_copy(proof->T, r0)) goto cleanup;
		}else{
			if(!BN_mul(proof->T, proof->T, r0, ctx)) goto cleanup;
		}
		/* Compute coefficient_a * message, where message = data block*/
		if(!BN_mul(r0, coefficient_a, message, ctx)) goto cleanup;

//#endif
	}

	/* Store the sum of (coefficient_a_j * message) in rho_temp. */
	/* If E-PDP, then there's no coefficient */
	if(BN_is_zero(proof->rho_temp)){
		if(!BN_copy(proof->rho_temp, r0)) goto cleanup;
	}else{
		if(!BN_add(proof->rho_temp, proof->rho_temp, r0)) goto cleanup;
	} 
	/* We do not compute g_s^coefficients*messages or H(g_s^coefficients*messages) until the call to generate_proof_final */
	
	if(coefficient_a) BN_clear_free(coefficient_a);
	if(message) BN_clear_free(message);
	if(r0) BN_clear_free(r0);
	if(ctx) BN_CTX_free(ctx);
	if(prf_result && prf_result_size > 0) sfree(prf_result, prf_result_size);
	
	return proof;

cleanup:
	if(coefficient_a) BN_clear_free(coefficient_a);
	if(message) BN_clear_free(message);
	if(r0) BN_clear_free(r0);
	if(ctx) BN_CTX_free(ctx);
	if(prf_result && prf_result_size > 0) sfree(prf_result, prf_result_size);
	if(proof) destroy_pdp_proof(proof);
	
	return NULL;
}

/* pdp_generate_proof_final: The final step of generating a server-side proof.
*  This shuld only be called once per proof and no more calls to update should
*  be made.  It takes in a PDP proof and PDP challenge structure and returns 
*  the final PDP proof or NULL on failure.
*/
PDP_proof *pdp_generate_proof_final(PDP_key *key, PDP_challenge *challenge, PDP_proof *proof){

	BN_CTX *ctx = NULL;

	if(!proof) return NULL;
	if(!key || !challenge || !proof->rho_temp) return NULL;
	if(!key->rsa->n || !challenge->g_s) return NULL;
	
	if( ((ctx = BN_CTX_new()) == NULL)) return NULL;
		
	/* Compute g_s^ (M1 + M2 + ... + Mc) mod N*/
	if(!BN_mod_exp(proof->rho_temp, challenge->g_s, proof->rho_temp, key->rsa->n, ctx)) goto cleanup;
	
	/* Compute H(g_s^(M1 + M2 + ... + Mc)) */
	proof->rho = generate_H(proof->rho_temp, &(proof->rho_size));
	if(!proof->rho) goto cleanup;
	
	if(ctx) BN_CTX_free(ctx);
	
	return proof;
	
cleanup:
	if(proof) destroy_pdp_proof(proof);
	if(ctx) BN_CTX_free(ctx);
		
	return NULL;
}

/* pdp_verify_proof: The client-side proof verification function.  
 * Takes a user's pdp-key, a challenge, its correspond proof and the file size in blocks.
 * Returns a 1 if verified, 0 otherwise.
 */
int pdp_verify_proof(PDP_key *key, PDP_challenge *challenge, PDP_proof *proof){
	
	BIGNUM *tao = NULL;
	BIGNUM *denom = NULL;
	BIGNUM *coefficient_a = NULL;
	BIGNUM *fdh_hash = NULL;
	BIGNUM *tao_s = NULL;
	BIGNUM *r0 = NULL;
	BN_CTX *ctx = NULL;
	unsigned char *index_prf = NULL;
	size_t index_prf_size = 0;
	unsigned char *prf_result = NULL;
	size_t prf_result_size = 0;
	unsigned char *H_result = NULL;
	size_t H_result_size = 0;
	unsigned int j = 0;
	int result = 0;
	unsigned int *indices = NULL;

	if(!key || !challenge || !proof) return -1;

	/* Verify keys */
	if(!key->rsa) return 0;
	if(!key->rsa->e) return 0;
	if(!key->rsa->n) return 0;

	/* Make sure we don't have a "sanitized" challenge */
	if(!challenge->s) return 0;

	/* Allocate memory */
	if( ((tao = BN_new()) == NULL)) goto cleanup;
	if( ((denom = BN_new()) == NULL)) goto cleanup;
	if( ((coefficient_a = BN_new()) == NULL)) goto cleanup;
	if( ((r0 = BN_new()) == NULL)) goto cleanup;
	if( ((tao_s = BN_new()) == NULL)) goto cleanup;
	if( ((ctx = BN_CTX_new()) == NULL)) goto cleanup;
		
	/* Compute tao where tao = T^e */
	if(!BN_mod_exp(tao, proof->T, key->rsa->e, key->rsa->n, ctx)) goto cleanup;	

	/* Compute the indices i_j = pi_k1(j); the indices of blocks to sample */
	indices = generate_prp_pi(challenge);
	for(j = 0; j < challenge->c; j++){

		/* Perform the pseudo-random function Wi = w_v(i) */
		index_prf = generate_prf_w(key, indices[j], &index_prf_size);
		if(!index_prf) goto cleanup;
	
		/* Calculate the full-domain hash h(W_i) */
		fdh_hash = generate_fdh_h(key, index_prf, index_prf_size);
		if(!fdh_hash) goto cleanup;

//#ifdef USE_E_PDP /* Use E-PDP */
		if(params.use_e_pdp) {

			/* No coefficients in E-PDP, so just copy FDH result in */
			if(!BN_copy(r0, fdh_hash)) goto cleanup;

//#else  /* Use S-PDP */
		}else{

			/* Generate the coefficient for block index a = f_k2(j) */
			prf_result = generate_prf_f(challenge, j, &prf_result_size);
			if(!prf_result) goto cleanup;
		
			/* Convert prf coefficient result to a BIGNUM */
			if(!BN_bin2bn(prf_result, prf_result_size, coefficient_a)) goto cleanup;

			/* Calculate h(W_i)^a */
			if(!BN_mod_exp(r0, fdh_hash, coefficient_a, key->rsa->n, ctx)) goto cleanup;
		
//#endif
		}
		/* Calculate products of h(W_i)^a (no coefficeint a in E-PDP) */
		if(BN_is_zero(denom)){
			if(!BN_copy(denom, r0)) goto cleanup;
		}else{
			if(!BN_mod_mul(denom, denom, r0, key->rsa->n, ctx)) goto cleanup;
		}
		
		/* Free memory befor next loop iteration */
		if(index_prf && (index_prf_size > 0)) sfree(index_prf, index_prf_size);
		if(fdh_hash) BN_clear_free(fdh_hash);
	} /* end for */
	
	/* Calculate tao, where tao = tao/h(W_i)^a mod N */
	/* Inverse h(W_i)^a to create 1/h(W_i)^a */
	if(!BN_mod_inverse(denom, denom, key->rsa->n, ctx)) goto cleanup;
	/* tao = tao * 1/h(W_i)^a mod N*/
	if(!BN_mod_mul(tao, tao, denom, key->rsa->n, ctx)) goto cleanup;

	/* Calculate tao^s mod N*/
	if(!BN_mod_exp(tao_s, tao, challenge->s, key->rsa->n, ctx)) goto cleanup;
	
	/* Calculate H(tao^s mod N) */
	H_result = generate_H(tao_s, &(H_result_size));
	if(!H_result) goto cleanup;
	
	/* The final verification step.  Does rho == rho? */
	if(memcmp(H_result, proof->rho, proof->rho_size) == 0)
		result = 1;

	if(tao) BN_clear_free(tao);
	if(denom) BN_clear_free(denom);
	if(coefficient_a) BN_clear_free(coefficient_a);	
	if(tao_s) BN_clear_free(tao_s);
	if(r0) BN_clear_free(r0);	
	if(ctx) BN_CTX_free(ctx);
	if(prf_result && (prf_result_size > 0)) sfree(prf_result, prf_result_size);	
	if(H_result && (H_result_size > 0)) sfree(H_result, H_result_size);	
	if(indices) sfree(indices, (challenge->c * sizeof(unsigned int)));
	
	return result;

cleanup:
	if(tao) BN_clear_free(tao);
	if(denom) BN_clear_free(denom);
	if(coefficient_a) BN_clear_free(coefficient_a);
	if(r0) BN_clear_free(r0);
	if(fdh_hash) BN_clear_free(fdh_hash);
	if(tao_s) BN_clear_free(tao_s);	
	if(ctx) BN_CTX_free(ctx);	
	if(index_prf && (index_prf_size > 0)) sfree(index_prf, index_prf_size);
	if(prf_result && (prf_result_size > 0)) sfree(prf_result, prf_result_size);
	if(H_result && (H_result_size > 0)) sfree(H_result, H_result_size);
	if(indices) sfree(indices, (challenge->c * sizeof(unsigned int)));
	
	return 0;
}


