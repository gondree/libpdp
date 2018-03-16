/**
 * @file
 * Implementation of the MR-PDP module for S3 storage.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup MRPDP
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <pdp.h>
#include <pdp/mrpdp.h>
#include "mrpdp_misc.h"
#include "pdp_misc.h"


/**
 * @brief Returns the upper bound of the serialized token
 *
 * Each token is of the form:
 *  <Tag len, Tag, index, nonce len, nonce>
 **/
unsigned int mrpdp_serialized_tag_size(const pdp_ctx_t *ctx)
{
    pdp_mrpdp_ctx_t *p = NULL;

    if (!is_mrpdp(ctx)) return -1;
    p = ctx->mrpdp_param;

    return (sizeof(size_t) + (p->rsa_key_size + 7)/8 + sizeof(unsigned int) + 
            sizeof(size_t) + p->prf_w_size);
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
int mrpdp_serialize_tags(const pdp_ctx_t *ctx, const pdp_mrpdp_tagdata_t* t,
                        unsigned char **buffer, unsigned int *buffer_len)
{
    pdp_mrpdp_ctx_t *p = NULL;
    pdp_mrpdp_tag_t *tag = NULL;
    FILE *tagfile = NULL;
    unsigned char *buf_ptr = NULL;
    unsigned char *buf = NULL;
    unsigned char *tim = NULL;
    unsigned char *prf = NULL;
    size_t tag_size, prf_size, buf_len;
    size_t tim_size, tim_len = 0;
    int i, status = -1;

    if (!is_mrpdp(ctx) || !t || !buffer || !buffer_len ||
                         !t->tags || !t->tags_num || !t->tags_size)
        return -1;
    p = ctx->mrpdp_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = mrpdp_serialized_tag_size(ctx);
    tim_size = (p->rsa_key_size + 7)/8; // Tim is max size log2(rsa->n)
    prf_size = p->prf_w_size;
    
    // Tag is <tim_len, Tim, index, index_prf_size, index_prf>
    buf_len = t->tags_num * tag_size;

    // allocate buffers
    if ((prf = malloc(prf_size)) == NULL) goto cleanup;
    if ((tim = malloc(tim_size)) == NULL) goto cleanup;
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;
    memset(buf, 0, buf_len);
    buf_ptr = buf;

    for(i = 0; i < t->tags_num; i++) {
        tag = t->tags[i];
        memset(tim, 0, tim_len);
        memset(prf, 0, prf_size);

        // get real Tim byte len
        tim_len = BN_num_bytes(tag->Tim);

        // make sure our assumptions re: bounds are correct
        if (tim_len > tim_size) goto cleanup;
        if (tag->index_prf_size > prf_size) goto cleanup;

        // write Tim size
        memcpy(buf_ptr, &tim_len, sizeof(tim_len));
        buf_ptr += sizeof(tim_len);
        
        // write Tim
        if (!BN_bn2bin(tag->Tim, tim)) goto cleanup;
        memcpy(buf_ptr, tim, tim_size);
        buf_ptr += tim_size;

        // write index
        memcpy(buf_ptr, &(tag->index), sizeof(tag->index));
        buf_ptr += sizeof(tag->index);
        
        // write index_prf_size
        memcpy(buf_ptr, &(tag->index_prf_size), sizeof(tag->index_prf_size));
        buf_ptr += sizeof(tag->index_prf_size);

        // write index_prf
        memcpy(prf, tag->index_prf, tag->index_prf_size);
        memcpy(buf_ptr, prf, prf_size);
        buf_ptr += prf_size;

#ifdef _PDP_DEBUG
        DEBUG(1, "\n Writing - ");
        DEBUG(1, "\n Tag %02d", i);
        DEBUG(1, "\n  Tim byte len [%02d]", BN_num_bytes(tag->Tim));
        DEBUG(1, "\n  Tim (hex) [%s]", BN_bn2hex(tag->Tim));
        DEBUG(1, "\n  index [%d]",  tag->index);
        DEBUG(1, "\n  prf_size [%d]", tag->index_prf_size);
        pdp_hexdump("  prf", i, tag->index_prf, tag->index_prf_size);
        pdp_hexdump(" Ser. tag", i, buf_ptr - tag_size, tag_size);
#endif // _PDP_DEBUG

    }
    *buffer = buf;
    *buffer_len = buf_len;
    status = 0;

cleanup:
    if (tagfile) fclose(tagfile);
    sfree(tim, tim_size);
    sfree(prf, prf_size);
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
int mrpdp_deserialize_tag(const pdp_ctx_t *ctx, pdp_mrpdp_tag_t* tag,
                         unsigned char *buf, unsigned int buf_len)
{
    pdp_mrpdp_ctx_t *p = NULL;
    unsigned char *buf_ptr = buf;
    unsigned char *tim = NULL;
    size_t tag_size, prf_size;
    size_t tim_size, tim_len = 0;
    int status = -1;
    
    if (!is_mrpdp(ctx) || !tag || !buf || !buf_len)
        return -1;
    p = ctx->mrpdp_param;

    // some useful constants: upper bounds on sizes of things
    tag_size = mrpdp_serialized_tag_size(ctx);
    tim_size = (p->rsa_key_size + 7)/8; // Tim is max size log2(rsa->n)
    prf_size = p->prf_w_size;

    // double-check size of buf
    if (!tag_size || (buf_len > tag_size)) goto cleanup;

    // read Tim size
    memcpy(&tim_len, buf_ptr, sizeof(tim_len));
    buf_ptr += sizeof(tim_len);

    // read Tim
    if ((tim = malloc(tim_len)) == NULL) goto cleanup;
    memset(tim, 0, tim_len);
    memcpy(tim, buf_ptr, tim_len);
    buf_ptr += tim_size; // skip bytes of serialized Tim size
    if (!BN_bin2bn(tim, tim_len, tag->Tim)) goto cleanup;

    // read index
    memcpy(&(tag->index), buf_ptr, sizeof(tag->index));
    buf_ptr += sizeof(tag->index);
    
    // read index_prf_size
    memcpy(&(tag->index_prf_size), buf_ptr, sizeof(tag->index_prf_size));
    buf_ptr += sizeof(tag->index_prf_size);

    // double check size of prf
    if (!tag->index_prf_size || (tag->index_prf_size > prf_size)) goto cleanup;

    // read index_ptr
    if ((tag->index_prf = malloc(tag->index_prf_size)) == NULL) goto cleanup;
    memset(tag->index_prf, 0, tag->index_prf_size);
    memcpy(tag->index_prf, buf_ptr, tag->index_prf_size);
    buf_ptr += tag->index_prf_size;

    status = 0;

cleanup:
    sfree(tim, tim_len);
    return status;
}

/** @} */
