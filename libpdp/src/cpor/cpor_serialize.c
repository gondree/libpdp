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
/** @addtogroup CPOR
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <pdp.h>
#include <pdp/cpor.h>
#include "cpor_misc.h"
#include "pdp_misc.h"


/**
 * @brief Returns the upper bound of the serialized token
 *
 * Each token is of the form:
 *  <index, sigma len, sigma>
 **/
unsigned int cpor_serialized_tag_size(const pdp_ctx_t *ctx)
{
    pdp_cpor_ctx_t *p = NULL;

    if (!is_cpor(ctx)) return -1;
    p = ctx->cpor_param;

    return (sizeof(unsigned int) + sizeof(size_t) + (p->Zp_bits + 7)/8);
}


/**
 * @brief Write out tag data to a buffer
 *
 * @todo This serialization is not portable.
 * @param[in]  ctx         context
 * @param[in]  t           pointer to input tag data
 * @param[in]  buffer      the buffer for the serialized data
 * @param[in]  buffer_len  length of space available, output bytes written
 * @return 0 on success, non-zero on error
 **/
int cpor_serialize_tags(const pdp_ctx_t *ctx, const pdp_cpor_tagdata_t* t,
                        unsigned char **buffer, unsigned int *buffer_len)
{
    pdp_cpor_ctx_t *p = NULL;
    pdp_cpor_tag_t *tag = NULL;
    unsigned char *buf_ptr = NULL;
    unsigned char *buf = NULL;
    unsigned char *sigma = NULL;
    size_t tag_size, sigma_size, sigma_len;
    unsigned int buf_len;
    int i, status = -1;

    if (!is_cpor(ctx) || !t || !buffer || !buffer_len ||
                         !t->tags || !t->tags_num || !t->tags_size)
        return -1;
    p = ctx->cpor_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = cpor_serialized_tag_size(ctx);
    sigma_size = (p->Zp_bits + 7)/8; // Size is max size log2(key->Zp)
    
    // Tag is <index, sigma_size, sigma>
    buf_len = t->tags_num * tag_size;

    // allocate buffers
    if ((sigma = malloc(sigma_size)) == NULL) goto cleanup;
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;
    memset(buf, 0, buf_len);
    buf_ptr = buf;

    for(i = 0; i < t->tags_num; i++) {
        tag = t->tags[i];

        // get real sigma byte len
        sigma_len = BN_num_bytes(tag->sigma);

        // make sure our assumptions re: bounds are correct
        if (sigma_len > sigma_size) goto cleanup;

        // write index
        memcpy(buf_ptr, &(tag->index), sizeof(tag->index));
        buf_ptr += sizeof(tag->index);

        // write sigma size
        memcpy(buf_ptr, &sigma_len, sizeof(sigma_len));
        buf_ptr += sizeof(sigma_len);
        
        // write sigma
        memset(sigma, 0, sigma_size);
        if (!BN_bn2bin(tag->sigma, sigma)) goto cleanup;
        memcpy(buf_ptr, sigma, sigma_size);
        buf_ptr += sigma_size;
        
#ifdef _PDP_DEBUG
        DEBUG(1, "\n Writing - ");
        DEBUG(1, "\n Tag %02d", i);
        DEBUG(1, "\n  index [%d]",  tag->index);
        DEBUG(1, "\n  Sigma byte len [%02d]", BN_num_bytes(tag->sigma));
        DEBUG(1, "\n  Sigma (hex) [%s]", BN_bn2hex(tag->sigma));
        pdp_hexdump(" Ser. tag", i, buf_ptr - tag_size, tag_size);
#endif // _PDP_DEBUG

    }
    *buffer = buf;
    *buffer_len = buf_len;
    status = 0;

cleanup:
    sfree(sigma, sigma_size);
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
int cpor_deserialize_tag(const pdp_ctx_t *ctx, pdp_cpor_tag_t* tag,
                         unsigned char *buf, unsigned int buf_len)
{
    pdp_cpor_ctx_t *p = NULL;
    unsigned char *buf_ptr = buf;
    unsigned char *sigma = NULL;
    size_t sigma_size, tag_size;
    size_t sigma_len = 0;
    int status = -1;
    
    if (!is_cpor(ctx) || !tag || !buf || !buf_len)
        return -1;
    p = ctx->cpor_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = cpor_serialized_tag_size(ctx);
    sigma_size = (p->Zp_bits + 7)/8; // Size is max size log2(key->Zp)

    // double-check size of buf
    if (buf_len < tag_size) goto cleanup;

    // Tag is <index, sigma_size, sigma>
    memcpy(&(tag->index), buf_ptr, sizeof(tag->index));
    buf_ptr += sizeof(tag->index);

    // read sigma size
    memcpy(&sigma_len, buf_ptr, sizeof(sigma_len));
    buf_ptr += sizeof(sigma_len);

    // double-check the size is sensible
    if (sigma_size < sigma_len) goto cleanup;

    // read sigma
    if ((sigma = malloc(sigma_len)) == NULL) goto cleanup;
    memset(sigma, 0, sigma_len);
    memcpy(sigma, buf_ptr, sigma_len);
    if (!BN_bin2bn(sigma, sigma_len, tag->sigma)) goto cleanup;

    status = 0;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Reading - ");
    DEBUG(1, "\n Tag %02d", tag->index);
    DEBUG(1, "\n  Sigma byte len [%02d]", BN_num_bytes(tag->sigma));
    DEBUG(1, "\n  Sigma (hex) [%s]", BN_bn2hex(tag->sigma));
    pdp_hexdump(" Ser. tag", tag->index, buf, buf_len);
#endif // _PDP_DEBUG

cleanup:
    sfree(sigma, sigma_len);
    return status;
}

/** @} */
