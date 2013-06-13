/**
 * @file
 * Implementation of the MAC-PDP module for S3 storage.
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
#ifdef _S3_SUPPORT
#include <libgen.h>
#include <libs3.h>
#endif
#include <pdp.h>
#include <pdp/macpdp.h>
#include "pdp_misc.h"
#include "pdp_storage.h"
#include "sepdp_storage.h"
#include "sepdp_misc.h"

/**
 * @brief Write out file and tag data to S3.
 **/
int sepdp_write_data_to_s3(const pdp_ctx_t *ctx,
                            const pdp_sepdp_tagdata_t* t)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned char *buf = NULL;
    size_t len = 0;
    int status = -1;

    if (!t || !t->tokens) return -1;
    
    // write file to s3
    if (pdp_write_file_to_s3(ctx, ctx->filepath)) {
        PDP_ERR("error writing original file to s3");
        return -1;
    }
    // write tags to s3
    if ((sepdp_serialize_tags(ctx, t, &buf, &len)) != 0) goto cleanup;
    if (pdp_write_data_to_s3(ctx, ctx->ofilepath, buf, len)) {
        PDP_ERR("error writing tag data to s3");
        goto cleanup;
    }
    status = 0;

cleanup:
    sfree(buf, len);
    return status;
#endif // _S3_SUPPORT
}


/**
 * @brief Implements the interface of pdp_get_tag_noop
 * 
 * To be used with SEPDP and S3 storage back-end.
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     index  the index of tag.
 * @param[out]    buffer pointer to an output buffer.
 * @param[in,out] len    not used (output buffer is a pdp_sepdp_tag_t)
 * @return 0 on success, non-zero on error
 **/
int sepdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
                      void *buffer, unsigned int *len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    pdp_sepdp_tag_t **tag_ptr = (pdp_sepdp_tag_t **) buffer;
    pdp_sepdp_tag_t *tag = NULL;
    unsigned char *buf = NULL;
    unsigned int i = 0;
    size_t buf_len = 0;
    size_t buf_size = 0;
    int status = -1;

    if (!ctx || !tag_ptr)
        return -1;

    // Allocate space for the tag
    if ((tag = malloc(sizeof(pdp_sepdp_tag_t))) == NULL) goto cleanup;
    if (*tag_ptr != NULL) {
        // there is already a tag here, so free it
        sepdp_tag_free(ctx, *tag_ptr);
    }
    *tag_ptr = tag;
    
    buf_size = sepdp_serialized_tag_size(ctx);
    if ((buf = malloc(buf_size)) == NULL) goto cleanup;
    memset(buf, 0, buf_size);
    i = index * buf_size;
    buf_len = buf_size;
    if (pdp_get_chunk_from_s3(ctx, ctx->ofilepath, &buf, &buf_len, i) != 0)
        goto cleanup;
    if (buf_len != buf_size)
        goto cleanup;
    if (sepdp_deserialize_tag(ctx, tag, buf, buf_size) != 0)
        goto cleanup;
    status = 0;

cleanup:
    sfree(buf, buf_len);
    if (status) {
        sepdp_tag_free(ctx, tag);
        if (tag_ptr && *tag_ptr) *tag_ptr = NULL;
    }
    return status;
#endif // _S3_SUPPORT

}


/**
 * @brief Implements the interface of pdp_get_block_noop
 * 
 * To be used with SEPDP and S3 storage back-end.
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     index  the index of tag.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
int sepdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
                        void *b, unsigned int *len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned int i = index * ctx->sepdp_param->block_size;
    unsigned char *buf = (unsigned char *) b;
    return pdp_get_chunk_from_s3(ctx, ctx->filepath, &buf, len, i);
#endif // _S3_SUPPORT
}

/** @} */
