/**
 * @file
 * Implementation of the MAC-PDP module for flat-file storage.
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
#include <unistd.h>
#include <errno.h>
#ifdef _THREAD_SUPPORT
#include <pthread.h>
#endif
#include <pdp.h>
#include <pdp/macpdp.h>
#include "pdp_misc.h"
#include "pdp_storage.h"
#include "macpdp_storage.h"

/**
 * @brief Write tag data out to a file.
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     t      pointer to tag data.
 * @return 0 on success, non-zero on error
 **/
int macpdp_write_tags_to_file(const pdp_ctx_t *ctx, 
                              const pdp_macpdp_tagdata_t* t)
{
    pdp_macpdp_ctx_t *p = ctx->macpdp_param;
    FILE *tagfile = NULL;
    unsigned char *tag_ptr = NULL;
    int i, len, status = -1;

    if (!is_macpdp(ctx) || !t || !t->tags || !ctx->ofilepath)
        return -1;

    if ((access(ctx->ofilepath, F_OK) == 0) && (ctx->verbose)) {
        PDP_ERR("WARNING: overwriting [%s]", ctx->ofilepath);
    }
    if ((tagfile = fopen(ctx->ofilepath, "w")) == NULL){
        PDP_ERR("%d", ferror(tagfile));
        PDP_ERR("unable to create %s", ctx->ofilepath);
        goto cleanup;
    }

    tag_ptr = t->tags;
    len = p->tag_size;
    for(i = 0; i < p->num_blocks; i++) {
        tag_ptr += i ? len : 0;
        
        fwrite(tag_ptr, len, 1, tagfile);
        if (ferror(tagfile)) goto cleanup;
    }
    status = 0;

cleanup:
    if (tagfile) fclose(tagfile);
    return status;
}


/**
 * @brief Implements the interface of pdp_get_tag_noop
 * 
 * To be used with MAC-PDP and a flat-file storage back-end.
 *
 * @todo Use mmap to speed up access?
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     i      the index of tag.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    initially the size of buf, output bytes written.
 * @return 0 on success, non-zero on error
 **/
int macpdp_get_tag_file(const pdp_ctx_t* ctx, unsigned int i, 
                        void *b, unsigned int *len)
{
    pdp_macpdp_ctx_t *p = ctx->macpdp_param;
    unsigned char *buf = (unsigned char *) b;
    static FILE* tagfile = NULL;
    int pos = 0;

    // if buf is NULL, its a signal to re-set the stateful variables
    if (!buf && tagfile) {
        fclose(tagfile);
        tagfile = NULL;
        return 0;
    }
    
    if (!is_macpdp(ctx) || !buf || !len || !*len)
        return -1;

    if (*len % p->tag_size)
        PDP_ERR("warning: reading a partial tag (buffer is "
                "%d bytes; tag is %d bytes)", *len, p->tag_size);
    memset(buf, 0, *len);

    // if file is not open already, open it
    if (!tagfile && ((tagfile = fopen(ctx->ofilepath, "r")) == NULL)) {
        PDP_ERR("unable to open %s", ctx->ofilepath);
        return -1;
    }
    
    // seek to correct place in file and read out the requested tag
    pos = i * p->tag_size;
    if (fseek(tagfile, pos, SEEK_SET) != 0) {
        PDP_ERR("fseek error %d", errno);
        return -1;
    }
    *len = fread(buf, 1, *len, tagfile);

    return 0;
}


/**
 * @brief Implements the interface of pdp_get_block_noop
 * 
 * To be used with MAC-PDP and a flat-file storage back-end.
 *
 * @todo Use mmap to speed up access?
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     i      the index of block.
 * @param[out]    b      pointer to an output buffer.
 * @param[in,out] len    initially the size of buf, output bytes written.
 * @return 0 on success, non-zero on error
 **/
int macpdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
                          void *b, unsigned int *len)
{
    if (!is_macpdp(ctx)) return -1;
    return pdp_get_block_file(ctx, i, ctx->macpdp_param->block_size, 
                              (unsigned char *) b, len);
}

/** @} */
