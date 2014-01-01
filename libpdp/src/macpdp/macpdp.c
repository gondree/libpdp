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
#include <errno.h>
#ifdef _THREAD_SUPPORT
#include <pthread.h>
#endif
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>
#include <pdp/macpdp.h>
#include "pdp_misc.h"
#include "macpdp_storage.h"


/// a struct that holds all the arguments for a worker thread
struct pdp_job_arg {
    pdp_ctx_t *ctx;             ///< context
    pdp_macpdp_key_t *key;      ///< key
    FILE *file;                 ///< file to tag, a unique fd for this job
    int index;                  ///< used to determine which blocks to tag
    int numblocks;              ///< number of blocks this job needs to tag
    unsigned char *tags;        ///< memory used to store the result
};


/**
 * @brief Implements sanitize_stub()
 * @return 0 on success, non-zero on error
 **/
static int macpdp_chal_sanitize(const pdp_ctx_t* ctx, 
                                const pdp_challenge_t* c_i, 
                                pdp_challenge_t* c_o)
{
    int i;
    
    if (!is_macpdp(ctx) || !c_i || !c_o)
        return -1;

    if ((c_o->macpdp = malloc(sizeof(pdp_macpdp_challenge_t))) == NULL)
        goto cleanup;
    memset(c_o->macpdp, 0, sizeof(pdp_macpdp_challenge_t));
    
    c_o->macpdp->ell = c_i->macpdp->ell;
    c_o->macpdp->I = malloc(sizeof(unsigned int) * c_o->macpdp->ell);
    if (c_o->macpdp->I == NULL) goto cleanup;
    memset(c_o->macpdp->I, 0, sizeof(unsigned int) * c_o->macpdp->ell);
    for (i=0; i < c_o->macpdp->ell; i++) {
        c_o->macpdp->I[i] = c_i->macpdp->I[i];
    }
    return 0;

cleanup:
    macpdp_challenge_free(ctx, c_o->macpdp); 
    return -1;
}



/**
 * @brief Initializes the default context for macpdp.
 * @return 0 on success, non-zero on error
 **/
int macpdp_ctx_init(pdp_ctx_t *ctx)
{
    pdp_macpdp_ctx_t *p = NULL;
    if (!ctx || (ctx->algo != PDP_MACPDP))
        return -1;
    // need to free in macpdp_ctx_free
    if ((p = malloc(sizeof(pdp_macpdp_ctx_t))) == NULL)
        return -1;
    memset(p, 0, sizeof(pdp_macpdp_ctx_t));
    ctx->macpdp_param = p;
    return 0;
}


/**
 * @brief Initializes the default context for macpdp.
 * 
 * Expects ctx->macpdp to point to a fully-allocated
 * pdp_macpdp_ctx_t structure.
 *
 * @return 0 on success, non-zero on error
 **/
int macpdp_ctx_create(pdp_ctx_t *ctx)
{
    pdp_macpdp_ctx_t *p = NULL;
    unsigned int tmp;

    if (!is_macpdp(ctx))
        return -1;    
    p = ctx->macpdp_param;

    if (!p->prf_key_size) {
        p->prf_key_size = MACPDP_DEFAULT_PRF_KEY_BYTES;
    }

    // default blocksize
    tmp = p->block_size;
    if (!tmp) {
        tmp = MACPDP_DEFAULT_BLOCK_SIZE_BYTES;
    } else {
        // 'clean' any non-default value specified
        tmp = next_pow_2(tmp);
        tmp = (tmp <= 128) ? 256 : tmp;
    }
    p->block_size = tmp;

    // default challenge params
    if (!p->num_challenge_blocks) {
        p->num_challenge_blocks = MACPDP_MAGIC_CHALLENGE_NUM;
    }
    
    // default tag size
    if (!p->tag_size) {
        p->tag_size = MACPDP_DEFAULT_TAG_SIZE_BYTES;
    }

    // set number of blocks, if possible to do so early
    p->num_blocks = 0;
    if (ctx->file_st_size) {
        p->num_blocks = (ctx->file_st_size / p->block_size);
        p->num_blocks = (p->num_blocks < 1) ? 1 : p->num_blocks;
    }

    // set default function pointers
    if (ctx->opts & PDP_OPT_USE_S3) {
        ctx->ops->get_tag = macpdp_get_tag_s3;
        ctx->ops->get_block = macpdp_get_block_s3;
    } else {
        ctx->ops->get_tag = macpdp_get_tag_file;
        ctx->ops->get_block = macpdp_get_block_file;
    }
    ctx->ops->sanitize = macpdp_chal_sanitize;

    return 0;
}


/**
 * @brief Free the context for macpdp.
 * @return 0 on success, non-zero on error
 **/
int macpdp_ctx_free(pdp_ctx_t *ctx)
{
    if (!ctx)
        return -1;
    sfree(ctx->macpdp_param, sizeof(pdp_macpdp_ctx_t));
    return 0;
}


/**
 * @brief Tags a block of data.
 * @param[in]    ctx      context
 * @param[in]    key      key
 * @param[in]    block    block data
 * @param[in]    index    block index
 * @param[out]   tag      points to filled out tag data
 * @param[out]   tag_len  number of bytes written to tag
 * @return 0 on success, non-zero on error
 **/
static int macpdp_tag_block(const pdp_ctx_t *ctx, const pdp_macpdp_key_t *key,
                            const unsigned char *block, unsigned int index, 
                            unsigned char *tag, unsigned int *tag_len)
{
    HMAC_CTX hctx;
    pdp_macpdp_ctx_t *p;
    
    if (!is_macpdp(ctx) || !key || !block || !tag || !tag_len)
        return -1;
    p = ctx->macpdp_param;
    
    // calculate the tag for this block
    HMAC_CTX_init(&hctx);
    HMAC_Init(&hctx, key->prf_key, key->prf_key_size, EVP_sha1());
    HMAC_Update(&hctx, (const unsigned char *) &index, sizeof(unsigned int));
    HMAC_Update(&hctx, (unsigned char *) ctx->filepath, (int) ctx->filepath_len);
    HMAC_Update(&hctx, block, p->block_size);
    HMAC_Final(&hctx, tag, tag_len);
    HMAC_cleanup(&hctx);

#ifdef _PDP_DEBUG
    pdp_hexdump("block", index, block, p->block_size);
    pdp_hexdump("tag", index, tag, p->tag_size);
#endif // _PDP_DEBUG

    return 0;
}



/**
 * @brief Describes a single tagging job.
 *
 * If num_threads is 1, this performs all the tagging, serially.
 **/
static void *macpdp_tag_thread(void *args)
{
    struct pdp_job_arg *arg = (struct pdp_job_arg *) args;
    pdp_ctx_t *ctx;
    pdp_macpdp_ctx_t *p;
    unsigned char *tag = NULL;
    unsigned int tag_len = 0;
    unsigned char *buf = NULL;
    unsigned int i, block;
    int *ret = NULL;
    
    if (!arg || !arg->ctx || !arg->key || !arg->file ||
                !arg->tags || !arg->numblocks)
        goto cleanup;

    ctx = arg->ctx; 
    p = ctx->macpdp_param;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Tagging %d blocks", arg->numblocks);
#endif // _PDP_DEBUG
    
    // allocate memory for return value (will be freed by producer thread)
    if ((ret = malloc(sizeof(int))) == NULL)
        goto cleanup;
    *ret = -1;

    // allocate temp memory for reading a block and generating a tag
    if ((buf = malloc(sizeof(unsigned char) * p->block_size)) == NULL)
        goto cleanup;
    if ((tag = malloc(sizeof(unsigned char) * p->tag_size)) == NULL)
        goto cleanup;

    // For N threads, read and tag every N-th block
    block = arg->index;
    for (i = 0; i < arg->numblocks; i++) {
        memset(buf, 0, p->block_size);
        memset(tag, 0, p->tag_size);

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Tagging block %02d", block);
#endif // _PDP_DEBUG

        // read file data
        fseek(arg->file, block * p->block_size, SEEK_SET);
        fread(buf, 1, p->block_size, arg->file);
        if (ferror(arg->file)) goto cleanup;

        // calculate the tag for this block
        if (macpdp_tag_block(ctx, arg->key, buf, block, tag, &tag_len) != 0)
            goto cleanup;

        // store the computed digest to correct location in tags output buffer
        memcpy((arg->tags + (p->tag_size * block)), tag, tag_len);

        block += ctx->num_threads;
    }
    *ret = 0;

cleanup:
    if (!ret || (ret && *ret))
        PDP_ERR("some thread was unable to create a tag.");
    sfree(buf, sizeof(unsigned char) * p->block_size);
    sfree(tag, sizeof(unsigned char) * p->tag_size);
#ifdef _THREAD_SUPPORT
    if (ctx->num_threads > 1)
        pthread_exit(ret);
#endif
    return ret;
}


/**
 * @brief Sets up the job and then generates all tags, serially.
 * @return 0 on success, non-zero on error
 **/
static int macpdp_gen_tags_all(pdp_ctx_t *ctx, pdp_macpdp_key_t *k,
                               pdp_macpdp_tagdata_t *t)
{
    pdp_macpdp_ctx_t *p = ctx->macpdp_param;
    struct pdp_job_arg arg;
    int *ret = NULL;
    int status = -1;

    // populate the arguments to perform the job
    arg.ctx = ctx;
    arg.key = k;
    arg.index = 0;
    arg.numblocks = p->num_blocks;
    arg.tags = t->tags;
    arg.file = fopen(ctx->filepath, "r");
    if (!arg.file) goto cleanup;

    // perform the job
    ret = (int *) macpdp_tag_thread((void *) &arg);
    
    // check the return code for error
    if (!ret || (*ret != 0)) goto cleanup;
    status = 0;
    
cleanup:
    if (arg.file) fclose(arg.file);
    if (ret) free(ret);
    return status;
}


/**
 * @brief Sets up and spawns all the worker threads to tag.
 * @return 0 on success, non-zero on error
 **/
static int macpdp_gen_tags_all_threaded(pdp_ctx_t *ctx, pdp_macpdp_key_t *k,
                                        pdp_macpdp_tagdata_t *t)
{
#ifndef _THREAD_SUPPORT
    PDP_UNSUPPORTED("pthread");
    return -1;
#else
    pdp_macpdp_ctx_t *p = ctx->macpdp_param; // our params in ctx
    pthread_t *threads = NULL;
    struct pdp_job_arg *args = NULL;
    int *ret = NULL;
    int i, err;

    if ((threads = malloc(sizeof(pthread_t) * ctx->num_threads)) == NULL)
        goto cleanup;
    memset(threads, 0, sizeof(pthread_t) * ctx->num_threads);
    if ((args = malloc(sizeof(struct pdp_job_arg) * ctx->num_threads)) == NULL)
        goto cleanup;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Number of threads: %d", ctx->num_threads);
#endif // _PDP_DEBUG

    // spawn each thread
    for (i=0; i < ctx->num_threads; i++) {
        // open a unique fd for each thread
        args[i].file = fopen(ctx->filepath, "r");
        if (!args[i].file) goto cleanup;
        args[i].key = k;
        args[i].ctx = ctx;
        args[i].index = i;
        args[i].numblocks = p->num_blocks/ctx->num_threads;
        args[i].tags = t->tags;

        // if there is not an equal number of blocks to tag, add the 
        // extra blocks to the corresponding thread
        if (i < p->num_blocks % ctx->num_threads)
            args[i].numblocks++;
        
        // If the thread has blocks to tag, then spawn it
        if (args[i].numblocks > 0) {
            err = pthread_create(&threads[i], NULL, macpdp_tag_thread,
                                 (void *) &args[i]);
            if (err)
                goto cleanup;
        }
    }
    // check each thread for error
    for (i=0; i < ctx->num_threads; i++) {
        if (!threads[i]) {
            continue;
        }
        // wait for the job to complete
        if (pthread_join(threads[i], (void **) &ret))
            goto cleanup;
        // check its return value
        if (!ret || (*ret != 0))
            goto cleanup;
        // free the space for its return value
        free(ret);
    }
    // close any files
    for (i=0; i < ctx->num_threads; i++) {
        if (args && args[i].file) {
            fclose(args[i].file);
            args[i].file = NULL;
        }
    }
    // free common thread resources
    sfree(threads, sizeof(pthread_t) * ctx->num_threads);
    sfree(args, sizeof(struct pdp_job_arg) * ctx->num_threads);
    return 0;

cleanup:
    /// @todo Cancelling threads, but they are not cancellation-safe, 
    /// so this should be re-thought

    // cancel outstanding threads
    for (i=0; i < ctx->num_threads; i++) {
        if (threads[i] != 0) 
            pthread_cancel(threads[i]);
    }
    // close their files
    for (i=0; i < ctx->num_threads; i++) {
        if (args && args[i].file) {
            fclose(args[i].file);
            args[i].file = NULL;
        }
    }
    sfree(threads, sizeof(pthread_t) * ctx->num_threads);
    sfree(args, sizeof(struct pdp_job_arg) * ctx->num_threads);
    return -1;
#endif
}


/**
 * @brief Access the (local) file and generate tags.
 *
 * The tag structure is parsed the following way:
 * @verbatim
   t->tags
       0                                         (t->tags_size-1)
       |  tag for  |  tag for  | ... |  tag for  |
       |  block 0  |  block 1  |     | block n-1 |
       |<--- s --->|<--- s --->|     |<--- s --->|
   where n = ctx->macpdp_param->num_blocks
         s = ctx->macpdp_param->tag_size
   @endverbatim
 * This structure relies on knowing the system-wide
 * parameters (n,s) and assumes the MAC is not variable-length.
 *
 * @param[in,out]  ctx  The context for the PDP routine.
 * @param[in]      k    The secret key data.
 * @param[out]     t    The tag data that is generated.
 * @return 0 on success, non-zero on error
 **/
int macpdp_tags_gen(pdp_ctx_t *ctx, pdp_macpdp_key_t *k, 
                    pdp_macpdp_tagdata_t *t)
{
    pdp_macpdp_ctx_t *p = NULL;
    unsigned char *tags = NULL;
    unsigned int num_blocks = 0;
    int err = 0;

    if (!is_macpdp(ctx) || !k)
        return -1;
    p = ctx->macpdp_param;
    t->tags = NULL;

    // our caller filled out some ctx at this point, so
    // we can calculate some relevant params
    num_blocks = (ctx->file_st_size / p->block_size);
    if (ctx->file_st_size % p->block_size)
        num_blocks++;
    p->num_blocks = num_blocks;

    // allocate space for tags
    t->tags_size = p->tag_size * p->num_blocks;
    if ((tags = malloc(t->tags_size)) == NULL) goto cleanup;
    memset(tags, 0, t->tags_size);
    t->tags = tags;

    // now we can start tagging    
    if ((ctx->opts & PDP_OPT_THREADED) && (ctx->num_threads > 1)) {
        // if are using threads
        err = macpdp_gen_tags_all_threaded(ctx, k, t);
    } else {
        // no threads
        err = macpdp_gen_tags_all(ctx, k, t);
    }

    if (err)
        goto cleanup;
    return 0;

cleanup:
    sfree(tags, t->tags_size);
    return -1;
}


/**
 * @brief Frees a tags structure
 * @return 0 on success, non-zero on error
 **/
int macpdp_tags_free(const pdp_ctx_t *ctx, pdp_macpdp_tagdata_t *t)
{
    if (!t || !t->tags_size)
        return -1;
    sfree(t->tags, t->tags_size);
    return 0;
}


/**
 * @brief Stores data and tags.
 * @return 0 on success, non-zero on error
 **/
int macpdp_store(const pdp_ctx_t *ctx, const pdp_macpdp_tagdata_t* tag)
{
    if (!is_macpdp(ctx))
        return -1;

    if (ctx->opts & PDP_OPT_USE_S3) {
        // we need to write ctx->filepath and the tagdata to S3
        return macpdp_write_data_to_s3(ctx, tag);
    } else {
        // the file we tagged is already stored in ctx->filepath
        // so we only need to write tag data to ctx->ofilepath
        return macpdp_write_tags_to_file(ctx, tag);
    }
    return -1;
}


/**
 * @brief Generates a vector of block indices, as a challenge.
 * @return 0 on success, non-zero on error
 **/
int macpdp_challenge_gen(const pdp_ctx_t *ctx, pdp_macpdp_challenge_t *c)
{
    unsigned int ell;
    pdp_macpdp_ctx_t *p = NULL;
    
    if (!is_macpdp(ctx) || !c)
        return -1;
    p = ctx->macpdp_param;

    if (!p->num_blocks || !p->num_challenge_blocks)
        return -1;

    // we will challenge ell blocks
    ell = (p->num_blocks > p->num_challenge_blocks) ? 
            p->num_challenge_blocks : p->num_blocks;
    
    // allocate space for challenges
    if ((c->I = malloc(sizeof(unsigned int) * ell)) == NULL)
        goto cleanup;
    memset(c->I, 0, sizeof(unsigned int) * ell);
    c->ell = ell;

    // generate challenges
    if (sample_sans_replacement(c->ell, p->num_blocks, c->I))
        goto cleanup;
    return 0;
    
cleanup:
    macpdp_challenge_free(ctx, c);
    return -1;
}


/**
 * @brief Frees a challenge structure.
 * @return 0 on success, non-zero on error
 **/
int macpdp_challenge_free(const pdp_ctx_t *ctx, pdp_macpdp_challenge_t *c)
{
    if (!is_macpdp(ctx) || !c)
        return -1;
    if (c->I)
        sfree(c->I, sizeof(unsigned int) * c->ell);
    memset(c, 0, sizeof(pdp_macpdp_challenge_t));
    return 0;
}


/**
 * @brief Generates a proof.
 * @return 0 on success, non-zero on error
 **/
int macpdp_proof_gen(const pdp_ctx_t *ctx, const pdp_macpdp_challenge_t *c,
                     pdp_macpdp_proof_t *proof)
{
    unsigned char *block_ptr, *tag_ptr;
    pdp_macpdp_ctx_t *p = NULL;
    unsigned int i, err, block_len = 0, tag_len = 0;
    
    if (!is_macpdp(ctx) || !c || !proof)
        return -1;
    p = ctx->macpdp_param;

    proof->ell = c->ell;
    proof->B = calloc(c->ell, p->block_size);
    proof->T = calloc(c->ell, p->tag_size);
    if (!proof->B || !proof->T) {
        PDP_ERR("malloc failed: errno %d", errno);
        goto cleanup;
    }

    tag_ptr = proof->T;
    block_ptr = proof->B;
    for(i = 0; i < c->ell; i++) {
        // set to the available space in each buffer
        tag_len = p->tag_size;
        block_len = p->block_size;

        // advance the pointer by the size of what we read
        block_ptr += i ? block_len: 0;
        tag_ptr   += i ? tag_len : 0;

        err = ctx->ops->get_tag(ctx, c->I[i], tag_ptr, &tag_len);
        if (err) goto cleanup;
        err = ctx->ops->get_block(ctx, c->I[i], block_ptr, &block_len);
        if (err) goto cleanup;
    }
    // 'finish' access to stateful methods
    ctx->ops->get_tag(ctx, 0, NULL, NULL);
    ctx->ops->get_block(ctx, 0, NULL, NULL);
    return 0;
    
cleanup:
    sfree(proof->B, c->ell * p->block_size);
    sfree(proof->T, c->ell * p->tag_size);
    ctx->ops->get_tag(ctx, 0, NULL, NULL);
    ctx->ops->get_block(ctx, 0, NULL, NULL);
    return -1;
}


/**
 * @brief Verifies a single block relative to a tag.
 * @return 0 on success, non-zero on error
 **/
static int macpdp_verify_block(const pdp_ctx_t *ctx, const pdp_macpdp_key_t *key, 
                               unsigned int index, const unsigned char *block, 
                               const unsigned char *tag)
{
    HMAC_CTX hctx;
    pdp_macpdp_ctx_t *p = NULL;
    unsigned char *digest = NULL;
    unsigned int digest_len = 0;
    int err = -1;
    
    if (!is_macpdp(ctx) || !key || !block || !tag)
        return -1;
    p = ctx->macpdp_param;

    if ((digest = calloc(1, p->tag_size)) == NULL)
        return -1;
    
    HMAC_CTX_init(&hctx);
    HMAC_Init(&hctx, key->prf_key, key->prf_key_size, EVP_sha1());
    HMAC_Update(&hctx, (const unsigned char *) &index, sizeof(unsigned int));
    HMAC_Update(&hctx, (unsigned char *)ctx->filepath, (int)ctx->filepath_len);
    HMAC_Update(&hctx, block, p->block_size);
    HMAC_Final(&hctx, digest, &digest_len);
    HMAC_cleanup(&hctx);
    err = memcmp(digest, tag, digest_len);

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Block %02d verified: %s", index, err ? "false" : "true");
    if (err) {
        pdp_hexdump("block", index, block, p->block_size);
        pdp_hexdump("tag", index, tag, p->tag_size);
        pdp_hexdump("digest", index, digest, digest_len);
    }
#endif // _PDP_DEBUG

    free(digest);    
    return err;
}


/**
 * @brief Verifies that a proof is a correct response to a challenge.
 * @return 0 on success, 1 on failure, -1 on error
 **/
int macpdp_proof_verify(const pdp_ctx_t *ctx, const pdp_macpdp_key_t *key,
                        const pdp_macpdp_challenge_t *c,
                        const pdp_macpdp_proof_t *proof)
{
    pdp_macpdp_ctx_t *p = NULL;
    unsigned char *block_ptr, *tag_ptr;
    int i;

    if (!is_macpdp(ctx) || !key || !c || !proof || !proof->T || !proof->B)
        return -1;
    p = ctx->macpdp_param;

    block_ptr = proof->B;
    tag_ptr = proof->T;
    for(i = 0; i < c->ell; i++) {
        block_ptr += i ? p->block_size : 0;
        tag_ptr += i ? p->tag_size : 0;
        
        if (macpdp_verify_block(ctx, key, c->I[i], block_ptr, tag_ptr)) {
            PDP_ERR("failed verification of I[%d] = %d", i, c->I[i]);
            return 1;
        }
    }
    return 0;
}


/**
 * @brief Frees the internal structures allocated within a proof.
 * @return 0 on success, non-zero on error
 **/
int macpdp_proof_free(const pdp_ctx_t *ctx, pdp_macpdp_proof_t *proof)
{
    if (!is_macpdp(ctx) || !proof || !proof->ell)
        return -1;

    sfree(proof->B, proof->ell * ctx->macpdp_param->block_size);
    sfree(proof->T, proof->ell * ctx->macpdp_param->tag_size);
    proof->ell = 0;
    return 0;
}

/** @} */
