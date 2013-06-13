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
/** @addtogroup MACPDP
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
#ifdef _THREAD_SUPPORT
#include <pthread.h>
#endif
#include <pdp.h>
#include <pdp/macpdp.h>
#include "pdp_misc.h"
#include "pdp_storage.h"
#include "macpdp_storage.h"


/**
 * @brief Write out file and tag data to S3.
 * @param[in]     ctx     pointer to a context structure.
 * @param[in]     t       pointer to the tag structure.
 * @return 0 on success, non-zero on error
 **/
int macpdp_write_data_to_s3(const pdp_ctx_t *ctx,
                            const pdp_macpdp_tagdata_t* t)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    if (!t || !t->tags)
        return -1;
    // write file to s3
    if (pdp_write_file_to_s3(ctx, ctx->filepath)) {
        PDP_ERR("error writing original file to s3");
        return -1;
    }
    // write tags to s3
    if (pdp_write_data_to_s3(ctx, ctx->ofilepath, t->tags, t->tags_size)) {
        PDP_ERR("error writing tag data to s3");
        return -1;
    }
    return 0;
#endif
}


/**
 * @brief Implements the interface of pdp_get_tag_noop
 * 
 * To be used with MAC-PDP and S3 storage back-end.
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     index  the index of tag.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
int macpdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
                      void *b, unsigned int* len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned int i = index * ctx->macpdp_param->tag_size;
    unsigned char *buf = (unsigned char *) b;
    return pdp_get_chunk_from_s3(ctx, ctx->ofilepath, &buf, len, i);
#endif
}


/**
 * @brief Implements the interface of pdp_get_block_noop
 * 
 * To be used with MAC-PDP and S3 storage back-end.
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     index  the index of tag.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
int macpdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
                        void *b, unsigned int* len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    unsigned int i = index * ctx->macpdp_param->block_size;
    unsigned char *buf = (unsigned char *) b;
    return pdp_get_chunk_from_s3(ctx, ctx->filepath, &buf, len, i);
#endif
}

/** @} */
