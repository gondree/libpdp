/**
 * @file
 * Interfaces for the libpdp library.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 *
 * @defgroup PDP libpdp Interfaces
 * \brief Generic interfaces for all PDP schemes.
 **/
#ifndef __PDP_H__
#define __PDP_H__

#include <stddef.h>
#include <sys/types.h>
#include <pdp/types.h>

#define LIBPDP_NAME  "libpdp"    ///< library name
#define LIBPDP_VERS  "v1.0"      ///< library version


/**
 * \brief Macro used on a ctx pointer to set the algo used
 * by the pdp ctx instance.
 **/
#define PDP_SELECT(ctx, x) \
    do { (ctx)->algo = x; } while(0)


/*
 * defines the PDP algorithms to use with the PDP_SELECT macro.
 */
#define PDP_MACPDP 0x00     ///< Select the MAC-PDP algo
#define PDP_APDP   0x01     ///< Select the A-PDP algo
#define PDP_SEPDP  0x02     ///< Select the SE-PDP algo
#define PDP_CPOR   0x03     ///< Select the CPOR algo


/*
 * options to use for ctx, to adjust PDP method behavior.
 */
#define PDP_OPT_DEFAULT  0x00
#define PDP_OPT_THREADED 0x01   ///< Use threaded routines, when possible
#define PDP_OPT_USE_S3   0x02   ///< Use Amazon S3 as storage backend
#define PDP_USE_ECC      0x04   ///< Use an ECC tranform before tagging
#define PDP_PW_NOINPUT   0x08   ///< Read password from environment (not safe)


/*
 * function prototypes
 */
int pdp_ctx_init(pdp_ctx_t *ctx);
int pdp_ctx_create(pdp_ctx_t *ctx, const char* filename, const char *output);
int pdp_ctx_free(pdp_ctx_t *ctx);
int pdp_key_open(pdp_ctx_t *ctx, pdp_key_t *key, pdp_key_t *pk,
        const char *path);
int pdp_key_store(const pdp_ctx_t *ctx, const pdp_key_t *key, const char *path);
int pdp_key_gen(pdp_ctx_t *ctx, pdp_key_t *key, pdp_key_t *pk);
int pdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *key);
int pdp_file_preprocess(pdp_ctx_t *ctx);
int pdp_tags_gen(pdp_ctx_t *ctx, pdp_key_t *key, pdp_tag_t *tag);
int pdp_tags_free(const pdp_ctx_t *ctx, pdp_tag_t *tag);
int pdp_store(const pdp_ctx_t *ctx, const pdp_key_t *key, const pdp_tag_t *tag);
int pdp_challenge_gen(const pdp_ctx_t *ctx, pdp_key_t *key, pdp_challenge_t *c);
int pdp_challenge_for_prover(const pdp_ctx_t *ctx, const pdp_challenge_t *c,
        pdp_challenge_t *vchal);
int pdp_challenge_free(const pdp_ctx_t *ctx, pdp_challenge_t *c);
int pdp_proof_gen(const pdp_ctx_t *ctx, const pdp_key_t *key,
        const pdp_challenge_t *c, pdp_proof_t *proof);
int pdp_proof_verify(const pdp_ctx_t *ctx, const pdp_key_t *key, 
        const pdp_challenge_t *c, const pdp_proof_t *proof);
int pdp_proof_free(const pdp_ctx_t *ctx, pdp_proof_t *proof);

#endif
