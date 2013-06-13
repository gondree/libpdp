/**
 * @file
 * Interfaces for the CPOR module for libpdp.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 *
 * @defgroup CPOR CPOR
 * \brief An implementation of the PDP scheme of Shacham and Waters (2008).
 **/
#ifndef __CPOR_PDP_H__
#define __CPOR_PDP_H__

#include <pdp.h>

/// the default block size to use (4 KB)
#define CPOR_DEFAULT_BLOCK_SIZE_BYTES 4096

/// The security parameter lambda
#define CPOR_DEFAULT_LAMBDA 80

/// Size (in bytes) of an HMAC-SHA1
#define CPOR_DEFAULT_PRF_KEY_BYTES 20

/// Size (in bytes) of the user's AES encryption key
#define CPOR_DEFAULT_ENC_KEY_BYTES 32

/// Size (in bytes) of the user's MAC key
#define CPOR_DEFAULT_MAC_KEY_BYTES 20


/*
 * function prototypes
 */
int cpor_ctx_init(pdp_ctx_t *ctx);
int cpor_ctx_create(pdp_ctx_t *ctx);
int cpor_ctx_free(pdp_ctx_t *ctx);
int cpor_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub);
int cpor_key_open(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub,
        const char* path);
int cpor_key_store(const pdp_ctx_t *ctx, const pdp_key_t *k, const char *path);
int cpor_key_free(const pdp_ctx_t *ctx, pdp_key_t *k);
int cpor_tags_gen(pdp_ctx_t *ctx, pdp_cpor_key_t *k, pdp_cpor_tagdata_t *t);
int cpor_tags_free(const pdp_ctx_t *ctx, pdp_cpor_tagdata_t *t);
int cpor_store(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
        const pdp_cpor_tagdata_t* tag);
int cpor_challenge_gen(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
        pdp_cpor_challenge_t *chal);
int cpor_challenge_free(const pdp_ctx_t *ctx, pdp_cpor_challenge_t *c);
int cpor_proof_gen(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
        const pdp_cpor_challenge_t *chal, pdp_cpor_proof_t *proof);
int cpor_proof_verify(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
        const pdp_cpor_challenge_t *c, const pdp_cpor_proof_t *proof);
int cpor_proof_free(const pdp_ctx_t *ctx, pdp_cpor_proof_t *proof);

#endif
