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
 * @defgroup MACPDP MACPDP
 * \brief An implementation of the MAC-based PDP scheme.
 **/
#ifndef __MAC_PDP_H__
#define __MAC_PDP_H__

#include <pdp.h>
#include <pdp/types.h>

/// number of challenges, sets assurance of proof
#define MACPDP_MAGIC_CHALLENGE_NUM 460

/// default PRF key size in bytes, (same as that used in HMAC-SHA1)
#define MACPDP_DEFAULT_PRF_KEY_BYTES SHA_DIGEST_LENGTH

/// the default block size to use (4 KB)
#define MACPDP_DEFAULT_BLOCK_SIZE_BYTES 4096

/// tag size is same as MAC digest size
#define MACPDP_DEFAULT_TAG_SIZE_BYTES SHA_DIGEST_LENGTH


/*
 * function prototypes
 */
int macpdp_ctx_init(pdp_ctx_t *ctx);
int macpdp_ctx_create(pdp_ctx_t *ctx);
int macpdp_ctx_free(pdp_ctx_t *ctx);
int macpdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k);
int macpdp_key_free(pdp_key_t *k);
int macpdp_tags_gen(pdp_ctx_t *ctx, pdp_macpdp_key_t *k, 
        pdp_macpdp_tagdata_t *t);
int macpdp_tags_free(const pdp_ctx_t *ctx, pdp_macpdp_tagdata_t *t);
int macpdp_store(const pdp_ctx_t *ctx, const pdp_macpdp_tagdata_t* tag);
int macpdp_challenge_gen(const pdp_ctx_t *ctx, pdp_macpdp_challenge_t *c);
int macpdp_challenge_free(const pdp_ctx_t *ctx, pdp_macpdp_challenge_t *c);
int macpdp_proof_gen(const pdp_ctx_t *ctx, const pdp_macpdp_challenge_t *c,
        pdp_macpdp_proof_t *proof);
int macpdp_proof_verify(const pdp_ctx_t *ctx, const pdp_macpdp_key_t *key,
        const pdp_macpdp_challenge_t *c, const pdp_macpdp_proof_t *proof);
int macpdp_proof_free(const pdp_ctx_t *ctx, pdp_macpdp_proof_t *proof);

#endif
