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
/** @addtogroup MACPDP
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>
#include <pdp/macpdp.h>
#include "pdp_misc.h"


/**
 * @brief Generate key material.
 *
 * Creates a random PRF key to use for our MAC (which is HMAC)
 *
 * @return 0 on success, non-zero on error
 **/
int macpdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k)
{
    pdp_macpdp_ctx_t *p = NULL;
    pdp_macpdp_key_t *key = NULL;

    if (!is_macpdp(ctx) || !k)
        return -1;
    p = ctx->macpdp_param;

    if (!p->prf_key_size)
        return -1;

    if ((key = malloc(sizeof(pdp_macpdp_key_t))) == NULL)
        return -1;
    memset(key, 0, sizeof(pdp_macpdp_key_t));
    k->macpdp = key;

    key->prf_key_size = p->prf_key_size;
    if ((key->prf_key = malloc(key->prf_key_size)) == NULL)
        goto cleanup;
    if (!RAND_bytes(key->prf_key, key->prf_key_size))
        goto cleanup;

    return 0;

 cleanup:
    macpdp_key_free(k);
    return -1;
}


/**
 * @brief Destroy and free allocated key material.
 * @return 0 on success, non-zero on error
 **/
int macpdp_key_free(pdp_key_t *k)
{
    if (!k || !k->macpdp)
        return -1;
    sfree(k->macpdp->prf_key, k->macpdp->prf_key_size);
    sfree(k->macpdp, sizeof(pdp_macpdp_key_t));
    return 0;
}

/** @} */
