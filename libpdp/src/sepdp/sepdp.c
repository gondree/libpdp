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
/** @addtogroup SEPDP
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
#include <pdp/sepdp.h>
#include "pdp_misc.h"
#include "sepdp_misc.h"
#include "sepdp_storage.h"


/// a struct that holds all the arguments for a worker thread
struct pdp_job_arg {
    pdp_ctx_t *ctx;             ///< context
    pdp_sepdp_key_t *key;       ///< key
    FILE *file;                 ///< file to tag, a unique fd for this job
    int index;                  ///< first token index for this job
    int numtokens;              ///< number of tokens this job will generate
    pdp_sepdp_tag_t **tokens;   ///< memory used to store the result
};


/**
 * @brief Implements sanitize_stub()
 *
 * There is nothing to sanitise. Simply does a deep-copy.
 *
 * @return 0 on success, non-zero on error
 **/
static int sepdp_chal_sanitize(const pdp_ctx_t* ctx, 
                        const pdp_challenge_t* c_i, pdp_challenge_t* c_o)
{    
    if (!is_sepdp(ctx) || !c_i || !c_o)
        return -1;

    if ((c_o->sepdp = malloc(sizeof(pdp_sepdp_challenge_t))) == NULL)
        goto cleanup;
    memset(c_o->sepdp, 0, sizeof(pdp_sepdp_challenge_t));

    c_o->sepdp->i = c_i->sepdp->i;
    
    c_o->sepdp->ki_size = c_i->sepdp->ki_size;
    if ((c_o->sepdp->ki = malloc(c_o->sepdp->ki_size)) == NULL) goto cleanup;
    memcpy(c_o->sepdp->ki, c_i->sepdp->ki, c_o->sepdp->ki_size);
    
    c_o->sepdp->ci_size = c_i->sepdp->ci_size;
    if ((c_o->sepdp->ci = malloc(c_o->sepdp->ci_size)) == NULL) goto cleanup;
    memcpy(c_o->sepdp->ci, c_i->sepdp->ci, c_o->sepdp->ci_size);
    
    return 0;

cleanup:
    sepdp_challenge_free(ctx, c_o->sepdp); 
    return -1;
}



/**
 * @brief Initializes the default context for sepdp.
 * @return 0 on success, non-zero on error
 **/
int sepdp_ctx_init(pdp_ctx_t *ctx)
{
    pdp_sepdp_ctx_t *p = NULL;
    if (!ctx || (ctx->algo != PDP_SEPDP))
        return -1;
    // need to free in sepdp_ctx_free
    if ((p = malloc(sizeof(pdp_sepdp_ctx_t))) == NULL)
        return -1;
    memset(p, 0, sizeof(pdp_sepdp_ctx_t));
    ctx->sepdp_param = p;
    return 0;
}


/**
 * @brief Initializes the default context for sepdp.
 * 
 * Expects ctx->sepdp to point to a fully-allocated
 * pdp_sepdp_ctx_t structure.
 *
 * @return 0 on success, non-zero on error
 **/
int sepdp_ctx_create(pdp_ctx_t *ctx)
{
    pdp_sepdp_ctx_t *p = NULL;
    unsigned int tmp;

    if (!is_sepdp(ctx))
        return -1;    
    p = ctx->sepdp_param;

    if (!p->prf_key_size) {
        p->prf_key_size = SEPDP_DEFAULT_PRF_KEY_SIZE;
    }
    if (!p->prp_key_size) {
        p->prp_key_size = SEPDP_DEFAULT_PRP_KEY_SIZE;
    }
    if (!p->ae_key_size) {
        p->ae_key_size = SEPDP_DEFAULT_AE_KEY_SIZE;
    }
    if (!p->year) {
        p->year = SEPDP_DEFAULT_YEARS;
    }
    if (!p->min) {
        p->min = SEPDP_DEFAULT_MIN;
    }
    
    // we haven't made any challenges yet
    p->num_chal_created = 0;
    p->num_chal_used = 0;
    
    // default blocksize
    tmp = p->block_size;
    if (!tmp) {
        tmp = SEPDP_DEFAULT_BLOCK_SIZE_BYTES;
    } else {
        // 'clean' any non-default value specified
        tmp = next_pow_2(tmp);
        tmp = (tmp <= 128) ? 256 : tmp;
    }
    p->block_size = tmp;

    // default challenge params
    if (!p->num_challenge_blocks) {
        p->num_challenge_blocks = SEPDP_MAGIC_CHALLENGE_BLOCKS;
    }

    // set number of blocks, if possible to do so early
    p->num_blocks = 0;
    if (ctx->file_st_size) {
        p->num_blocks = (ctx->file_st_size / p->block_size);
        p->num_blocks = (p->num_blocks < 1) ? 1 : p->num_blocks;
    }

    // set default function pointers
    if (ctx->opts & PDP_OPT_USE_S3) {
        ctx->ops->get_tag = sepdp_get_tag_s3;
        ctx->ops->get_block = sepdp_get_block_s3;
    } else {
        ctx->ops->get_tag = sepdp_get_tag_file;
        ctx->ops->get_block = sepdp_get_block_file;
    }
    ctx->ops->sanitize = sepdp_chal_sanitize;

    return 0;
}


/**
 * @brief Free the context for sepdp.
 * @return 0 on success, non-zero on error
 **/
int sepdp_ctx_free(pdp_ctx_t *ctx)
{
    if (!ctx)
        return -1;
    sfree(ctx->sepdp_param, sizeof(pdp_sepdp_ctx_t));
    return 0;
}


/**
 * @brief Generate a single token.
 *
 * @param[in]    ctx      context
 * @param[in]    key      key
 * @param[in]    file     fd for file to tag
 * @param[out]   token    points to an empty token container
 * @param[in]    index    the index of the token
 * @return 0 on success, non-zero on error
 **/
static int sepdp_token_gen(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key,
                           FILE *file, pdp_sepdp_tag_t *token,
                           unsigned int index)
{
    pdp_sepdp_ctx_t *p;
    unsigned char **blocks = NULL;
    unsigned int *indices = NULL;
    unsigned int blocks_num = 0;
    unsigned char *ki = NULL;
    unsigned char *ci = NULL;
    unsigned char *ptok = NULL;
    size_t ki_size = 0;
    size_t ci_size = 0;
    size_t ptok_size = 0;
    unsigned int i;
    int status = -1;
    
    if (!is_sepdp(ctx) || !key || !file || !token)
        return -1;
    p = ctx->sepdp_param;

    // the token will cover blocks_num blocks  
    blocks_num = (p->num_blocks < p->num_challenge_blocks) ? 
                    p->num_blocks : p->num_challenge_blocks;

    // allocate space
    if ((blocks = calloc(1, blocks_num * sizeof(unsigned char *))) == NULL)
        goto cleanup;
    for (i = 0; i < blocks_num; i++) {
        if ((blocks[i] = calloc(1, p->block_size)) == NULL) goto cleanup;
    }
    token->index = index;
    token->tok_size = p->block_size;
    token->mac_size = EVP_MAX_MD_SIZE;
    token->iv_size = p->ae_key_size;
    if ((token->tok = calloc(1, token->tok_size)) == NULL) goto cleanup;
    if ((token->mac = calloc(1, token->mac_size)) == NULL) goto cleanup;
    if ((token->iv = calloc(1, token->iv_size)) == NULL) goto cleanup; 

    // generate a PRP key, k_i
    ki = gen_prf_f(key->W, p->prf_key_size, token->index, &ki_size);
    if (!ki) goto cleanup;
    // generate a challenge nonce
    ci = gen_prf_f(key->Z, p->prf_key_size, token->index, &ci_size);
    if (!ci) goto cleanup;
    // generate the indices for this token
    indices = gen_prp_pi(ki, ki_size, p->num_blocks, blocks_num);
    if (!indices) goto cleanup;
    
    // get each block covered by the token
    if (fseek(file, 0, SEEK_SET) < 0) goto cleanup;
    for (i = 0; i < blocks_num; i++) {
        // Seek to data block at indices[j]
        if (fseek(file, (p->block_size * (indices[i])), SEEK_SET) < 0)
            goto cleanup;
        // Read data block
        fread(blocks[i], p->block_size, 1, file);
        if (ferror(file)) goto cleanup;
    }

    ptok = gen_ar_H(ci, ci_size, blocks, blocks_num, p->block_size, &ptok_size);
    if (!ptok) goto cleanup;
    
    /// @todo no independent MAC key for token?
    i = encrypt_then_mac(key->K, key->K_size, key->K, key->K_size,
                         ptok, ptok_size, token->tok, &(token->tok_size),
                         token->mac, &(token->mac_size), 
                         token->iv, token->iv_size);
    if (i) goto cleanup;
    status = 0;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Extracting - ");
    pdp_hexdump("  ci", token->index, ci, ci_size);
    pdp_hexdump("  ki", token->index, ki, ki_size);

    DEBUG(1, "\n Writing - ");
    DEBUG(1, "\n Token %02d", token->index);
    pdp_hexdump("  iv", token->index, token->iv, token->iv_size);
    pdp_hexdump("  tok", token->index, token->tok, token->tok_size);
    pdp_hexdump("  mac", token->index, token->mac, token->mac_size);
#endif // _PDP_DEBUG

cleanup:
    sfree(ki, ki_size);
    sfree(ci, ci_size);
    sfree(ptok, ptok_size);
    sfree(indices, blocks_num * sizeof(unsigned int));
    for (i = 0; i < blocks_num; i++) {
        sfree(blocks[i], p->block_size);
    }
    sfree(blocks, blocks_num * sizeof(unsigned char *));
    if (status) sepdp_tag_free(ctx, token);
    return status;
}


/**
 * @brief Free a token.
 *
 * @param[in]        ctx      context
 * @param[in, out]   token    points to the token to destroy
 * @return none
 **/
void sepdp_tag_free(const pdp_ctx_t *ctx, pdp_sepdp_tag_t *token)
{
    if (!is_sepdp(ctx) || !token) return;
    sfree(token->iv, token->iv_size);
    sfree(token->tok, token->tok_size);
    sfree(token->mac, token->mac_size);
    token->index = 0;
}


/**
 * @brief Describes a single tagging job.
 *
 * If num_threads is 1, this performs all the tagging, serially.
 **/
static void *sepdp_tag_thread(void *args)
{
    struct pdp_job_arg *arg = (struct pdp_job_arg *) args;
    pdp_ctx_t *ctx;
    pdp_sepdp_tag_t *token = NULL;
    unsigned int i, index;
    int *ret = NULL;
    
    if (!arg || !arg->ctx || !arg->key || !arg->file ||
                !arg->tokens || !arg->numtokens)
        goto cleanup;
    ctx = arg->ctx; 
    
    // allocate memory for return value (will be freed by producer thread)
    if ((ret = malloc(sizeof(int))) == NULL)
        goto cleanup;
    *ret = -1;

    // For N threads, generate every N-th token
    index = arg->index;
    for (i = 0; i < arg->numtokens; i++) {

        if ((token = malloc(sizeof(pdp_sepdp_tag_t))) == NULL)
            goto cleanup;
        memset(token, 0, sizeof(pdp_sepdp_tag_t));

        // calculate the token
        if (sepdp_token_gen(ctx, arg->key, arg->file, token, index) != 0)
            goto cleanup;

        arg->tokens[index] = token;
        token = NULL;
        index += ctx->num_threads;
    }
    *ret = 0;

cleanup:
    if (!ret || (ret && *ret))
        PDP_ERR("some thread was unable to create a tag.");
    if (token)
        sfree(token, sizeof(pdp_sepdp_tag_t));
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
static int sepdp_gen_tags_all(pdp_ctx_t *ctx, pdp_sepdp_key_t *k,
                              pdp_sepdp_tagdata_t *t)
{
    struct pdp_job_arg arg;
    int *ret = NULL;
    int status = -1;

    // populate the arguments to perform the job
    arg.ctx = ctx;
    arg.key = k;
    arg.index = 0;
    arg.numtokens = t->tokens_num;
    arg.tokens = t->tokens;
    arg.file = fopen(ctx->filepath, "r");
    if (!arg.file) goto cleanup;

    // perform the job
    ret = (int *) sepdp_tag_thread((void *) &arg);
    
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
static int sepdp_gen_tags_all_threaded(pdp_ctx_t *ctx, pdp_sepdp_key_t *k,
                                        pdp_sepdp_tagdata_t *t)
{
#ifndef _THREAD_SUPPORT
    PDP_UNSUPPORTED("pthread");
    return -1;
#else
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
        args[i].numtokens = t->tokens_num/ctx->num_threads;
        args[i].tokens = t->tokens;

        // if there is not an equal number of blocks to tag, add the 
        // extra blocks to the corresponding thread
        if (i < t->tokens_num % ctx->num_threads)
            args[i].numtokens++;
        
        // If the thread has blocks to tag, then spawn it
        if (args[i].numtokens > 0) {
            err = pthread_create(&threads[i], NULL, sepdp_tag_thread,
                                 (void *) &args[i]);
            if (err)
                goto cleanup;
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
 *
 * @param[in,out]  ctx  The context for the PDP routine.
 * @param[in]      k    The secret key data.
 * @param[out]     t    The tag data that is generated.
 * @return 0 on success, non-zero on error
 **/
int sepdp_tags_gen(pdp_ctx_t *ctx, pdp_sepdp_key_t *k, 
                   pdp_sepdp_tagdata_t *t)
{
    pdp_sepdp_ctx_t *p = NULL;
    unsigned int num_blocks;
    int err = 0;

    if (!is_sepdp(ctx) || !k || !t)
        return -1;
    p = ctx->sepdp_param;
    t->tokens = NULL;

    OpenSSL_add_all_digests();

    // our caller filled out some ctx at this point, so
    // we can calculate some relevant params
    num_blocks = (ctx->file_st_size / p->block_size);
    if (ctx->file_st_size % p->block_size)
        num_blocks++;
    p->num_blocks = num_blocks;

    // calculate the number of tokens to prepare, based on audit times
    t->tokens_num = p->num_chal_created = ((p->year * 365 * 24 * 60)/p->min);

    // allocate space for tokens
    t->tokens_size = t->tokens_num * sizeof(pdp_sepdp_tag_t *);
    if ((t->tokens = malloc(t->tokens_size)) == NULL)
        goto cleanup;
    memset(t->tokens, 0, t->tokens_size);

    // now we can start tagging    
    if ((ctx->opts & PDP_OPT_THREADED) && (ctx->num_threads > 1)) {
        // if are using threads
        err = sepdp_gen_tags_all_threaded(ctx, k, t);
    } else {
        // no threads
        err = sepdp_gen_tags_all(ctx, k, t);
    }
    if (err)
        goto cleanup;
    EVP_cleanup();
    return 0;

cleanup:
    sfree(t->tokens, t->tokens_size);
    t->tokens_size = 0;
    t->tokens_num = 0;
    EVP_cleanup();
    return -1;
}


/**
 * @brief Frees a tags structure
 * @return 0 on success, non-zero on error
 **/
int sepdp_tags_free(const pdp_ctx_t *ctx, pdp_sepdp_tagdata_t *t)
{
    int i;

    if (!t || !t->tokens_num)
        return -1;

    for (i = 0; i < t->tokens_num; i++) {
        sepdp_tag_free(ctx, t->tokens[i]);
        sfree(t->tokens[i], sizeof(pdp_sepdp_tag_t));
    }
    sfree(t->tokens, t->tokens_size);
    t->tokens_size = 0;
    t->tokens_num = 0;
    return 0;
}


/**
 * @brief Stores data and tags.
 * @return 0 on success, non-zero on error
 **/
int sepdp_store(const pdp_ctx_t *ctx, const pdp_sepdp_tagdata_t* tag)
{
    if (!is_sepdp(ctx))
        return -1;

    if (ctx->opts & PDP_OPT_USE_S3) {
        // we need to write ctx->filepath and the tagdata to S3
        return sepdp_write_data_to_s3(ctx, tag);
    } else {
        // the file we tagged is already stored in ctx->filepath
        // so we only need to write tag data to ctx->ofilepath
        return sepdp_write_tags_to_file(ctx, tag);
    }
    return -1;
}


/**
 * @brief Generates a challenge.
 *
 * Generates a challenge based on a counter kept in ctx,
 * so that challenges are never repeated.
 *        
 * @return 0 on success, non-zero on error
 **/
int sepdp_challenge_gen(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key, 
                        pdp_sepdp_challenge_t *c)
{
    pdp_sepdp_ctx_t *p = NULL;
    int status = -1;
    
    if (!is_sepdp(ctx) || !c)
        return -1;
    p = ctx->sepdp_param;

    // we will challenge ell blocks
    c->i = p->num_chal_used;
    
    // generate the psuedo-random permutation key k_i 
    c->ki = gen_prf_f(key->W, key->W_size, c->i, &(c->ki_size));
    if (!c->ki) goto cleanup;

    // generate the pseudo-random challenge nonce c_i 
    c->ci = gen_prf_f(key->Z, key->Z_size, c->i, &(c->ci_size));
    if (!c->ci) goto cleanup;

    p->num_chal_used++;
    status = 0;
    
cleanup:
    if (status) sepdp_challenge_free(ctx, c);
    return status;
}


/**
 * @brief Frees a challenge structure.
 * @return 0 on success, non-zero on error
 **/
int sepdp_challenge_free(const pdp_ctx_t *ctx, pdp_sepdp_challenge_t *c)
{
    if (!is_sepdp(ctx) || !c)
        return -1;

    if (c->i) c->i = 0;
    sfree(c->ki, c->ki_size);
    sfree(c->ci, c->ci_size);
    memset(c, 0, sizeof(pdp_sepdp_challenge_t));
    return 0;
}



/**
 * @brief Generates a proof.
 *
 * @return 0 on success, non-zero on error
 **/
int sepdp_proof_gen(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key,
                    const pdp_sepdp_challenge_t *c, pdp_sepdp_proof_t *proof)
{
    pdp_sepdp_ctx_t *p;
    pdp_sepdp_tag_t *tag = NULL;
    unsigned char **blocks = NULL;
    unsigned int *indices = NULL;
    unsigned int blocks_num = 0;
    unsigned int block_len = 0;
    unsigned int i, err;
    int status = -1;
    
    if (!is_sepdp(ctx) || !c || !c->ki || !c->ci || !proof)
        return -1;
    p = ctx->sepdp_param;

    // the number of blocks to challenge, associated with the token
    blocks_num = (p->num_blocks < p->num_challenge_blocks) ? 
                    p->num_blocks : p->num_challenge_blocks;
    block_len = p->block_size;

    // allocate space
    if ((blocks = calloc(1, blocks_num * sizeof(unsigned char *))) == NULL)
        goto cleanup;
    for (i = 0; i < blocks_num; i++) {
        if ((blocks[i] = calloc(1, block_len)) == NULL) goto cleanup;
    }

    // generate the indices for this token
    indices = gen_prp_pi(c->ki, c->ki_size, p->num_blocks, blocks_num);
    if (!indices) goto cleanup;
    
    // get each block covered by the token
    for (i = 0; i < blocks_num; i++) {
        err = ctx->ops->get_block(ctx, indices[i], blocks[i], &block_len);
        if (err) goto cleanup;
    }

    proof->z = gen_ar_H(c->ci, c->ci_size, blocks, blocks_num, 
                        p->block_size, &(proof->z_size));
    if (!proof->z) goto cleanup;

    err = ctx->ops->get_tag(ctx, c->i, &tag, &i);
    if (err) goto cleanup;

    proof->iv_size = tag->iv_size;
    proof->iv = tag->iv;
    tag->iv = NULL;
    proof->tok_size = tag->tok_size;
    proof->tok = tag->tok;
    tag->tok = NULL;
    proof->mac_size = tag->mac_size;
    proof->mac = tag->mac;
    tag->mac = NULL;
    status = 0;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Extracting - ");
    pdp_hexdump("  ci", c->i, c->ci, c->ci_size);
    pdp_hexdump("  ki", c->i, c->ki, c->ki_size);

    DEBUG(1, "\n Reading - ");
    DEBUG(1, "\n Token %02d", c->i);
    pdp_hexdump("  iv", c->i, proof->iv, proof->iv_size);
    pdp_hexdump("  tok", c->i, proof->tok, proof->tok_size);
    pdp_hexdump("  mac", c->i, proof->mac, proof->mac_size);
#endif // _PDP_DEBUG

cleanup:
    if (tag) sepdp_tag_free(ctx, tag);
    if (blocks) {
        for (i = 0; i < blocks_num; i++) {
            sfree(blocks[i], block_len);
        }
        sfree(blocks, blocks_num * sizeof(unsigned char *));
    }
    if (indices) {
        sfree(indices, sizeof(unsigned int) * blocks_num);
    }
    // 'finish' access to stateful methods
    ctx->ops->get_tag(ctx, 0, NULL, NULL);
    ctx->ops->get_block(ctx, 0, NULL, NULL);
    return status;
}


/**
 * @brief Verifies that a proof is a correct response to a challenge.
 *
 * @return 0 on success, 1 on failure, -1 on error
 **/
int sepdp_proof_verify(const pdp_ctx_t *ctx, const pdp_sepdp_key_t *key,
                        const pdp_sepdp_challenge_t *c,
                        const pdp_sepdp_proof_t *proof)
{
    unsigned char *ptxt = NULL;
    size_t ptxt_len = 0;
    int result = -1;

    if (!is_sepdp(ctx) || !key || !c || !proof)
        return -1;

    ptxt_len = proof->tok_size;
    if ((ptxt = malloc(ptxt_len)) == NULL) goto cleanup;

    /// @todo no independent MAC key for token?
    if (verify_then_decrypt(key->K, key->K_size, key->K, key->K_size,
            proof->tok, proof->tok_size, proof->mac, proof->mac_size, 
            proof->iv, proof->iv_size, ptxt, &ptxt_len))
        return -1;

    if (proof->z_size != ptxt_len)
        return -1;

    result = (memcmp(proof->z, ptxt, proof->z_size) == 0) ? 0 : 1;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Verifying - ");
    DEBUG(1, "\n Token %02d", c->i);
    pdp_hexdump("  z", c->i, proof->z, proof->z_size);
    pdp_hexdump("  calc", c->i, ptxt, ptxt_len);
#endif // _PDP_DEBUG

cleanup:
    sfree(ptxt, ptxt_len);
    return result;
}


/**
 * @brief Frees the internal structures allocated within a proof.
 * @return 0 on success, non-zero on error
 **/
int sepdp_proof_free(const pdp_ctx_t *ctx, pdp_sepdp_proof_t *proof)
{
    if (!is_sepdp(ctx) || !proof)
        return -1;

    sfree(proof->z, proof->z_size);
    sfree(proof->iv, proof->iv_size);
    sfree(proof->tok, proof->tok_size);
    sfree(proof->mac, proof->mac_size);
    return 0;
}

/** @} */
