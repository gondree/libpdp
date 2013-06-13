/**
 * @file
 * Implementation of the MAC-PDP module for libpdp.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup SEPDP
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <pdp/sepdp.h>
#include "pdp_misc.h"


/**
 * @brief Generate key material.
 *
 * Our MAC is HMAC, so this creates a random PRF key.
 *
 * @return 0 on success, non-zero on error
 **/
int sepdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k)
{
    pdp_sepdp_ctx_t *p = NULL;
    pdp_sepdp_key_t *key = NULL;

    if (!is_sepdp(ctx) || !k)
        return -1;
    p = ctx->sepdp_param;

    if (!p->prf_key_size)
        return -1;

    if ((key = malloc(sizeof(pdp_sepdp_key_t))) == NULL)
        return -1;
    memset(key, 0, sizeof(pdp_sepdp_key_t));
    k->sepdp = key;

    key->W_size = p->prf_key_size;
    key->Z_size = p->prf_key_size;
    key->K_size = p->ae_key_size;
    if ((key->W = malloc(key->W_size)) == NULL) goto cleanup;
    if ((key->Z = malloc(key->Z_size)) == NULL) goto cleanup;
    if ((key->K = malloc(key->K_size)) == NULL) goto cleanup;
    if (!RAND_bytes(key->W, key->W_size)) goto cleanup;
    if (!RAND_bytes(key->Z, key->Z_size)) goto cleanup;
    if (!RAND_bytes(key->K, key->K_size)) goto cleanup;
    return 0;

 cleanup:
    sepdp_key_free(ctx, k);
    return -1;
}


/**
 * @brief Destroy and free allocated key material.
 * @return 0 on success, non-zero on error
 **/
int sepdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *k)
{
    pdp_sepdp_key_t *key = NULL;

    if (!is_sepdp(ctx) || !k || !k->sepdp)
        return -1;
    key = k->sepdp;

    sfree(key->W, key->W_size);
    sfree(key->Z, key->Z_size);
    sfree(key->K, key->K_size);
    sfree(key, sizeof(pdp_sepdp_key_t));
    k->sepdp = NULL;
    return 0;
}

/** @} */
