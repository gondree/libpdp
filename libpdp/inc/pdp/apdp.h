/**
 * @file
 * Interfaces for the MAC-PDP module for libpdp.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 *
 * @defgroup APDP APDP
 * \brief An implementation of the PDP scheme of Ateniese et al (2007).
 **/
#ifndef __A_PDP_H__
#define __A_PDP_H__

#include <openssl/sha.h>
#include <openssl/rsa.h>
#include <pdp.h>

/// number of challenges, sets assurance of proof.
/// 460 blocks gives you 99% chance of detecting an error, 300 blocks gives
///  you 95% chance
#define APDP_MAGIC_CHALLENGE_NUM 460

/// default block size to use (16 KB)
#define APDP_DEFAULT_BLOCK_SIZE_BYTES 16384

/// default public exponent 'e' used in RSA
#define APDP_DEFAULT_RSA_PUB_EXP    RSA_F4

/// number of bits of RSA modulus
#define APDP_DEFAULT_RSA_KEY_SIZE   1024

/// default prp key length, default is 16 bytes (128-bit AES)
#define APDP_DEFAULT_PRP_KEY_SIZE   16

/// length of key for PRF, default is 20 bytes
#define APDP_DEFAULT_PRF_KEY_SIZE   SHA_DIGEST_LENGTH


/// @def APDP_NO_SAFE_PRIMES
/// \brief Don't use safe primes
/// Using safe primes is required if you want PDP to be provably secure.
/// Key generation is slower as a side effect
///
/// @def APDP_USE_E_PDP
/// \brief Use efficient variant
/// If USE_E_PDP is defined, the protocol is more efficient but offers
/// weaker guarantees of possesion; only a possesion of the sum of file 
/// blocks. In general, however, this is practically secure as long as 
/// the number of sampled blocks is high.
#define APDP_NO_SAFE_PRIMES  0x01
#define APDP_USE_E_PDP       0x02


/*
 * function prototypes
 */
int apdp_ctx_init(pdp_ctx_t *ctx);
int apdp_ctx_create(pdp_ctx_t *ctx);
int apdp_ctx_free(pdp_ctx_t *ctx);
int apdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub);
int apdp_key_store(const pdp_ctx_t *ctx, const pdp_key_t *k, const char *path);
int apdp_key_open(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub, 
        const char* path);
int apdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *k);
int apdp_tags_gen(pdp_ctx_t *ctx, pdp_apdp_key_t *k, pdp_apdp_tagdata_t *t);
int apdp_tags_free(const pdp_ctx_t *ctx, pdp_apdp_tagdata_t *t);
int apdp_store(const pdp_ctx_t *ctx, const pdp_apdp_tagdata_t* tag);
int apdp_challenge_gen(const pdp_ctx_t *ctx, const pdp_apdp_key_t *key, 
        pdp_apdp_challenge_t *chal);
int apdp_challenge_free(const pdp_ctx_t *ctx, pdp_apdp_challenge_t *c);
int apdp_proof_gen(const pdp_ctx_t *ctx, const pdp_apdp_key_t *key,
        const pdp_apdp_challenge_t *chal, pdp_apdp_proof_t *proof);
int apdp_proof_verify(const pdp_ctx_t *ctx, const pdp_apdp_key_t *key,
        const pdp_apdp_challenge_t *chal, const pdp_apdp_proof_t *proof);
int apdp_proof_free(const pdp_ctx_t *ctx, pdp_apdp_proof_t *proof);

#endif
