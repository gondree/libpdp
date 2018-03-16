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
#ifdef _S3_SUPPORT
#include <libgen.h>
#include <libs3.h>
#endif
#include <pdp.h>
#include <pdp/mrpdp.h>
#include "pdp_misc.h"
#include "pdp_storage.h"
#include "mrpdp_storage.h"
#include "mrpdp_misc.h"


/**
 * @brief Write out file and tag data to S3.
 * @param[in]     ctx     pointer to a context structure.
 * @param[in]     t       pointer to the tag structure.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_write_data_to_s3(const pdp_ctx_t *ctx, const pdp_mrpdp_tagdata_t* t)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned char *buf = NULL;
    unsigned int len = 0;
    int status = -1;

    if (!t || !t->tags) return -1;
    
    // write file to s3
    if (pdp_write_file_to_s3(ctx, ctx->filepath)) {
        PDP_ERR("error writing original file to s3");
        return -1;
    }
    // write tags to s3
    if ((mrpdp_serialize_tags(ctx, t, &buf, &len)) != 0) goto cleanup;
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
 * @brief Implements the interface of get_tag_stub()
 * 
 * To be used with A-PDP and S3 storage back-end.
 *
 * @param[in]     ctx     pointer to a context structure.
 * @param[in]     index   the index of tag.
 * @param[out]    buffer  pointer to an output buffer.
 * @param[in,out] b_len   the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
                    void *buffer, unsigned int* b_len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    pdp_mrpdp_tag_t **tag_ptr = (pdp_mrpdp_tag_t **) buffer;
    pdp_mrpdp_tag_t *tag = NULL;
    unsigned char *buf = NULL;
    unsigned int i = 0;
    unsigned int buf_len = 0;
    unsigned int buf_size = 0;
    int status = -1;

    if (!ctx || !tag_ptr)
        return -1;

    // Allocate space for the tag
    if ((tag = mrpdp_tag_new()) == NULL) goto cleanup;
    if (*tag_ptr != NULL) {
        // there is already a tag here, so free it
        mrpdp_tag_free(*tag_ptr);
    }
    *tag_ptr = tag;
    
    buf_size = mrpdp_serialized_tag_size(ctx);
    if ((buf = malloc(buf_size)) == NULL) goto cleanup;
    memset(buf, 0, buf_size);
    i = index * buf_size;
    buf_len = buf_size;
    if (pdp_get_chunk_from_s3(ctx, ctx->ofilepath, &buf, &buf_len, i) != 0)
        goto cleanup;
    if (buf_len != buf_size)
        goto cleanup;
    if (mrpdp_deserialize_tag(ctx, tag, buf, buf_size) != 0)
        goto cleanup;
    status = 0;

#ifdef _PDP_DEBUG
        DEBUG(1, "\n Reading - ");
        DEBUG(1, "\n Tag %02d", index);
        DEBUG(1, "\n  Tim byte len [%02d]", BN_num_bytes(tag->Tim));
        DEBUG(1, "\n  Tim (hex) [%s]", BN_bn2hex(tag->Tim));
        DEBUG(1, "\n  index [%d]",  tag->index);
        DEBUG(1, "\n  prf_size [%d]", tag->index_prf_size);
        pdp_hexdump("  prf", index, tag->index_prf, tag->index_prf_size);
        pdp_hexdump(" Ser. tag", index, buf, buf_size);
#endif // _PDP_DEBUG

cleanup:
    sfree(buf, buf_len);
    if (status) {
        mrpdp_tag_free(tag);
        if (tag_ptr && *tag_ptr) *tag_ptr = NULL;
    }
    return status;
#endif // _S3_SUPPORT
}


/**
 * @brief Implements the interface of get_block_stub()
 * 
 * To be used with A-PDP and S3 storage back-end.
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     index  the index of tag.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
                      void *b, unsigned int* len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned int i = index * ctx->mrpdp_param->block_size;
    unsigned char *buf = (unsigned char *) b;
    return pdp_get_chunk_from_s3(ctx, ctx->filepath, &buf, len, i);
#endif // _S3_SUPPORT
}

/** @} */
