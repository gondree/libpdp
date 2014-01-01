/**
 * @file
 * Implementation of the A-PDP module for libpdp.
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
#include <errno.h>
#ifdef _THREAD_SUPPORT
#include <pthread.h>
#endif
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <pdp/cpor.h>
#include "cpor_storage.h"
#include "cpor_misc.h"
#include "pdp_misc.h"

/// a struct that holds all the arguments for a worker thread
struct pdp_job_arg {
    pdp_ctx_t *ctx;             ///< context
    pdp_cpor_key_t *key;        ///< key
    FILE *file;                 ///< file to tag, a unique fd for this job
    int index;                  ///< used to determine which blocks to tag
    int numblocks;              ///< number of blocks this job needs to tag
    pdp_cpor_tagdata_t *td;     ///< tag data results / output
};


/**
 * @brief Implements sanitize_stub()
 * @return 0 on success, non-zero on error
 **/
static int cpor_chal_sanitize(const pdp_ctx_t* ctx, 
                              const pdp_challenge_t* c_i, pdp_challenge_t* c_o)
{
    int i, status = -1;

    if (!is_cpor(ctx) || !c_i || !c_o)
        return -1;

    if ((c_o->cpor = malloc(sizeof(pdp_cpor_challenge_t))) == NULL)
        goto cleanup;
    memset(c_o->cpor, 0, sizeof(pdp_cpor_challenge_t));
    
    c_o->cpor->I_size = c_i->cpor->I_size;
    if ((c_o->cpor->I = malloc(c_o->cpor->I_size)) == NULL) goto cleanup;
    memset(c_o->cpor->I, 0, c_o->cpor->I_size);
    
    c_o->cpor->nu_size = c_i->cpor->nu_size;
    if ((c_o->cpor->nu = malloc(c_o->cpor->nu_size)) == NULL) goto cleanup;
    memset(c_o->cpor->nu, 0, c_o->cpor->nu_size);
    
    c_o->cpor->ell = c_i->cpor->ell;
    for(i = 0; i < c_o->cpor->ell; i++) {
        c_o->cpor->I[i] = c_i->cpor->I[i];
        c_o->cpor->nu[i] = BN_dup(c_i->cpor->nu[i]);
        if (c_o->cpor->nu[i] == NULL) goto cleanup;
    }
    status = 0;

cleanup:
    if (status) cpor_challenge_free(ctx, c_o->cpor); 
    return status;
}


/**
 * @brief Initializes the default context for cpor.
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int cpor_ctx_init(pdp_ctx_t *ctx)
{
    pdp_cpor_ctx_t *p = NULL;
    if (!ctx || (ctx->algo != PDP_CPOR))
        return -1;
    // need to free in cpor_ctx_free
    if ((p = malloc(sizeof(pdp_cpor_ctx_t))) == NULL)
        return -1;
    memset(p, 0, sizeof(pdp_cpor_ctx_t));
    ctx->cpor_param = p;

    return 0;
}


/**
 * @brief Initializes the default context for cpor.
 * 
 * Expects ctx->cpor to point to a fully-allocated
 * pdp_cpor_ctx_t structure.
 *
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int cpor_ctx_create(pdp_ctx_t *ctx)
{
    pdp_cpor_ctx_t *p = NULL;
    unsigned int tmp;

    if (!is_cpor(ctx))
        return -1;    
    p = ctx->cpor_param;

    // block size
    tmp = p->block_size;
    if (!tmp) {
        tmp = CPOR_DEFAULT_BLOCK_SIZE_BYTES;
    } else {
        // 'clean' any non-default value specified
        tmp = next_pow_2(tmp);
        tmp = (tmp <= 128) ? 256 : tmp;
    }
    p->block_size = tmp;

    if (!p->lambda) {
        p->lambda = CPOR_DEFAULT_LAMBDA;
    }

    if (!p->Zp_bits) {
        p->Zp_bits = p->lambda;
    }

    // The message sector size 1 byte smaller than the size of Zp so that it 
    // is guaranteed to be an element of the group Zp
    if (!p->sector_size) {
        p->sector_size = ((p->Zp_bits/8) - 1);
    } else {
        if (p->sector_size > p->Zp_bits/8) {
            PDP_ERR("Sectors are too large to be elements of Zp");
            return -1;
        }
    }

    // Number of sectors per block
    tmp = p->block_size / p->sector_size;
    tmp += (p->block_size % p->sector_size) ? 1 : 0;
    if (!p->num_sectors) {
        p->num_sectors = tmp;
    } else {
        if (tmp != p->num_sectors) {
            PDP_ERR("Number of sectors doesn't make sense.");
            return -1;
        }
    }

    // From the paper: a "conservative choice" for l is lamda
    if (!p->num_challenge_blocks) {
        p->num_challenge_blocks = p->lambda;
    }

    // key sizes
    if (!p->prf_key_size) {
        p->prf_key_size = CPOR_DEFAULT_PRF_KEY_BYTES;
    }
    if (!p->enc_key_size) {
        p->enc_key_size = CPOR_DEFAULT_ENC_KEY_BYTES;
    } else {
        if ((p->enc_key_size != 16) && (p->enc_key_size != 24) &&
            (p->enc_key_size != 32)) {
            PDP_ERR("Invalid encryption key size.");
            return -1;
        }       
    }
    if (!p->mac_key_size) {
        p->mac_key_size = CPOR_DEFAULT_MAC_KEY_BYTES;
    }

    // set number of blocks, if possible to do so early
    p->num_blocks = 0;
    if (ctx->file_st_size) {
        p->num_blocks = (ctx->file_st_size / p->block_size);
        p->num_blocks = (p->num_blocks < 1) ? 1 : p->num_blocks;
    }

    // set default function pointers
    if (ctx->opts & PDP_OPT_USE_S3) {
        ctx->ops->get_tag = cpor_get_tag_s3;
        ctx->ops->get_block = cpor_get_block_s3;
    } else {
        ctx->ops->get_tag = cpor_get_tag_file;
        ctx->ops->get_block = cpor_get_block_file;
    }
    ctx->ops->sanitize = cpor_chal_sanitize;
    return 0;
}


/**
 * @brief Free the context for cpor.
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int cpor_ctx_free(pdp_ctx_t *ctx)
{
    if (!ctx) return -1;
    sfree(ctx->cpor_param, sizeof(pdp_cpor_ctx_t));
    return 0;
}


/**
 * @brief A special-purpose support function.
 *
 * Frees a single tag held in the A-PDP tagdata structure.
 *
 * @param[in] tag  a single A-PDP tag
 **/
void cpor_tag_free(pdp_cpor_tag_t *tag)
{
    if (!tag) return;
    if (tag->sigma) BN_clear_free(tag->sigma);
    tag->sigma = NULL;
    sfree(tag, sizeof(pdp_cpor_tag_t));
    return;
}


/**
 * @brief Allocates space for a single tag.
 **/
pdp_cpor_tag_t *cpor_tag_new(void)
{
    pdp_cpor_tag_t *tag = NULL;
    
    if ((tag = malloc(sizeof(pdp_cpor_tag_t))) == NULL) return NULL;
    memset(tag, 0, sizeof(pdp_cpor_tag_t));
    if ((tag->sigma = BN_new()) == NULL) goto cleanup;
    tag->index = 0;
    return tag;
    
cleanup:
    cpor_tag_free(tag);
    return NULL;
}   


/**
 * @brief Tags a block of data.
 *
 * The tag is generated relative to the tag data, td, which has two secrets:
 *  k_prf (the key to the PRF) and alpha (a randomly chosen value to
 *  blind the message). These should remain associated somehow, for
 *  use during verification.
 * 
 * @param[in]     ctx         context
 * @param[in]     key         key
 * @param[in]     td          tag data for generating t
 * @param[in]     block       buffer holding block data
 * @param[in]     block_len   len of block
 * @param[in]     index       block index
 * @param[out]    t           *t is a pointer to a filled-out tag
 * @return 0 on success, non-zero on error
 **/
static int cpor_tag_block(pdp_ctx_t *ctx, pdp_cpor_key_t *key, 
                          pdp_cpor_tagdata_t* td,
                          unsigned char *block, size_t block_len,
                          int index, pdp_cpor_tag_t **t)
{
    pdp_cpor_tag_t *tag = NULL;
    pdp_cpor_ctx_t *p = NULL;
    BN_CTX *bctx = NULL;
    BIGNUM *prf_i = NULL;
    BIGNUM *message = NULL;
    BIGNUM *product = NULL;
    BIGNUM *sum = NULL;
    unsigned char *sector = NULL;
    unsigned int sector_size = 0;
    int j, status = -1;

    if (!is_cpor(ctx) || !key || !block || !block_len || !td || !t)
        return -1;
    p = ctx->cpor_param;
    
    // Verify keys
    if (!key->Zp || !td->alpha || !td->k_prf)
        return -1;

    // Allocate memory
    if ((tag = cpor_tag_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    if ((message = BN_new()) == NULL) goto cleanup;
    if ((product = BN_new()) == NULL) goto cleanup;
    if ((sum = BN_new()) == NULL) goto cleanup;

    // Compute PRF_k(i)
    prf_i = gen_prf_k(td->k_prf, p->prf_key_size, index);
    if (prf_i == NULL) goto cleanup;
    
    // Sum all alpha * sector products
    BN_clear(sum);
    for (j=0; j< p->num_sectors; j++) {
        sector = block + (j * p->sector_size);
        
        sector_size = block_len - (j * p->sector_size);
        if (sector_size > p->sector_size) {
            sector_size = p->sector_size;
        }
        
        // Convert the sector into a BIGNUM message
        if (!BN_bin2bn(sector, sector_size, message)) goto cleanup;

        // Check to see if the message is still an element of Zp
        if (BN_ucmp(message, key->Zp) == 1) goto cleanup;

        // Multiply alpha and m
        if (!BN_mod_mul(product, td->alpha[j], message, key->Zp, bctx))
            goto cleanup;

        // Sum the alpha_j-sector_ij products together
        if (!BN_mod_add(sum, product, sum, key->Zp, bctx)) goto cleanup;
    }

    // Add alpha*m and prf_k(i) mod p to make it an element of Z_p
    if (!BN_mod_add(tag->sigma, prf_i, sum, key->Zp, bctx)) goto cleanup;

    tag->index = index;
    *t = tag;
    status = 0;

cleanup:
    if (prf_i) BN_clear_free(prf_i);
    if (message) BN_clear_free(message);
    if (product) BN_clear_free(product); 
    if (sum) BN_clear_free(sum); 
    if (bctx) BN_CTX_free(bctx);
    if (status) cpor_tag_free(tag);
    return status;
}


/**
 * @brief Describes a single tagging job.
 *
 * If num_threads is 1, this performs all the tagging, serially.
 **/
static void *cpor_tag_thread(void *args)
{
    struct pdp_job_arg *arg = (struct pdp_job_arg *) args;
    pdp_ctx_t *ctx;
    pdp_cpor_ctx_t *p;
    pdp_cpor_tag_t *tag = NULL;
    int *ret = NULL;
    unsigned char *buf = NULL;
    size_t buf_len = 0;
    unsigned int i, block;

    if (!arg || !arg->ctx || !arg->key || !arg->file ||
                !arg->td || !arg->numblocks)
        goto cleanup;
    ctx = arg->ctx; 
    p = ctx->cpor_param;

    // allocate memory for return value (will be freed by producer thread)
    if ((ret = malloc(sizeof(int))) == NULL)
        goto cleanup;
    *ret = -1;

    // allocate temp memory for reading a block and generating a tag / digest
    buf_len = sizeof(unsigned char) * p->block_size;
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;

    // For N threads, read and tag every N-th block
    block = arg->index;
    for (i = 0; i < arg->numblocks; i++) {
        memset(buf, 0, buf_len);
        tag = NULL;

        // read file data
        fseek(arg->file, block * p->block_size, SEEK_SET);
        fread(buf, 1, buf_len, arg->file);
        if (ferror(arg->file)) goto cleanup;

        // tag the block
        if (cpor_tag_block(ctx, arg->key, arg->td, 
                           buf, buf_len, block, &tag) != 0)
            goto cleanup;       

        // store the computed digest to correct location in tags output buffer
        arg->td->tags[block] = tag;

        block += ctx->num_threads;
    }
    *ret = 0;

cleanup:
    if (!ret || (ret && *ret))
        PDP_ERR("some thread was unable to create a tag.");
    sfree(buf, buf_len);
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
static int cpor_gen_tags_all(pdp_ctx_t *ctx, pdp_cpor_key_t *k,
                             pdp_cpor_tagdata_t *t)
{
    pdp_cpor_ctx_t *p = ctx->cpor_param;
    struct pdp_job_arg arg;
    int *ret = NULL;
    int status = -1;

    // populate the arguments to perform the job
    arg.file = fopen(ctx->filepath, "r");
    if (!arg.file) goto cleanup;
    arg.ctx = ctx;
    arg.key = k;
    arg.index = 0;
    arg.numblocks = p->num_blocks;
    arg.td = t;

    // perform the job
    ret = (int *) cpor_tag_thread((void *) &arg);
    
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
static int cpor_gen_tags_all_threaded(pdp_ctx_t *ctx, pdp_cpor_key_t *k,
                                      pdp_cpor_tagdata_t *t)
{
#ifndef _THREAD_SUPPORT
    PDP_UNSUPPORTED("pthread");
    return -1;
#else
    pdp_cpor_ctx_t *p = ctx->cpor_param;
    pthread_t *threads = NULL;
    struct pdp_job_arg *args = NULL;
    int *ret = NULL;
    int i, err;

    if ((threads = malloc(sizeof(pthread_t) * ctx->num_threads)) == NULL)
        goto cleanup;
    memset(threads, 0, sizeof(pthread_t) * ctx->num_threads);
    if ((args = malloc(sizeof(struct pdp_job_arg) * ctx->num_threads)) == NULL)
        goto cleanup;

    // spawn each thread
    for (i=0; i < ctx->num_threads; i++) {
        // open a unique fd for each thread
        args[i].file = fopen(ctx->filepath, "r");
        if (!args[i].file) goto cleanup;
        args[i].ctx = ctx;
        args[i].key = k;
        args[i].index = i;
        args[i].numblocks = p->num_blocks/ctx->num_threads;
        args[i].td = t;

        // if there is not an equal number of blocks to tag, add the 
        // extra blocks to the corresponding thread
        if (i < p->num_blocks % ctx->num_threads)
            args[i].numblocks++;
        
        // If the thread has blocks to tag, then spawn it
        if (args[i].numblocks > 0) {
            err = pthread_create(&threads[i], NULL, cpor_tag_thread,
                                 (void *) &args[i]);
            if (err) goto cleanup;
        }
    }
    // check each thread for error
    for (i=0; i < ctx->num_threads; i++) {
        if (!threads[i])
            continue;
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
    // @todo threads are not cancellation-safe, so this should be re-thought
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
 * @param[in,out]  ctx  The context for the PDP routine.
 * @param[in]      k    The secret key data.
 * @param[out]     t    The tag data that is generated.
 * @return 0 on success, non-zero on error
 **/
int cpor_tags_gen(pdp_ctx_t *ctx, pdp_cpor_key_t *k, pdp_cpor_tagdata_t *t)
{
    pdp_cpor_ctx_t *p = NULL;
    unsigned int num_blocks = 0;
    int i, err, status = -1;

    if (!is_cpor(ctx) || !k)
        return -1;
    p = ctx->cpor_param;

    // our caller filled out some ctx at this point, so
    // we can calculate some relevant params
    num_blocks = (ctx->file_st_size / p->block_size);
    if (ctx->file_st_size % p->block_size)
        num_blocks++;
    p->num_blocks = num_blocks;

    // Generate per-file secrets
    t->alpha_size = sizeof(BIGNUM *) * p->num_sectors;
    if ((t->alpha = malloc(t->alpha_size)) == NULL) goto cleanup;
    memset(t->alpha, 0, sizeof(t->alpha_size));
    for(i = 0; i < p->num_sectors; i++){
        t->alpha[i] = BN_new();
        if (!BN_rand_range(t->alpha[i], k->Zp)) goto cleanup;
    }
    // Generate a random PRF key, k_prf
    if ((t->k_prf = malloc(p->prf_key_size)) == NULL) goto cleanup;
    memset(t->k_prf, 0, p->prf_key_size);
    if (!RAND_bytes(t->k_prf, p->prf_key_size)) goto cleanup;

    // Allocate buffer to hold tags
    t->tags_size = p->num_blocks * sizeof(pdp_cpor_tag_t);
    t->tags_num = p->num_blocks;
    if ((t->tags = malloc(t->tags_size)) == NULL) goto cleanup;
    memset(t->tags, 0, t->tags_size);

    // now we can start tagging    
    if ((ctx->opts & PDP_OPT_THREADED) && (ctx->num_threads > 1)) {
        // if are using threads
        err = cpor_gen_tags_all_threaded(ctx, k, t);
    } else {
        // no threads
        err = cpor_gen_tags_all(ctx, k, t);
    }
    if (err) goto cleanup;
    status = 0;

cleanup:
    if (status) cpor_tags_free(ctx, t);
    return status;
}


/**
 * @brief Frees a tags structure
 * @return 0 on success, non-zero on error
 **/
int cpor_tags_free(const pdp_ctx_t *ctx, pdp_cpor_tagdata_t *t)
{
    pdp_cpor_ctx_t *p = NULL;
    int i;

    if (!ctx || !t) return -1;
    p = ctx->cpor_param;

    sfree(t->k_prf, p->prf_key_size);
    for (i = 0; i < p->num_sectors; i++) {
        if (t->alpha && t->alpha[i]) BN_clear_free(t->alpha[i]);
    }
    sfree(t->alpha, t->alpha_size);
    for (i = 0; i < t->tags_num; i++) {
        if (t->tags && t->tags[i]) cpor_tag_free(t->tags[i]);
    }
    sfree(t->tags, t->tags_size);
    return 0;
}


/**
 * @brief Stores data and tags.
 * @return 0 on success, non-zero on error
 **/
int cpor_store(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
               const pdp_cpor_tagdata_t* tag)
{
    if (!is_cpor(ctx))
        return -1;

    if (cpor_fkey_store(ctx, key, tag))
        return -1;
    if (ctx->opts & PDP_OPT_USE_S3) {
        // we need to write ctx->filepath and the tagdata to S3
        return cpor_write_data_to_s3(ctx, tag);
    } else {
        // the file we tagged is already stored in ctx->filepath
        // so we only need to write tag data to ctx->ofilepath
        return cpor_write_tags_to_file(ctx, tag);
    }

    return -1;
}


/**
 * @brief Generates a vector of block indices, as a challenge.
 *
 * Create a random challenge to send to the prover.
 *
 * @return 0 on success, non-zero on error
 **/
int cpor_challenge_gen(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
                       pdp_cpor_challenge_t *chal)
{
    pdp_cpor_ctx_t *p = NULL;
    int i, status = -1;

    if (!is_cpor(ctx) || !key || !chal)
        return -1;
    p = ctx->cpor_param;

    if (!key->Zp || !p->num_challenge_blocks || !p->num_blocks)
        return -1;

    // We will challenge ell blocks
    chal->ell = (p->num_blocks > p->num_challenge_blocks) ? 
                    p->num_challenge_blocks : p->num_blocks;

    // Allocate challenge
    chal->I_size = sizeof(unsigned int) * chal->ell;
    if ((chal->I = malloc(chal->I_size)) == NULL) goto cleanup;
    memset(chal->I, 0, chal->I_size);

    chal->nu_size = sizeof(BIGNUM *) * chal->ell;
    if ((chal->nu = malloc(chal->nu_size)) == NULL) goto cleanup;   
    memset(chal->nu, 0, chal->nu_size);

    // Generate challenges
    if (sample_sans_replacement(chal->ell, p->num_blocks, chal->I))
        goto cleanup;

    // Randomly choose ell elements of Zp (with replacement)
    for(i = 0; i < chal->ell; i++) {
        if ((chal->nu[i] = BN_new()) == NULL) goto cleanup;
        if (!BN_rand_range(chal->nu[i], key->Zp)) goto cleanup;
    }
    status = 0;

cleanup:
    if (status) cpor_challenge_free(ctx, chal);
    return status;
}



/**
 * @brief Frees the internal data for a challenge structure.
 *
 * @return 0 on success, non-zero on error
 **/
int cpor_challenge_free(const pdp_ctx_t *ctx, pdp_cpor_challenge_t *c)
{
    int i;
    
    if (!is_cpor(ctx) || !c)
        return -1;

    for(i = 0; i < c->ell; i++) {
        if (c->nu && c->nu[i]) BN_clear_free(c->nu[i]);
    }
    sfree(c->I, c->I_size);
    sfree(c->nu, c->nu_size);
    memset(c, 0, sizeof(pdp_cpor_challenge_t));
    return 0;
}


/**
 * @brief A function that incrementally builds a proof.
 * 
 * Builds an aggregate signature, block-by-block and tag-by-tag.
 * When tag and block are NULL, a final proof is prepared
 * and placed it in the structure 'proof'.
 *
 * @param[in]     ctx         Context
 * @param[in]     key         The prover's keys
 * @param[in,out] proof       Allocated proof structure, holds proof state
 * @param[in]     chal        Challenge to which the proof is a response
 * @param[in]     tag         Tag i
 * @param[in]     block       Buffer holding block data for tag i
 * @param[in]     block_size  Size of block
 * @param[in]     i           Tag identity
 * @return 0 on success, non-zero on error
 **/
static int cpor_proof_update(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
            pdp_cpor_proof_t *proof, const pdp_cpor_challenge_t *chal, 
            pdp_cpor_tag_t *tag, unsigned char *block, 
            unsigned int block_size, unsigned int i)
{
    pdp_cpor_ctx_t *p = NULL;
    BN_CTX *bctx = NULL;
    BIGNUM *message = NULL;
    BIGNUM *product = NULL;
    unsigned int sector_size = 0;
    unsigned char *sector = NULL;
    int j, status = -1;
    
    if (!is_cpor(ctx) || !key || !proof || !chal)
        return -1;
    p = ctx->cpor_param;

    // There is no finalize logic, here
    if (!block && !tag) {
        return 0;
    } else if (!block || !block_size || !tag || !key->Zp) {
        goto cleanup;
    }

    // Allocate
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    if ((message = BN_new()) == NULL) goto cleanup;
    if ((product = BN_new()) == NULL) goto cleanup;

    for (j = 0; j < p->num_sectors; j++) {
        sector = block + (j * p->sector_size);
        
        sector_size = block_size - (j * p->sector_size);
        if (sector_size > p->sector_size) {
            sector_size = p->sector_size;
        }

        // Convert the sector into a BIGNUM
        if (!BN_bin2bn(sector, sector_size, message)) goto cleanup;

        // Check to see if the message is still an element of Zp
        if (BN_ucmp(message, key->Zp) == 1) goto cleanup;

        // multiply nu_i and m_ij
        if (!BN_mod_mul(product, chal->nu[i], message, key->Zp, bctx))
            goto cleanup;

        // Sum the nu_i-m_ij products together
        if (!BN_mod_add(proof->mu[j], proof->mu[j], product, key->Zp, bctx))
            goto cleanup;
    }
    // Calculate sigma: multiply nu_i (challenge) and sigma_i (tag)
    if (!BN_mod_mul(product, chal->nu[i], tag->sigma, key->Zp, bctx))
        goto cleanup;

    // Sum the nu_i-sigma_i products together
    if (!BN_mod_add(proof->sigma, proof->sigma, product, key->Zp, bctx))
        goto cleanup;
    
    status = 0;

cleanup:
    if (message) BN_clear_free(message);
    if (product) BN_clear_free(product);    
    if (bctx) BN_CTX_free(bctx);
    if (status) cpor_proof_free(ctx, proof);
    return status;
}


/**
 * @brief Generates a proof.
 * @return 0 on success, non-zero on error
 **/
int cpor_proof_gen(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
                   const pdp_cpor_challenge_t *chal, pdp_cpor_proof_t *proof)
{
    pdp_cpor_ctx_t *p = NULL;
    unsigned char *block = NULL;
    pdp_cpor_tag_t *tag = NULL;
    unsigned int block_len = 0, tag_len = 0;
    int i, err, status = -1;

    if (!is_cpor(ctx) || !key || !chal || !proof)
        return -1;
    p = ctx->cpor_param;

    // Allocate a block and the proof structure
    if ((block = malloc(p->block_size)) == NULL) goto cleanup;
    if ((proof->sigma = BN_new()) == NULL) goto cleanup;
    proof->mu_size = sizeof(BIGNUM *) * p->num_sectors;
    if ((proof->mu = malloc(proof->mu_size)) == NULL) goto cleanup;
    for (i = 0; i < p->num_sectors; i++) {
        if ((proof->mu[i] = BN_new()) == NULL) goto cleanup;
    }

    for(i = 0; i < chal->ell; i++) {
        memset(block, 0, p->block_size);
        block_len = p->block_size;

        err = ctx->ops->get_tag(ctx, chal->I[i], &tag, &tag_len); 
        if (err) goto cleanup;
        err = ctx->ops->get_block(ctx, chal->I[i], block, &block_len);
        if (err) goto cleanup;
        err = cpor_proof_update(ctx, key, proof, chal, tag, 
                                block, p->block_size, i);
        if (err) goto cleanup;
        cpor_tag_free(tag);
        tag = NULL;
    }
    // 'finalize' the proof
    err = cpor_proof_update(ctx, key, proof, chal, NULL, NULL, 0, 0);
    if (err) goto cleanup;

    status = 0;
    
cleanup:
    sfree(block, p->block_size);
    if (tag) cpor_tag_free(tag);

    // 'finish' access to stateful methods
    ctx->ops->get_tag(ctx, 0, NULL, NULL);
    ctx->ops->get_block(ctx, 0, NULL, NULL);
    return status;
}


/**
 * @brief Verifies that a proof is a correct response to a challenge.
 * @return 0 on success, 1 on failure, -1 on error
 **/
int cpor_proof_verify(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key,
                      const pdp_cpor_challenge_t *chal,
                      const pdp_cpor_proof_t *proof)
{
    pdp_cpor_ctx_t *p = NULL;
    pdp_cpor_tagdata_t *td = NULL;
    BN_CTX *bctx = NULL;
    BIGNUM *product = NULL;
    BIGNUM *sigma = NULL;
    BIGNUM *prf_i = NULL;
    int i, j, result = -1;

    if (!is_cpor(ctx) || !key || !chal || !proof)
        return -1;
    p = ctx->cpor_param;

    // Get per-file secrets which we used to tag, store them in td
    if ((cpor_fkey_open(ctx, key, &td)) != 0) goto cleanup;

    // Check secrets used to verify proof
    if (!key->Zp || !td || !td->alpha_size || !td->alpha || !td->k_prf)
        return -1;

    // Allocate
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    if ((product = BN_new()) == NULL) goto cleanup;
    if ((sigma = BN_new()) == NULL) goto cleanup;

    // Compute the summation of all the products (nu_i * PRF_k(i))
    for(i = 0; i < chal->ell; i++) {

        // compute prf_k(i)
        prf_i = gen_prf_k(td->k_prf, p->prf_key_size, chal->I[i]);
        if (prf_i == NULL) goto cleanup;

        // Multiply prf_i by nu_i
        if (!BN_mod_mul(product, chal->nu[i], prf_i, key->Zp, bctx))
            goto cleanup;
        
        // Sum the results
        if (!BN_mod_add(sigma, sigma, product, key->Zp, bctx))
            goto cleanup;
        
        if (prf_i) BN_clear_free(prf_i);
        prf_i = NULL;
    }

    // Compute the summation of all the products (alpha_j * mu_j)
    for(j = 0; j < p->num_sectors; j++) {
        
        // Multiply alpha_j by mu_j
        if (!BN_mod_mul(product, td->alpha[j], proof->mu[j], key->Zp, bctx))
            goto cleanup;   
        
        // Sum the results
        if (!BN_mod_add(sigma, sigma, product, key->Zp, bctx))
            goto cleanup;
    }

    result = (BN_ucmp(sigma, proof->sigma) == 0) ? 0 : 1;

cleanup:
    if (prf_i) BN_clear_free(prf_i);
    if (sigma) BN_clear_free(sigma);
    if (product) BN_clear_free(product);
    if (bctx) BN_CTX_free(bctx);
    if (td) cpor_tags_free(ctx, td);
    return result;
}


/**
 * @brief Frees the internal structures allocated within a proof.
 * @return 0 on success, non-zero on error
 **/
int cpor_proof_free(const pdp_ctx_t *ctx, pdp_cpor_proof_t *proof)
{
    int i;

    if (!is_cpor(ctx) || !proof) return -1;

    if (proof->sigma) BN_clear_free(proof->sigma);
    for (i = 0; i < ctx->cpor_param->num_sectors; i++) {
        if (proof->mu && proof->mu[i]) BN_clear_free(proof->mu[i]);
    }
    sfree(proof->mu, proof->mu_size);
    memset(proof, 0, sizeof(pdp_cpor_proof_t));
    return 0;
}

/** @} */
