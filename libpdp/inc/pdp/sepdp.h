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
 * @defgroup SEPDP SEPDP
 * \brief An implementation of the PDP scheme of Ateniese et al (2008).
 **/
#ifndef __SEPDP_H__
#define __SEPDP_H__

#include <openssl/sha.h>
#include <pdp.h>

/// number of challenge blocks, sets assurance of proof
/// 512 blocks gives you 99.4% chance of detecting an error
#define SEPDP_MAGIC_CHALLENGE_BLOCKS 512

/// the default block size to use (default is 4 KB)
#define SEPDP_DEFAULT_BLOCK_SIZE_BYTES 4096

/// length of a key for Authenticated-Encryption scheme (default is 16 bytes)
#define SEPDP_DEFAULT_AE_KEY_SIZE    16

/// length of a key for PRP (default is a 16 byte AES key)
#define SEPDP_DEFAULT_PRP_KEY_SIZE   16

/// length of key for PRF (default is a 20 byte HMAC-SHA1 key)
#define SEPDP_DEFAULT_PRF_KEY_SIZE   SHA_DIGEST_LENGTH

/// the number of years over which challenges are issues (default 1)
#define SEPDP_DEFAULT_YEARS  1

/// the number of minutes between each challenge (default, once a month)
#define SEPDP_DEFAULT_MIN    43200


/*
 * function prototypes
 */
int sepdp_ctx_init(pdp_ctx_t *ctx);
int sepdp_ctx_create(pdp_ctx_t *ctx);
int sepdp_ctx_free(pdp_ctx_t *ctx);
int sepdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k);
int sepdp_key_store(const pdp_ctx_t *ctx, const pdp_key_t *k, const char *path);
int sepdp_key_open(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub, 
        const char* path);
int sepdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *k);
int sepdp_tags_gen(pdp_ctx_t *ctx, pdp_sepdp_key_t *k, pdp_sepdp_tagdata_t *t);
int sepdp_tags_free(const pdp_ctx_t *ctx, pdp_sepdp_tagdata_t *t);
int sepdp_store(const pdp_ctx_t *ctx, const pdp_sepdp_tagdata_t* tag);
int sepdp_challenge_gen(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key, 
        pdp_sepdp_challenge_t *c);
int sepdp_challenge_free(const pdp_ctx_t *ctx, pdp_sepdp_challenge_t *c);
int sepdp_proof_gen(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key,
        const pdp_sepdp_challenge_t *chal, pdp_sepdp_proof_t *proof);
int sepdp_proof_verify(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key,
        const pdp_sepdp_challenge_t *chal, const pdp_sepdp_proof_t *proof);
int sepdp_proof_free(const pdp_ctx_t *ctx, pdp_sepdp_proof_t *proof);

#endif
