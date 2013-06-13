/**
 * @file
 * Implementation of the A-PDP module for S3 storage.
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
#include <sys/param.h>
#include <sys/stat.h>
#include <openssl/evp.h>
#include <pdp.h>
#include <pdp/sepdp.h>
#include "sepdp_misc.h"
#include "pdp_misc.h"

/**
 * @brief Returns the upper bound of the serialized token
 *
 * Each token is of the form:
 *  <index, iv_size, iv, token_size, token, mac_size, mac>
 **/
size_t sepdp_serialized_tag_size(const pdp_ctx_t *ctx)
{
    pdp_sepdp_ctx_t *p = NULL;

    if (!is_sepdp(ctx)) return -1;
    p = ctx->sepdp_param;

    return ( sizeof(unsigned int) + 
             sizeof(size_t) + p->ae_key_size + 
             sizeof(size_t) + p->block_size + 
             sizeof(size_t) + EVP_MAX_MD_SIZE );
}


/**
 * @brief Write out tag data to a buffer
 *
 * Serializes a set of tokens into an array of length ell
 * @verbatim
      (0)                                       (ell-1)
       |  token 0  |  token 1  | ... | token n-1 |
       |           |           |     |           |
       |<--- s --->|<--- s --->|     |<--- s --->|
   where n = t->tokens_num
         s = upper bound on token length
         ell = n * s
   @endverbatim
 *
 * @todo This serialization is not portable.
 * @param[in]  ctx         context
 * @param[in]  t           pointer to input tag data
 * @param[in]  buffer      the buffer for the serialized data
 * @param[in]  buffer_len  length of space available, output bytes written
 * @return 0 on success, non-zero on error
 **/
int sepdp_serialize_tags(const pdp_ctx_t *ctx, const pdp_sepdp_tagdata_t* t,
                         unsigned char **buffer, size_t *buffer_len)
{
    pdp_sepdp_ctx_t *p = NULL;
    pdp_sepdp_tag_t *tag = NULL;
    unsigned char *buf_ptr = NULL;
    unsigned char *buf = NULL;
    size_t tag_size, buf_len;
    int i, status = -1;

    if (!is_sepdp(ctx) || !t || !buffer || !buffer_len ||
                          !t->tokens || !t->tokens_num)
        return -1;
    p = ctx->sepdp_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = sepdp_serialized_tag_size(ctx);    
    buf_len = t->tokens_num * tag_size;

    // allocate buffers
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;
    memset(buf, 0, buf_len);
    buf_ptr = buf;

    for(i = 0; i < t->tokens_num; i++) {
        tag = t->tokens[i];

        // write index
        memcpy(buf_ptr, &(tag->index), sizeof(unsigned int));
        buf_ptr += sizeof(unsigned int);

        // make sure our assumptions re: bounds are correct
        if (tag->iv_size > p->ae_key_size) goto cleanup;

        // write iv length
        memcpy(buf_ptr, &(tag->iv_size), sizeof(size_t));
        buf_ptr += sizeof(size_t);

        // write iv
        memset(buf_ptr, 0, p->ae_key_size);
        memcpy(buf_ptr, tag->iv, tag->iv_size);
        buf_ptr += p->ae_key_size;

        // make sure our assumptions re: bounds are correct
        if (tag->tok_size > p->block_size) goto cleanup;
        
        // write token length
        memcpy(buf_ptr, &(tag->tok_size), sizeof(size_t));
        buf_ptr += sizeof(size_t);

        // write token
        memset(buf_ptr, 0, p->block_size);
        memcpy(buf_ptr, tag->tok, tag->tok_size);
        buf_ptr += p->block_size;
        
        // make sure our assumptions re: bounds are correct
        if (tag->mac_size > EVP_MAX_MD_SIZE) goto cleanup;
        
        // write token length
        memcpy(buf_ptr, &(tag->mac_size), sizeof(size_t));
        buf_ptr += sizeof(size_t);

        // write mac
        memset(buf_ptr, 0, EVP_MAX_MD_SIZE);
        memcpy(buf_ptr, tag->mac, tag->mac_size);
        buf_ptr += EVP_MAX_MD_SIZE;
    }
    *buffer = buf;
    *buffer_len = buf_len;
    status = 0;

cleanup:
    if (status) sfree(buf, buf_len);
    return status;
}


/**
 * @brief Read an individual tag
 * @param[in]  ctx      context
 * @param[out] tag      pointer to tag that will be populated
 * @param[in]  buf      serialized structure to process
 * @param[in]  buf_len  length of data to process
 * @return 0 on success, non-zero on error
 **/
int sepdp_deserialize_tag(const pdp_ctx_t *ctx, pdp_sepdp_tag_t* tag,
                          unsigned char *buf, size_t buf_len)
{
    pdp_sepdp_ctx_t *p = NULL;
    unsigned char *buf_ptr = buf;
    size_t tag_size;
    int status = -1;
    
    if (!is_sepdp(ctx) || !tag || !buf || !buf_len)
        return -1;
    p = ctx->sepdp_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = sepdp_serialized_tag_size(ctx);

    // double-check size of buf
    if (buf_len < tag_size) goto cleanup;

    memcpy(&(tag->index), buf_ptr, sizeof(unsigned int));
    buf_ptr += sizeof(unsigned int);

    memcpy(&(tag->iv_size), buf_ptr, sizeof(size_t));
    buf_ptr += sizeof(size_t);

    // make sure our assumptions re: bounds are correct
    if (tag->iv_size > p->ae_key_size) goto cleanup;
    
    if ((tag->iv = malloc(tag->iv_size)) == NULL) goto cleanup;
    memcpy(tag->iv, buf_ptr, tag->iv_size);
    buf_ptr += p->ae_key_size;
    
    memcpy(&(tag->tok_size), buf_ptr, sizeof(size_t));
    buf_ptr += sizeof(size_t);
    
    // make sure our assumptions re: bounds are correct
    if (tag->tok_size > p->block_size) goto cleanup;

    if ((tag->tok = malloc(tag->tok_size)) == NULL) goto cleanup;
    memcpy(tag->tok, buf_ptr, tag->tok_size);
    buf_ptr += p->block_size;

    memcpy(&(tag->mac_size), buf_ptr, sizeof(size_t));
    buf_ptr += sizeof(size_t);

    // make sure our assumptions re: bounds are correct
    if (tag->mac_size > EVP_MAX_MD_SIZE) goto cleanup;
    
    if ((tag->mac = malloc(tag->mac_size)) == NULL) goto cleanup;
    memcpy(tag->mac, buf_ptr, tag->mac_size);
    buf_ptr += EVP_MAX_MD_SIZE;

    status = 0;

cleanup:
    return status;
}

/** @} */
