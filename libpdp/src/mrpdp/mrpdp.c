/**
 * @file
 * Implementation of the MR-PDP module for libpdp.
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
#include <openssl/rsa.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#ifdef _THREAD_SUPPORT
#include <pthread.h>
#endif
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <pdp/mrpdp.h>
#include "mrpdp_storage.h"
#include "mrpdp_misc.h"
#include "pdp_misc.h"


/// a struct that holds all the arguments for a worker thread
struct pdp_job_arg {
    pdp_ctx_t *ctx;             ///< context
    pdp_mrpdp_key_t *key;        ///< key
    FILE *file;                 ///< file to tag, a unique fd for this job
    int index;                  ///< used to determine which blocks to tag
    int numblocks;              ///< number of blocks this job needs to tag
    pdp_mrpdp_tag_t **tags;      ///< memory used to store the result
};


/**
 * @brief Implements sanitize_stub()
 * @return 0 on success, non-zero on error
 **/
static int mrpdp_chal_sanitize(const pdp_ctx_t* ctx, 
                        const pdp_challenge_t* c_i, pdp_challenge_t* c_o)
{
    pdp_mrpdp_ctx_t *p = NULL;
    if (!is_mrpdp(ctx) || !c_i || !c_o)
        return -1;
    p = ctx->mrpdp_param;

    if ((c_o->mrpdp = malloc(sizeof(pdp_mrpdp_challenge_t))) == NULL)
        goto cleanup;
    memset(c_o->mrpdp, 0, sizeof(pdp_mrpdp_challenge_t));
    
    c_o->mrpdp->s = NULL;   // we do not share the secret s
    c_o->mrpdp->c = c_i->mrpdp->c;
    if ((c_o->mrpdp->g_s = BN_dup(c_i->mrpdp->g_s)) == NULL) goto cleanup;
    if ((c_o->mrpdp->k1 = calloc(1, p->prp_key_size)) == NULL) goto cleanup;
    memcpy(c_o->mrpdp->k1, c_i->mrpdp->k1, p->prp_key_size);
    if ((c_o->mrpdp->k2 = calloc(1, p->prf_key_size)) == NULL) goto cleanup;
    memcpy(c_o->mrpdp->k2, c_i->mrpdp->k2, p->prf_key_size);
    return 0;

cleanup:
    mrpdp_challenge_free(ctx, c_o->mrpdp); 
    return -1;
}



/**
 * @brief Initializes the default context for mrpdp.
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int mrpdp_ctx_init(pdp_ctx_t *ctx)
{
    pdp_mrpdp_ctx_t *p = NULL;
    if (!ctx || (ctx->algo != PDP_MRPDP))
        return -1;
    // need to free in mrpdp_ctx_free
    if ((p = malloc(sizeof(pdp_mrpdp_ctx_t))) == NULL)
        return -1;
    memset(p, 0, sizeof(pdp_mrpdp_ctx_t));
    ctx->mrpdp_param = p;

    OpenSSL_add_all_algorithms();
    return 0;
}


/**
 * @brief Initializes the default context for mrpdp.
 * 
 * Expects ctx->mrpdp to point to a fully-allocated pdp_mrpdp_ctx_t structure.
 *
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int mrpdp_ctx_create(pdp_ctx_t *ctx)
{
    pdp_mrpdp_ctx_t *p = NULL;
    unsigned int tmp;

    if (!is_mrpdp(ctx))
        return -1;    
    p = ctx->mrpdp_param;

    // block size
    tmp = p->block_size;
    if (!tmp) {
        tmp = MRPDP_DEFAULT_BLOCK_SIZE_BYTES;
    } else {
        // 'clean' any non-default value specified
        tmp = next_pow_2(tmp);
        tmp = (tmp <= 128) ? 256 : tmp;
    }
    p->block_size = tmp;

    // number of blocks to challenge
    if (!p->num_challenge_blocks) {
        p->num_challenge_blocks = MRPDP_MAGIC_CHALLENGE_NUM;
    }

    // key sizes
    if (!p->prf_key_size) {
        p->prf_key_size = MRPDP_DEFAULT_PRF_KEY_SIZE;
    }
    if (!p->prp_key_size) {
        p->prp_key_size = MRPDP_DEFAULT_PRP_KEY_SIZE;
    }
    if (!p->rsa_key_size) {
        p->rsa_key_size = MRPDP_DEFAULT_RSA_KEY_SIZE;
    }
    if (!p->prf_w_size) { 
        p->prf_w_size = EVP_MAX_MD_SIZE;
    }
    if (!p->prf_f_size) {
        p->prf_f_size = SHA_DIGEST_LENGTH;
    }

    // set number of blocks, if possible early
    p->num_blocks = 0;
    if (ctx->file_st_size) {
        p->num_blocks = (ctx->file_st_size / p->block_size);
        p->num_blocks = (p->num_blocks < 1) ? 1 : p->num_blocks;
    }

    // set default function pointers
    if (ctx->opts & PDP_OPT_USE_S3) {
        ctx->ops->get_tag = mrpdp_get_tag_s3;
        ctx->ops->get_block = mrpdp_get_block_s3;
    } else {
        ctx->ops->get_tag = mrpdp_get_tag_file;
        ctx->ops->get_block = mrpdp_get_block_file;
    }    
    ctx->ops->sanitize = mrpdp_chal_sanitize;
    return 0;
}


/**
 * @brief Free the context for mrpdp.
 * @param[in,out] ctx   ptr to context
 * @return 0 on success, non-zero on error
 **/
int mrpdp_ctx_free(pdp_ctx_t *ctx)
{
    if (!ctx) return -1;
    sfree(ctx->mrpdp_param, sizeof(pdp_mrpdp_ctx_t));
    return 0;
}


/**
 * @brief A special-purpose support function.
 *
 * Frees a single tag held in the A-PDP tagdata structure.
 *
 * @param[in] tag  a single A-PDP tag
 **/
void mrpdp_tag_free(pdp_mrpdp_tag_t *tag)
{
    if (!tag) return;
    if (tag->Tim) BN_clear_free(tag->Tim);
    if (tag->index_prf_size > 0) sfree(tag->index_prf, tag->index_prf_size);
    sfree(tag, sizeof(pdp_mrpdp_tag_t));
}


/**
 * @brief Allocates space for a single tag.
 **/
pdp_mrpdp_tag_t *mrpdp_tag_new(void)
{
    pdp_mrpdp_tag_t *tag = NULL;
    
    if ((tag = malloc(sizeof(pdp_mrpdp_tag_t))) == NULL) return NULL;
    memset(tag, 0, sizeof(pdp_mrpdp_tag_t));
    if ((tag->Tim = BN_new()) == NULL) goto cleanup;
    return tag;
    
cleanup:
    mrpdp_tag_free(tag);
    return NULL;
}


/**
 * @brief Tags a block of data.
 * @param[in]     ctx         context
 * @param[in]     key         key
 * @param[in]     block       buffer holding block data
 * @param[in]     block_len   len of block
 * @param[in]     index       block index
 * @param[out]    t           *t is a pointer to a filled-out tag
 * @return 0 on success, non-zero on error
 **/
static int mrpdp_tag_block(pdp_ctx_t *ctx, pdp_mrpdp_key_t *key,
                          unsigned char *block, size_t block_len,
                          int index, pdp_mrpdp_tag_t **t)
{
    pdp_mrpdp_tag_t *tag = NULL;
    pdp_mrpdp_ctx_t *p = NULL;
    BN_CTX *bctx = NULL;
    BIGNUM *phi = NULL;
    BIGNUM *fdh_hash = NULL;
    BIGNUM *message  = NULL;
    BIGNUM *r0 = NULL;
    BIGNUM *r1 = NULL;
    int status = -1;

    if (!is_mrpdp(ctx) || !key || !block || !t)
        return -1;
    p = ctx->mrpdp_param;
    
    // Verify keys
    if (!key->rsa || !key->rsa->d || !key->rsa->n ||
                     !key->rsa->p || !key->rsa->q || !key->g)
        return -1;
    
    // Allocate memory
    if ((tag = mrpdp_tag_new()) == NULL) goto cleanup;
    if ((phi = BN_new()) == NULL) goto cleanup;
    if ((r0 = BN_new()) == NULL) goto cleanup;
    if ((r1 = BN_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;

    // Set the index
    tag->index = index;
    
    // Perform the PRF Wi = w_v(i)
    tag->index_prf = gen_prf_f(key->v, p->prf_key_size, tag->index, 
                               &(tag->index_prf_size));
    if (!tag->index_prf) goto cleanup;
    
    // Peform the full-domain hash function h(Wi)
    fdh_hash = gen_fdh(key->rsa, tag->index_prf, tag->index_prf_size);
    if (!fdh_hash) goto cleanup;
    
    // Turn the data block into a BIGNUM
    message = BN_bin2bn(block, block_len, NULL);
    if (!message) goto cleanup;
    
    // Calculate phi
    if (!BN_sub(r0, key->rsa->p, BN_value_one())) goto cleanup; // p-1
    if (!BN_sub(r1, key->rsa->q, BN_value_one())) goto cleanup; // q-1
    if (!BN_mul(phi, r0, r1, bctx)) goto cleanup;   // phi = (p-1)(q-1)
    
    // Reduce the message modulo phi(N)
    if (!BN_mod(message, message, phi, bctx)) goto cleanup;
    
    // r0 = g^m
    if (!BN_mod_exp(r0, key->g, message, key->rsa->n, bctx)) goto cleanup;
    // r1 = h(W_i) * g^m
    if (!BN_mul(r1, fdh_hash, r0, bctx)) goto cleanup;
    // T_im = (h(W_i) * g^m)^d mod N
    if (!BN_mod_exp(tag->Tim, r1, key->rsa->d, key->rsa->n, bctx))
        goto cleanup;

    *t = tag;
    status = 0;

cleanup:
    if (message) BN_clear_free(message);
    if (phi) BN_clear_free(phi);
    if (r0) BN_clear_free(r0);
    if (r1) BN_clear_free(r1);
    if (bctx) BN_CTX_free(bctx);
    if (fdh_hash) BN_clear_free(fdh_hash);   
    if (status) mrpdp_tag_free(tag);
    return status;
}

/**
 * @brief Creates a file replica. 
 * @param[in]     ctx         context
 * @param[in]     key         key
 * @param[in]     block       buffer holding block data
 * @param[in]     block_len   len of block
 * @param[in]     index       block index
 * @param[out]    t           *t is a pointer to a filled-out tag
 * @return 0 on success, non-zero on error
 **/
/*static int mrpdp_gen_replica(pdp_ctx_t *ctx, pdp_mrpdp_key_t *key,
                          unsigned char *block, size_t block_len,
                          int index, pdp_mrpdp_tag_t **t)*/
static void *mrpdp_gen_replica(void *args, pdp_mrpdp_tagdata_t *retData)
{
    // Add all the verification code
    struct pdp_job_arg *arg = (struct pdp_job_arg *) args;
    pdp_ctx_t *ctx;
    pdp_mrpdp_ctx_t *p;
    unsigned char *concat = NULL;
    int *ret = NULL;
    unsigned char *buf = NULL;
    int blockCounter = 0;
    BIGNUM *bigPRF = NULL;
    BIGNUM *bigbuf = NULL;
    pdp_mrpdp_tag_t *tag = NULL;
    
    if (!arg || !arg->ctx || !arg->key || !arg->file ||
                !arg->tags || !arg->numblocks)
        goto cleanup;
    
    ctx = arg->ctx;
    p = ctx->mrpdp_param;
    
    // Initialize Memory
    if ((bigPRF = BN_new()) == NULL) goto cleanup;
    if ((bigbuf = BN_new()) == NULL) goto cleanup;
    if ((tag = mrpdp_tag_new()) == NULL) goto cleanup;
    concat = malloc(sizeof(int) * 2);
    buf = malloc(p->block_size);
    
    // Psuedocode implementation
    for (int i = 0; i < p->numReplicas; i++) {
        for (int j = 0; j < arg->numblocks; j++) {
            // create a new tag
            tag->index = j;
            // Concatenate i and j to compute random value
            memcpy(concat, &i, sizeof(int));
            memcpy(concat + sizeof(int), &j, sizeof(int));
            
            // Compute a random value prf = fx(i || j)
            tag->index_prf = gen_prf_f(arg->key->v, p->prf_key_size, 
                    *concat, &(tag->index_prf_size));
            if (!tag->index_prf) goto cleanup;
            
            // Compute the replica's block 
            fseek(arg->file, j * p->block_size, SEEK_SET);
            fread(buf, 1, p->block_size, arg->file);
            
            // Turn the data into BIGNUM
            bigbuf = BN_bin2bn(buf, p->block_size, NULL);
            if (!bigbuf) goto cleanup;
            bigPRF = BN_bin2bn(tag->index_prf, p->prf_key_size, NULL);
            if (!bigPRF) goto cleanup;
            
            BN_add(tag->Tim, bigbuf, bigPRF);
            retData->tags[blockCounter] = tag;
            blockCounter++;
        }
    }
    
    cleanup:
    //if (!ret || (ret && *ret))
        //PDP_ERR("some thread was unable to create a tag.");
      //sfree(buf, buf_len);
#ifdef _THREAD_SUPPORT
    if (ctx->num_threads > 1)
        pthread_exit(ret);
#endif
    return ret;
}


/**
 * @brief Describes a single tagging job.
 *
 * If num_threads is 1, this performs all the tagging, serially.
 **/
static void *mrpdp_tag_thread(void *args)
{
    struct pdp_job_arg *arg = (struct pdp_job_arg *) args;
    pdp_ctx_t *ctx;
    pdp_mrpdp_ctx_t *p;
    pdp_mrpdp_tag_t *tag = NULL;
    unsigned char *buf = NULL;
    unsigned int i, block;
    size_t buf_len = 0;
    int *ret = NULL;
    
    if (!arg || !arg->ctx || !arg->key || !arg->file ||
                !arg->tags || !arg->numblocks)
        goto cleanup;

    ctx = arg->ctx; 
    p = ctx->mrpdp_param;
    buf_len = sizeof(unsigned char) * p->block_size;
    
    // allocate memory for return value (will be freed by producer thread)
    if ((ret = malloc(sizeof(int))) == NULL)
        goto cleanup;
    *ret = -1;

    // allocate temp memory for reading a block and generating a tag / digest
    if ((buf = malloc(buf_len)) == NULL)
        goto cleanup;

    // For N threads, read and tag every N-th block
    block = arg->index;
    for (i = 0; i < arg->numblocks; i++) {
        memset(buf, 0, p->block_size);
        tag = NULL;

        // read file data
        fseek(arg->file, block * p->block_size, SEEK_SET);
        fread(buf, 1, p->block_size, arg->file);
        if (ferror(arg->file)) goto cleanup;

        // tag the block
        if (mrpdp_tag_block(ctx, arg->key, buf, buf_len, block, &tag) != 0)
            goto cleanup;       

        // store the computed digest to correct location in tags output buffer
        arg->tags[block] = tag;

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
static int mrpdp_gen_tags_all(pdp_ctx_t *ctx, pdp_mrpdp_key_t *k,
                             pdp_mrpdp_tagdata_t *t)
{
    pdp_mrpdp_ctx_t *p = ctx->mrpdp_param;
    struct pdp_job_arg arg;
    int *ret = NULL;
    int status = -1;
    //unsigned char *replicaData = NULL;
    pdp_mrpdp_tagdata_t replicaStruct;

    // populate the arguments to perform the job
    arg.ctx = ctx;
    arg.key = k;
    arg.index = 0;
    arg.numblocks = p->num_blocks;
    arg.tags = t->tags;
    arg.file = fopen(ctx->filepath, "r");
    if (!arg.file) goto cleanup;

    // perform the job
    ret = (int *) mrpdp_tag_thread((void *) &arg);
    
    if (p->numReplicas > 0) {
        // Number of tags combined for every replica
        replicaStruct.tags_num = p->numReplicas * arg.numblocks;
        // Byte length of tags
        replicaStruct.tags_size = p->numReplicas * arg.numblocks 
                * p->block_size;
        // Allocate space for a pointer for each tag
        replicaStruct.tags = malloc(sizeof(pdp_mrpdp_tag_t *) 
                * replicaStruct.tags_num);
        
        mrpdp_gen_replica((void *) &arg, &replicaStruct);
        mrpdp_store(ctx, &replicaStruct);
    }
    
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
static int mrpdp_gen_tags_all_threaded(pdp_ctx_t *ctx, pdp_mrpdp_key_t *k,
                                      pdp_mrpdp_tagdata_t *t)
{
#ifndef _THREAD_SUPPORT
    PDP_UNSUPPORTED("pthread");
    return -1;
#else
    pdp_mrpdp_ctx_t *p = ctx->mrpdp_param;
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
            err = pthread_create(&threads[i], NULL, mrpdp_tag_thread,
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
        // close its file
        if (args[i].file) {
            fclose(args[i].file);
            args[i].file = NULL;
        }
    }
    // free common thread resources
    sfree(threads, sizeof(pthread_t) * ctx->num_threads);
    sfree(args, sizeof(struct pdp_job_arg) * ctx->num_threads);
    return 0;

cleanup:
    // cancel outstanding threads
    // @TODO threads are not cancellation-safe, so this should be re-thought
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
int mrpdp_tags_gen(pdp_ctx_t *ctx, pdp_mrpdp_key_t *k, pdp_mrpdp_tagdata_t *t)
{
    pdp_mrpdp_ctx_t *p = NULL;
    unsigned int num_blocks = 0;
    int err = 0;
    int status = -1;

    if (!is_mrpdp(ctx) || !k)
        return -1;
    p = ctx->mrpdp_param;

    OpenSSL_add_all_digests();

    // our caller filled out some ctx at this point, so
    // we can calculate some relevant params
    num_blocks = (ctx->file_st_size / p->block_size);
    if (ctx->file_st_size % p->block_size)
        num_blocks++;
    p->num_blocks = num_blocks;

    // allocate space for tags
    t->tags_size = p->num_blocks * sizeof(pdp_mrpdp_tag_t *);
    t->tags_num = p->num_blocks;
    if ((t->tags = malloc(t->tags_size)) == NULL)
        goto cleanup;
    memset(t->tags, 0, t->tags_size);

    // now we can start tagging    
    if ((ctx->opts & PDP_OPT_THREADED) && (ctx->num_threads > 1)) {
        // if are using threads
        err = mrpdp_gen_tags_all_threaded(ctx, k, t);
    } else {
        // no threads
        err = mrpdp_gen_tags_all(ctx, k, t);
    }
    if (err) goto cleanup;
    status = 0;

cleanup:
    EVP_cleanup();
    if (status) sfree(t->tags, t->tags_size);
    return status;
}


/**
 * @brief Frees a tags structure
 * @return 0 on success, non-zero on error
 **/
int mrpdp_tags_free(const pdp_ctx_t *ctx, pdp_mrpdp_tagdata_t *t)
{
    int i;

    if (!t || !t->tags || !t->tags_size || !t->tags_num)
        return -1;
    for (i = 0; i < t->tags_num; i++) {
        mrpdp_tag_free(t->tags[i]);
    }
    sfree(t->tags, t->tags_size);
    return 0;
}


/**
 * @brief Stores data and tags.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_store(const pdp_ctx_t *ctx, const pdp_mrpdp_tagdata_t* tag)
{
    if (!is_mrpdp(ctx))
        return -1;

    if (ctx->opts & PDP_OPT_USE_S3) {
        // we need to write ctx->filepath and the tagdata to S3
        return mrpdp_write_data_to_s3(ctx, tag);
    } else {
        // the file we tagged is already stored in ctx->filepath
        // so we only need to write tag data to ctx->ofilepath
        return mrpdp_write_tags_to_file(ctx, tag);
    }
    return -1;
}


/**
 * @brief Generates a vector of block indices, as a challenge.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_challenge_gen(const pdp_ctx_t *ctx, const pdp_mrpdp_key_t *key, 
                       pdp_mrpdp_challenge_t *chal)
{
    pdp_mrpdp_ctx_t *p = NULL;
    BIGNUM *r0 = NULL;
    BN_CTX *bctx = NULL;
    int err = -1;

    if (!is_mrpdp(ctx) || !key || !chal)
        return -1;
    p = ctx->mrpdp_param;

    if (!key->rsa || !key->rsa->n || !key->g || 
        !p->num_challenge_blocks || !p->num_blocks)
        return -1;

    // Allocate memory
    if ((chal->g_s = BN_new()) == NULL) goto cleanup;   
    if ((chal->s = BN_new()) == NULL) goto cleanup; 
    if ((chal->k1 = calloc(1, p->prp_key_size)) == NULL) goto cleanup;
    if ((chal->k2 = calloc(1, p->prf_key_size)) == NULL) goto cleanup;
    if ((r0 = BN_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;

    // we will challenge c blocks
    chal->c = (p->num_blocks > p->num_challenge_blocks) ? 
                    p->num_challenge_blocks : p->num_blocks;

    // Generate a random secret s of RSA modulus size from Z*N
    do {
        if (!BN_rand_range(chal->s, key->rsa->n)) goto cleanup;
        if (!BN_gcd(r0, chal->s, key->rsa->n, bctx)) goto cleanup;
    } while(!BN_is_one(r0));

    // Generate the secret base g_s = g^s
    if (!BN_mod_exp(chal->g_s, key->g, chal->s, key->rsa->n, bctx))
        goto cleanup;

    // Generate random bytes for symmetric challenge keys
    if (!RAND_bytes(chal->k1, p->prp_key_size)) goto cleanup;
    if (!RAND_bytes(chal->k2, p->prf_key_size)) goto cleanup;

    err = 0;

cleanup:
    if (r0) BN_clear_free(r0);
    if (bctx) BN_CTX_free(bctx);
    if (err) mrpdp_challenge_free(ctx, chal);
    return err;
}



/**
 * @brief Frees the internal data for a challenge structure.
 *
 * @return 0 on success, non-zero on error
 **/
int mrpdp_challenge_free(const pdp_ctx_t *ctx, pdp_mrpdp_challenge_t *c)
{
    if (!is_mrpdp(ctx) || !c)
        return -1;
    if (c->g_s) BN_clear_free(c->g_s);
    if (c->s) BN_clear_free(c->s);
    sfree(c->k1, ctx->mrpdp_param->prp_key_size);
    sfree(c->k2, ctx->mrpdp_param->prf_key_size);
    memset(c, 0, sizeof(pdp_mrpdp_challenge_t));
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
 * @param[in]     j           Tag identity
 * @return 0 on success, non-zero on error
 **/
static int mrpdp_proof_update(const pdp_ctx_t *ctx, const pdp_mrpdp_key_t *key, 
            pdp_mrpdp_proof_t *proof, const pdp_mrpdp_challenge_t *chal, 
            pdp_mrpdp_tag_t *tag, unsigned char *block, 
            unsigned int block_size, unsigned int j)
{
    BIGNUM *coefficient_a = NULL;
    BIGNUM *message = NULL;
    BIGNUM *r0 = NULL;
    BN_CTX *bctx = NULL;
    unsigned char *prf_result = NULL;
    size_t prf_result_size = 0;
    int status = -1;
    
    if (!is_mrpdp(ctx) || !key || !proof || !chal)
        return -1;
    
    // Verify Key
    if (!key->rsa->n) return -1;

    // Allocate memory
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    if ((coefficient_a = BN_new()) == NULL) goto cleanup;
    if ((message = BN_new()) == NULL) goto cleanup;
    if ((r0 = BN_new()) == NULL) goto cleanup;

    // Skip to the 'finalize' logic
    if (!block && !tag) {
        goto finalize;
    } else if (!block || !block_size || !tag) {
        goto cleanup;
    }

    // Tranform the data block into a BIGNUM
    if (!BN_bin2bn(block, block_size, message)) goto cleanup;

    // Use E-PDP
    if (ctx->mrpdp_param->opts & MRPDP_USE_E_PDP) {

        // No coefficients to calculate in E-PDP, so T is just product of tags
        if (BN_is_zero(proof->T)) {
            if (!BN_copy(proof->T, tag->Tim)) goto cleanup;
        } else {
            if (!BN_mul(proof->T, proof->T, tag->Tim, bctx)) goto cleanup;
        }
        // Copy message into r0 for summing
        if (!BN_copy(r0, message)) goto cleanup;
    } else {
        // Compute the coefficient for block tag->index, where a_j = f_k2(j)
        prf_result = gen_prf_f(chal->k2, ctx->mrpdp_param->prf_key_size, 
                               j, &prf_result_size);
        if (!prf_result) goto cleanup;
        
        // Convert prf result to a big number
        if (!BN_bin2bn(prf_result, prf_result_size, coefficient_a))
            goto cleanup;
        
        // Compute T_im ^ coefficient_a */
        if (!BN_mod_exp(r0, tag->Tim, coefficient_a, key->rsa->n, bctx))
            goto cleanup;
        // Update T, where T = T1m^a1 * ... * Tim^aj
        if (BN_is_zero(proof->T)) {
            if (!BN_copy(proof->T, r0)) goto cleanup;
        } else {
            if (!BN_mul(proof->T, proof->T, r0, bctx)) goto cleanup;
        }
        // Compute coefficient_a * message, where message = data block
        if (!BN_mul(r0, coefficient_a, message, bctx)) goto cleanup;
    }

    // Store the sum of (coefficient_a_j * message) in rho_temp.
    // If E-PDP, then there's no coefficient
    if (BN_is_zero(proof->rho_temp)) {
        if (!BN_copy(proof->rho_temp, r0)) goto cleanup;
    } else {
        if (!BN_add(proof->rho_temp, proof->rho_temp, r0)) goto cleanup;
    } 
    // We do not compute g_s^coefficients*messages or 
    // H(g_s^coefficients*messages) until we 'finalize'
    status = 0;
    goto cleanup;

finalize:
    if (!proof->rho_temp || !chal->g_s)
        goto cleanup;
    
    // Compute g_s^ (M1 + M2 + ... + Mc) mod N
    if (!BN_mod_exp(proof->rho_temp, chal->g_s, proof->rho_temp, 
                    key->rsa->n, bctx))
        goto cleanup;
    
    // Compute H(g_s^(M1 + M2 + ... + Mc))
    proof->rho = gen_bn_H(proof->rho_temp, &(proof->rho_size));
    if (!proof->rho) goto cleanup;
    status = 0;
    goto cleanup;

cleanup:
    if (coefficient_a) BN_clear_free(coefficient_a);
    if (message) BN_clear_free(message);
    if (r0) BN_clear_free(r0);
    if (bctx) BN_CTX_free(bctx);
    sfree(prf_result, prf_result_size);
    if (status) mrpdp_proof_free(ctx, proof);
    return status;
}


/**
 * @brief Generates a proof.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_proof_gen(const pdp_ctx_t *ctx, const pdp_mrpdp_key_t *key,
                   const pdp_mrpdp_challenge_t *chal, pdp_mrpdp_proof_t *proof)
{
    unsigned char *block = NULL;
    pdp_mrpdp_tag_t *tag = NULL;
    unsigned int *I = NULL;
    unsigned int i = 0;
    pdp_mrpdp_ctx_t *p = NULL;
    unsigned int block_len = 0, tag_len = 0;
    int err, status = -1;
    
    if (!is_mrpdp(ctx) || !key || !chal || !proof)
        return -1;
    p = ctx->mrpdp_param;

    // Allocate a block and the proof structure
    if ((block = malloc(p->block_size)) == NULL) goto cleanup;
    if ((proof->T = BN_new()) == NULL) goto cleanup;    
    if ((proof->rho_temp = BN_new()) == NULL) goto cleanup;

    // Compute the indices i_j = pi_k1(j); the block indices to sample 
    I = gen_prp_pi(chal->k1, p->prp_key_size, p->num_blocks, chal->c);
    if (!I) goto cleanup;

    for(i = 0; i < chal->c; i++) {
        memset(block, 0, p->block_size);
        block_len = p->block_size;

        err = ctx->ops->get_tag(ctx, I[i], &tag, &tag_len); 
        if (err) goto cleanup;
        err = ctx->ops->get_block(ctx, I[i], block, &block_len);
        if (err) goto cleanup;
        err = mrpdp_proof_update(ctx, key, proof, chal, tag, 
                                block, p->block_size, i);
        if (err) goto cleanup;
        mrpdp_tag_free(tag);
        tag = NULL;
    }
    // 'finalize' the proof
    err = mrpdp_proof_update(ctx, key, proof, chal, NULL, NULL, 0, 0);
    if (err) goto cleanup;

    status = 0;
    
cleanup:
    sfree(block, p->block_size);
    sfree(I, chal->c * sizeof(unsigned int));
    if (tag) mrpdp_tag_free(tag);

    // 'finish' access to stateful methods
    ctx->ops->get_tag(ctx, 0, NULL, NULL);
    ctx->ops->get_block(ctx, 0, NULL, NULL);
    return status;
}


/**
 * @brief Verifies that a proof is a correct response to a challenge.
 * @return 0 on success, 1 on failure, -1 on error
 **/
int mrpdp_proof_verify(const pdp_ctx_t *ctx, const pdp_mrpdp_key_t *key,
                      const pdp_mrpdp_challenge_t *chal,
                      const pdp_mrpdp_proof_t *proof)
{
    BIGNUM *tao = NULL;
    BIGNUM *denom = NULL;
    BIGNUM *coefficient_a = NULL;
    BIGNUM *fdh_hash = NULL;
    BIGNUM *tao_s = NULL;
    BIGNUM *r0 = NULL;
    BN_CTX *bctx = NULL;
    unsigned char *index_prf = NULL;
    size_t index_prf_size = 0;
    unsigned char *prf_result = NULL;
    size_t prf_result_size = 0;
    unsigned char *H_result = NULL;
    size_t H_result_size = 0;
    unsigned int j = 0;
    unsigned int *indices = NULL;
    pdp_mrpdp_ctx_t *p = NULL;
    int result = -1, status = -1;

    if (!is_mrpdp(ctx) || !key || !chal || !proof)
        return -1;
    p = ctx->mrpdp_param;

    // Verify keys
    if (!key->rsa || !key->rsa->e || !key->rsa->n)
        return -1;

    // Make sure we don't have a "sanitized" challenge
    if (!chal->s)
        return -1;

    // Allocate memory
    if ((tao = BN_new()) == NULL) goto cleanup;
    if ((denom = BN_new()) == NULL) goto cleanup;
    if ((coefficient_a = BN_new()) == NULL) goto cleanup;
    if ((r0 = BN_new()) == NULL) goto cleanup;
    if ((tao_s = BN_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;

    // Compute tao where tao = T^e 
    if (!BN_mod_exp(tao, proof->T, key->rsa->e, key->rsa->n, bctx))
        goto cleanup;

    // Compute the indices i_j = pi_k1(j); the indices of blocks to sample
    indices = gen_prp_pi(chal->k1, p->prp_key_size, p->num_blocks, chal->c);
    for (j = 0; j < chal->c; j++) {

        // Perform the pseudo-random function Wi = w_v(i)
        index_prf = gen_prf_f(key->v, p->prf_key_size, indices[j], 
                              &index_prf_size);
        if (!index_prf) goto cleanup;

        // Calculate the full-domain hash h(W_i)
        fdh_hash = gen_fdh(key->rsa, index_prf, index_prf_size);
        if (!fdh_hash) goto cleanup;

        // Use E-PDP
        if (p->opts & MRPDP_USE_E_PDP) {
            // No coefficients in E-PDP, so just copy FDH result in
            if (!BN_copy(r0, fdh_hash)) goto cleanup;
        } else {
            // Generate the coefficient for block index a = f_k2(j)
            prf_result = gen_prf_f(chal->k2, p->prf_key_size, j, 
                                   &prf_result_size);
            if (!prf_result) goto cleanup;

            // Convert prf coefficient result to a BIGNUM 
            if (!BN_bin2bn(prf_result, prf_result_size, coefficient_a))
                goto cleanup;

            // Calculate h(W_i)^a
            if (!BN_mod_exp(r0, fdh_hash, coefficient_a, key->rsa->n, bctx))
                goto cleanup;
        }
        // Calculate products of h(W_i)^a (no coefficeint a in E-PDP)
        if (BN_is_zero(denom)) {
            if (!BN_copy(denom, r0)) goto cleanup;
        } else {
            if (!BN_mod_mul(denom, denom, r0, key->rsa->n, bctx)) goto cleanup;
        }
        
        // Free memory before next loop iteration
        sfree(index_prf, index_prf_size);
        sfree(prf_result, prf_result_size);
        if (fdh_hash) BN_clear_free(fdh_hash);
    } // end for

    // Calculate tao, where tao = tao/h(W_i)^a mod N
    // Inverse h(W_i)^a to create 1/h(W_i)^a
    if (!BN_mod_inverse(denom, denom, key->rsa->n, bctx)) goto cleanup;
    // tao = tao * 1/h(W_i)^a mod N
    if (!BN_mod_mul(tao, tao, denom, key->rsa->n, bctx)) goto cleanup;

    // Calculate tao^s mod N
    if (!BN_mod_exp(tao_s, tao, chal->s, key->rsa->n, bctx)) goto cleanup;
    
    // Calculate H(tao^s mod N)
    H_result = gen_bn_H(tao_s, &(H_result_size));
    if (!H_result) goto cleanup;
    
    // The final verification step.  Does rho == rho? 
    result = (memcmp(H_result, proof->rho, proof->rho_size) == 0) ? 0 : 1;
    status = 0;

cleanup:
    if (tao) BN_clear_free(tao);
    if (denom) BN_clear_free(denom);
    if (coefficient_a) BN_clear_free(coefficient_a);
    if (tao_s) BN_clear_free(tao_s);    
    if (r0) BN_clear_free(r0);
    if (bctx) BN_CTX_free(bctx);    
    sfree(prf_result, prf_result_size);
    sfree(H_result, H_result_size);
    sfree(indices, (chal->c * sizeof(unsigned int)));
    if (status) {
        if(fdh_hash) BN_clear_free(fdh_hash);
        if(index_prf_size > 0) sfree(index_prf, index_prf_size);
    }
    return result;
}


/**
 * @brief Frees the internal structures allocated within a proof.
 * @return 0 on success, non-zero on error
 **/
int mrpdp_proof_free(const pdp_ctx_t *ctx, pdp_mrpdp_proof_t *proof)
{
    if (!is_mrpdp(ctx) || !proof) return -1;

    if (proof->T) BN_clear_free(proof->T);
    if (proof->rho_temp) BN_clear_free(proof->rho_temp);
    if (proof->rho_size > 0) sfree(proof->rho, proof->rho_size);
    return 0;
}

/** @} */
