/**
 * @file
 * Interfaces for the libpdp library.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup PDP
 * @{ 
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <pdp.h>
#include <pdp/macpdp.h>
#include <pdp/apdp.h>
#include <pdp/cpor.h>
#include <pdp/sepdp.h>
#include <openssl/evp.h>
#include "pdp_misc.h"

#define DEFUALT_BUCKET_NAME "libpdp_data";


/**
 * @brief Reads a tag
 *
 * Function intended primarily for internal module use.
 * 
 * The tag data is returned through buf. For some modules,
 * this holds a pointer to tag structure, for others this points directly
 * to a buffer holding tag data.
 *
 * @note Not thread-safe: Possibly uses static variables to keep state. 
 * 
 * The caller should end access to this function (i.e., close files)
 * by calling it with NULL inputs, i.e. func(ctx, 0, NULL, NULL).
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     i      the index of block.
 * @param[out]    buf    pointer to output
 * @param[in,out] len    the size of the output, if needed
 * @return 0 on success, non-zero on error
 **/
static int get_tag_stub(const pdp_ctx_t* ctx, unsigned int i, 
                        void *buf, unsigned int *len)
{
    return -1;
}

/**
 * @brief Reads a file block - 
 *
 * Function intended primarily for internal module use.
 * 
 * Reads (into buf) the first len bytes starting at the i-th block.
 * Intended for reading one or more blocks starting at the i-th block.
 * Issues a warning if a fraction of a tag will be read.
 *
 * @note Not thread-safe: Possibly uses static variables to keep state. 
 * 
 * The caller should end access to this function (i.e., close files)
 * by calling it with NULL inputs, i.e. func(ctx, 0, NULL, NULL).
 *
 * @param[in]     ctx    context
 * @param[in]     i      the index of block.
 * @param[out]    buf    pointer to an output buffer.
 * @param[in,out] len    the size of buf; on success, holds bytes written.
 * @return 0 on success, non-zero on error
 **/
static int get_block_stub(const pdp_ctx_t* ctx, unsigned int i, 
                          void *buf, unsigned int *len)
{
    return -1;
}

/**
 * @brief Create a 'cleaned' challenge for the prover.
 *
 * Required for applications that must communicate 
 * some challenge to an untrusted process (as in most
 * applications).
 *
 * Some challenge-repsonse protocols generate secret challenge data
 * that must be held by the challenger to verify the response, and should
 * not be sent to the prover. This routine is used to
 * 'sanitize' the challenge, to generate one that can be sent to
 * the prover.
 *
 * Essentially, copies allthe public data from c_i into c_o
 *
 * @param[in]     ctx    context
 * @param[in]     c_i    the challenger's challenge data
 * @param[out]    c_o    the verifier's sanitized challenge data
 * @return 0 on success, non-zero on error
 **/
static int sanitize_stub(const pdp_ctx_t* ctx,
                         const pdp_challenge_t* c_i,
                         pdp_challenge_t *c_o)
{
    return -1;
}


/**
 * @brief Initializes the algorithm-specifc context data.
 *
 * Allocates the algoritm-specific data structures in ctx.
 * Overwrites all data in ctx, except ctx->algo. 
 * This is the first function that should be called on ctx, 
 * as soon as some algorithm is selected, using the
 * appropriate selection macro.
 * 
 * @param[in]     ctx    context
 * @return 0 on success, non-zero on error
 **/
int pdp_ctx_init(pdp_ctx_t *ctx)
{
    int err = 0;

    if (!ctx) {
        PDP_ERR("NULL ctx pointer");
        return -1;
    }

    // thiese are not thread-safe, so we do it early
    OpenSSL_add_all_algorithms();
    OpenSSL_add_all_digests();

    // remember to free this in pdp_ctx_free
    if ((ctx->ops = malloc(sizeof(struct pdp_ctx_ops))) == NULL)
        goto cleanup;

    // initialize sensible defaults
    ctx->ops->get_tag = get_tag_stub;
    ctx->ops->get_block = get_block_stub;
    ctx->ops->sanitize = sanitize_stub;
    ctx->opts = 0;
    ctx->verbose = 0;
    ctx->num_threads = sysconf(_SC_NPROCESSORS_ONLN);
    if (ctx->num_threads == -1) {
       goto cleanup;
    } else if (ctx->num_threads > 1) {
        ctx->opts |= PDP_OPT_THREADED;
    }
    ctx->ifilepath = NULL;
    ctx->ifilepath_len = 0;
    ctx->filepath = NULL;
    ctx->filepath_len = 0;
    ctx->file_st_size = 0;
    ctx->ofilepath = NULL;
    ctx->ofilepath_len = 0;
#ifdef _S3_SUPPORT
    ctx->s3_access_key = NULL;
    ctx->s3_access_key_len = 0;
    ctx->s3_secret_key = NULL;
    ctx->s3_secret_key_len = 0;
    ctx->s3_hostname = NULL;
    ctx->s3_hostname_len = 0;
    ctx->s3_bucket_name = NULL;
    ctx->s3_bucket_name_len = 0;
    ctx->s3_protocol = 0;
#endif

    // process algo specific context data
    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_ctx_init(ctx);
            break;
        case PDP_APDP:
            err = apdp_ctx_init(ctx);
            break;
        case PDP_CPOR:
            err = cpor_ctx_init(ctx);
            break;
        case PDP_SEPDP:
            err = sepdp_ctx_init(ctx);
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        goto cleanup;
    return 0;

cleanup:
    EVP_cleanup();
    sfree(ctx->ops, sizeof(struct pdp_ctx_ops));
    return -1;
}



/**
 * @brief Initialize ctx parameters, based on any existing parameters.
 *
 * The ctx parameters are initialized to values that are not sensible
 * defaults. If a user changes those values, this function should
 * respect those inputs (in so far it is safe and rational). In the
 * absence of new values, we will populate ctx with better defaults.
 *
 * The algo-specific routines may set up back-end specific routines
 * for getting blocks, tags, and other objects (i.e., getting
 * tags from S3 or parsing them out of a file).
 *
 * @param[in,out] ctx       Pointer to a context structure, that
 *                          is empty, or partially filled out.
 * @param[in]     filename  Name of local file to process.
 * @param[in]     output    Name of file ot output, after processing.
 * @return 0 on success, non-zero on error
 **/
int pdp_ctx_create(pdp_ctx_t *ctx, const char* filename, const char* output)
{
    int err = 0;
    struct stat st;
    unsigned int slen;
    char *tmp = NULL;
    char tmps[MAXPATHLEN];

    memset(&st, 0, sizeof(struct stat));
    memset(tmps, 0, sizeof(tmps));

    if (!ctx) {
        PDP_ERR("NULL ctx pointer");
        return -1;
    } else if (!filename) {
        PDP_ERR("filename not present");
        return -1;
    } else if (strlen(filename) >= MAXPATHLEN) {
        PDP_ERR("filename too long");
        return -1;
    } else if (output && (strlen(output) > MAXPATHLEN - 4)) {
        PDP_ERR("output filename too long");
        return -1;
    }

    // ifilename
    ctx->ifilepath_len = strlen(filename)+1;
    if ((ctx->ifilepath = malloc(ctx->ifilepath_len)) == NULL) {
        goto cleanup;
    }
    strcpy(ctx->ifilepath, filename);

    // filepath (default: work directly on the original file)
    if (output) {
         ctx->filepath_len = strlen(output)+1;
    } else {
         ctx->filepath_len = strlen(filename)+1;
    }
    if ((ctx->filepath = malloc(ctx->filepath_len)) == NULL) {
        goto cleanup;
    }
    if (output) {
        strcpy(ctx->filepath, output);
    } else {
        strcpy(ctx->filepath, filename);
    }

    // ofilepath (filepath with '.tag' extension)
    ctx->ofilepath_len = snprintf(tmps, MAXPATHLEN, "%s.tag", ctx->filepath)+1;
    if (ctx->ofilepath_len > MAXPATHLEN) {
        goto cleanup;
    } else if ((ctx->ofilepath = malloc(ctx->ofilepath_len)) == NULL) {
        goto cleanup;
    }
    strcpy(ctx->ofilepath, tmps);

    // we populate file_st_size whenever we can and believe
    // the data is pretty accurate. We do this before tagging too,
    // just in case ifilepath gets pre-processed into filepath
    if (!access(ctx->filepath, F_OK) && !stat(ctx->filepath, &st)) {
        ctx->file_st_size = st.st_size;
    }

    // make as many threads as processors
    if (ctx->opts & PDP_OPT_THREADED) {
#ifndef _THREAD_SUPPORT
        PDP_UNSUPPORTED("pthread");
        goto cleanup;
#else
        // threading requested yet ctx has 0 or 1 threads selected
        if (ctx->num_threads < 2) {
            ctx->num_threads = sysconf(_SC_NPROCESSORS_ONLN);
        }
#endif //_THREAD_SUPPORT
    }
    
    // gather parameters from environment
    if (ctx->opts & PDP_OPT_USE_S3) {
#ifndef _S3_SUPPORT
        PDP_UNSUPPORTED("S3");
        goto cleanup;
#else
        if (!ctx->s3_access_key) {
            if ((tmp = getenv("S3_ACCESS_KEY_ID")) == NULL) {
                PDP_ERR("S3_ACCESS_KEY_ID environment variable not set");
                goto cleanup;
            }
            ctx->s3_access_key_len = strlen(tmp)+1;
            ctx->s3_access_key = malloc(ctx->s3_access_key_len);
            if (!ctx->s3_access_key) {
                goto cleanup;
            }
            strcpy(ctx->s3_access_key, tmp);
        }
        if (!ctx->s3_secret_key) {
            if ((tmp = getenv("S3_SECRET_ACCESS_KEY")) == NULL) {
                PDP_ERR("S3_SECRET_ACCESS_KEY environment variable not set");
                goto cleanup;
            }
            ctx->s3_secret_key_len = strlen(tmp)+1;
            ctx->s3_secret_key = malloc(ctx->s3_secret_key_len);
            if (!ctx->s3_secret_key) {
                goto cleanup;
            }
            strcpy(ctx->s3_secret_key, tmp);
        }
        if (!ctx->s3_hostname) {
            if ((tmp = getenv("S3_HOSTNAME")) == NULL) {
                PDP_ERR("S3_HOSTNAME environment variable not set");
                goto cleanup;
            }
            ctx->s3_hostname_len = strlen(tmp)+1;
            ctx->s3_hostname = malloc(ctx->s3_hostname_len);
            if (!ctx->s3_hostname) {
                goto cleanup;
            }
            strcpy(ctx->s3_hostname, tmp);
        }
        if (!ctx->s3_bucket_name) {
            if ((tmp = getenv("S3_BUCKET_NAME")) == NULL) {
                tmp = DEFUALT_BUCKET_NAME;
            }
            ctx->s3_bucket_name_len = strlen(tmp)+1;
            ctx->s3_bucket_name = malloc(ctx->s3_bucket_name_len);
            if (!ctx->s3_bucket_name) {
                goto cleanup;
            }
            strcpy(ctx->s3_bucket_name, tmp);
        }
        if (ctx->s3_hostname) {
            slen = sizeof(":443");
            if (ctx->opts & PDP_OPT_HTTPS) {
                ctx->s3_protocol = S3ProtocolHTTPS;
            } else if (ctx->s3_hostname_len < slen) {
                ctx->s3_protocol = S3ProtocolHTTP;
            } else if (strncmp(ctx->s3_hostname + ctx->s3_hostname_len - slen,
                               ":443", slen) == 0) {
                ctx->s3_protocol = S3ProtocolHTTPS;
            } else {
                ctx->s3_protocol = S3ProtocolHTTP;
            }
        }
#endif //_S3_SUPPORT
    }

    // process algo specific context data
    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_ctx_create(ctx);
            break;
        case PDP_APDP:
            err = apdp_ctx_create(ctx);
            break;
        case PDP_CPOR:
            err = cpor_ctx_create(ctx);
            break;
        case PDP_SEPDP:
            err = sepdp_ctx_create(ctx);
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        goto cleanup;
    return 0;

cleanup:
    pdp_ctx_free(ctx);
    return -1;
}


/**
 * @brief Free the ctx.
 *
 * @param[in,out] ctx   Pointer to a context structure.
 * @return 0 on success, non-zero on error
 **/
int pdp_ctx_free(pdp_ctx_t *ctx)
{
    int err = 0;
    
    if (!ctx)
        return 0;

    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_ctx_free(ctx);
            break;
        case PDP_APDP:
            err = apdp_ctx_free(ctx);
            break;
        case PDP_CPOR:
            err = cpor_ctx_free(ctx);
            break;
        case PDP_SEPDP:
            err = sepdp_ctx_free(ctx);
            break;
        default:
            err = -1;
            break;
    }
    sfree(ctx->ops, sizeof(struct pdp_ctx_ops));
    sfree(ctx->filepath, ctx->filepath_len);
    sfree(ctx->ifilepath, ctx->ifilepath_len);
    sfree(ctx->ofilepath, ctx->ofilepath_len);
#ifdef _S3_SUPPORT
    sfree(ctx->s3_access_key, ctx->s3_access_key_len);
    sfree(ctx->s3_secret_key, ctx->s3_secret_key_len);
    sfree(ctx->s3_hostname, ctx->s3_hostname_len);
    sfree(ctx->s3_bucket_name, ctx->s3_bucket_name_len);
#endif
    EVP_cleanup();
    return err;
}


/**
 * @brief Generate secret key data or public/private key pairs.
 *
 * Calls the relevant algo-specific key creation routine.
 *
 * @param[in,out] ctx   Pointer to a context structure.
 *                      Public key data is possibly output here.
 * @param[out]    key   Pointer to a key structure. 
 *                      Any secret key data is stored here (optional).
 * @param[out]    pk    Pointer to a key structure holding only public data.
 *                      Public components are stored here (optional)
 * @param[in]     path  path to key data
 * @return 0 on success, non-zero on error
 **/
int pdp_key_open(pdp_ctx_t *ctx, pdp_key_t *key, pdp_key_t *pk,
                 const char *path)
{
    int err = 0;

    if (!ctx || !path) return -1;
    if (key) memset(key, 0, sizeof(pdp_key_t));
    if (pk)  memset(pk, 0, sizeof(pdp_key_t));

    // algo specific key generation logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            /// @todo implement serialization for MAC-PDP keys
            PDP_ERR("function not supported for MAC-PDP, yet");
            err = -1;
            break;
        case PDP_APDP:
            err = apdp_key_open(ctx, key, pk, path);
            break;
        case PDP_CPOR:
            err = cpor_key_open(ctx, key, pk, path);
            break;
        case PDP_SEPDP:
            /// @todo implement serialization for SE-PDP keys
            PDP_ERR("function not supported for SE-PDP, yet");
            err = -1;
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        goto cleanup;
    return 0;

cleanup:
    if (key) memset(key, 0, sizeof(pdp_key_t));
    if (pk)  memset(pk, 0, sizeof(pdp_key_t));
    return -1;
}

/**
 * @brief Store key data to a local file.
 *
 * Calls the relevant algo-specific key creation routine.
 *
 * @param[in]     ctx   Pointer to a context structure.
 *                      Public key data is possibly output here.
 * @param[in]     key   Pointer to a key structure. 
 *                      Any generated secret key data is stored here.
 * @param[in]     path  path to store key data
 * @return 0 on success, non-zero on error
 **/
int pdp_key_store(const pdp_ctx_t *ctx, const pdp_key_t *key,
                  const char *path)
{
    int err;

    if (!ctx || !key || !path)
        return -1;

    // algo specific key generation logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            /// @todo implement serialization for MAC-PDP keys
            PDP_ERR("function not supported for MAC-PDP, yet");
            err = -1;
            break;
        case PDP_APDP:
            err = apdp_key_store(ctx, key, path);
            break;
        case PDP_CPOR:
            err = cpor_key_store(ctx, key, path);
            break;
        case PDP_SEPDP:
            /// @todo implement serialization for SE-PDP keys
            PDP_ERR("function not supported for SE-PDP, yet");
            err = -1;
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        goto cleanup;
    return 0;

cleanup:
    return -1;
}


/**
 * @brief Generate secret key data or public/private key pairs.
 *
 * Calls the relevant algo-specific key creation routine.
 *
 * @param[in,out] ctx   Pointer to a context structure.
 *                      Public key data is possibly output here.
 * @param[out]    key   Pointer to a key structure. 
 *                      Any secret key data is stored here.
 * @param[out]    pk    Pointer to a key structure holding only public data.
 *                      Public components are stored here (optional)
 * @return 0 on success, non-zero on error
 **/
int pdp_key_gen(pdp_ctx_t *ctx, pdp_key_t *key, pdp_key_t *pk)
{
    int err;

    if (!ctx || !key)
        return -1;
    memset(key, 0, sizeof(pdp_key_t));
    if (pk) memset(pk, 0, sizeof(pdp_key_t));

    // algo specific key generation logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_key_gen(ctx, key);
            break;
        case PDP_APDP:
            err = apdp_key_gen(ctx, key, pk);
            break;
        case PDP_CPOR:
            err = cpor_key_gen(ctx, key, pk);
            break;
        case PDP_SEPDP:
            err = sepdp_key_gen(ctx, key);
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        goto cleanup;
    return 0;

cleanup:
    memset(key, 0, sizeof(pdp_key_t));
    if (pk) memset(pk, 0, sizeof(pdp_key_t));
    return -1;
}


/**
 * @brief Destroy a key.
 *
 * Calls the relevant algo-specific key destruction routine.
 *
 * @return 0 on success, non-zero on error
 **/
int pdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *key)
{
    int err = 0;
    
    if (!ctx || !key)
        return -1;

    // algo specific key destruction logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_key_free(key);
            break;
        case PDP_APDP:
            err = apdp_key_free(ctx, key);
            break;
        case PDP_CPOR:
            err = cpor_key_free(ctx, key);
            break;
        case PDP_SEPDP:
            err = sepdp_key_free(ctx, key);
            break;
        default:
            err = -1;
            break;
    }
    // clean out the 'envelope'
    memset(key, 0, sizeof(pdp_key_t));
    return err;
}


/**
 * @brief Populates a tag structure.
 *
 * Checks that the local file in ctx exists, is readable, populates
 * ctx with its size, then calls the relevant algo-specific tag 
 * generation logic.
 * 
 * @param[in]     ctx   Pointer to a context structure.
 * @param[in]     key   Keys used to tag
 * @param[out]    tag   Pointer to an allocated tag structure,
 *                      to be filled with tag data.
 * @return 0 on success, non-zero on error
 **/
int pdp_tags_gen(pdp_ctx_t *ctx, pdp_key_t *key, pdp_tag_t *tag)
{
    int err = 0;
    struct stat st; 
    memset(&st, 0, sizeof(struct stat));

    if (!ctx || !key || !tag)
        return -1;
    memset(tag, 0, sizeof(pdp_tag_t));

    // check that file exists
    if (access(ctx->filepath, F_OK)) {
        PDP_ERR("cannot open %s", ctx->filepath);
        return -1;
    }
    // populate ctx with the size of the file we will tag
    if (stat(ctx->filepath, &st) < 0) {
        PDP_ERR("cannot stat %s", ctx->filepath);
        return -1;
    }
    ctx->file_st_size = st.st_size;

    // algo specific tag generation logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            // malloc space, remember to free in pdp_destroy_tags
            if ((tag->macpdp = malloc(sizeof(pdp_macpdp_tagdata_t))) == NULL)
                return -1;
            memset(tag->macpdp, 0, sizeof(pdp_macpdp_tagdata_t));
            if ((err = macpdp_tags_gen(ctx, key->macpdp, tag->macpdp)) != 0)
                sfree(tag->macpdp, sizeof(pdp_macpdp_tagdata_t));
            break;
        case PDP_APDP:
            // malloc space, remember to free in pdp_destroy_tags
            if ((tag->apdp = malloc(sizeof(pdp_apdp_tagdata_t))) == NULL)
                return -1;
            memset(tag->apdp, 0, sizeof(pdp_apdp_tagdata_t));
            if ((err = apdp_tags_gen(ctx, key->apdp, tag->apdp)) != 0)
                sfree(tag->apdp, sizeof(pdp_apdp_tagdata_t));
            break;
        case PDP_CPOR:
            // malloc space, remember to free in pdp_destroy_tags
            if ((tag->cpor = malloc(sizeof(pdp_cpor_tagdata_t))) == NULL)
                return -1;
            memset(tag->cpor, 0, sizeof(pdp_cpor_tagdata_t));
            if ((err = cpor_tags_gen(ctx, key->cpor, tag->cpor)) != 0)
                sfree(tag->cpor, sizeof(pdp_cpor_tagdata_t));
            break;
        case PDP_SEPDP:
            // malloc space, remember to free in pdp_destroy_tags
            if ((tag->sepdp = malloc(sizeof(pdp_sepdp_tagdata_t))) == NULL)
                return -1;
            memset(tag->sepdp, 0, sizeof(pdp_sepdp_tagdata_t));
            if ((err = sepdp_tags_gen(ctx, key->sepdp, tag->sepdp)) != 0)
                sfree(tag->sepdp, sizeof(pdp_sepdp_tagdata_t));
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        return -1;
    return 0;
}


/**
 * @brief Frees a tag.
 *
 * Frees the internal tag structure allocated by pdp_tags_gen().
 * Call the algo-specific tag destruction routine.
 *
 * @param[in]     ctx   Pointer to a context structure.
 * @param[in,out] tag   Pointer to a tag structure.
 * @return 0 on success, non-zero on error
 **/
int pdp_tags_free(const pdp_ctx_t *ctx, pdp_tag_t *tag)
{
    // algo specific tag generation logic
    switch(ctx->algo) {
        // we malloc in pdp_gen_tags, so we free it here
        case PDP_MACPDP:
            macpdp_tags_free(ctx, tag->macpdp);
            sfree(tag->macpdp, sizeof(pdp_macpdp_tagdata_t));
            break;
        case PDP_APDP:
            apdp_tags_free(ctx, tag->apdp);
            sfree(tag->apdp, sizeof(pdp_apdp_tagdata_t));
            break;
        case PDP_CPOR:
            cpor_tags_free(ctx, tag->cpor);
            sfree(tag->cpor, sizeof(pdp_cpor_tagdata_t));
            break;
        case PDP_SEPDP:
            sepdp_tags_free(ctx, tag->sepdp);
            sfree(tag->sepdp, sizeof(pdp_sepdp_tagdata_t));
            break;
        default:
            break;
    }
    // clear out the 'envelope'
    memset(tag, 0, sizeof(pdp_tag_t));
    return 0;
}


/**
 * @brief Prepare the file for tagging, if needed.
 *
 * Possibly applies some tranform (i.e., error correcting code)
 * to the original file (ctx->ifilepath), to prepare for tagging.
 * Writes the output to the file to tag (ctx->filepath)
 *
 * @param[in]     ctx   The PDP context.
 * @return 0 on success, non-zero on error
 **/
int pdp_file_preprocess(pdp_ctx_t *ctx)
{
    /// @todo Create logic to pre-process the file using an ECC
    return 0;
}


/**
 * @brief Store the file and tag data.
 *
 * Write file data and tag data to whichever storage back-end
 * has been set-up.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in]     key   The PDP keys.
 * @param[in]     tag   Pointer to tag data, to write.
 * @return 0 on success, non-zero on error
 **/
int pdp_store(const pdp_ctx_t *ctx, const pdp_key_t *key, const pdp_tag_t *tag)
{
    int err;
    
    if (!ctx || !tag)
        return -1;
    // algo specific storage logic
    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_store(ctx, tag->macpdp);
            break;
        case PDP_APDP:
            err = apdp_store(ctx, tag->apdp);
            break;
        case PDP_CPOR:
            err = cpor_store(ctx, key->cpor, tag->cpor);
            break;
        case PDP_SEPDP:
            err = sepdp_store(ctx, tag->sepdp);
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        return -1;
    return 0;
}


/**
 * @brief Create a challenge.
 *
 * Initializes the algo-specific challenge structure and calls
 * the relevant challenge creation routine.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in]     key   The PDP keys.
 * @param[in,out] c     The challenge structure that is populated.
 * @return 0 on success, non-zero on error
 **/
int pdp_challenge_gen(const pdp_ctx_t *ctx, pdp_key_t *key, pdp_challenge_t *c)
{
    int err;

    if (!ctx || !c)
        return -1;

    switch(ctx->algo) {
        // malloc space, remember to free in pdp_challenge_free
        case PDP_MACPDP:
            if ((c->macpdp = malloc(sizeof(pdp_macpdp_challenge_t))) == NULL)
                return -1;
            memset(c->macpdp, 0, sizeof(pdp_macpdp_challenge_t));
            if ((err = macpdp_challenge_gen(ctx, c->macpdp)) != 0)
                sfree(c->macpdp, sizeof(pdp_macpdp_challenge_t));
            break;
        case PDP_APDP:
            if ((c->apdp = malloc(sizeof(pdp_apdp_challenge_t))) == NULL)
                return -1;
            memset(c->apdp, 0, sizeof(pdp_apdp_challenge_t));
            if ((err = apdp_challenge_gen(ctx, key->apdp, c->apdp)) != 0)
                sfree(c->apdp, sizeof(pdp_apdp_challenge_t));
            break;
        case PDP_CPOR:
            if ((c->cpor = malloc(sizeof(pdp_cpor_challenge_t))) == NULL)
                return -1;
            memset(c->cpor, 0, sizeof(pdp_cpor_challenge_t));
            if ((err = cpor_challenge_gen(ctx, key->cpor, c->cpor)) != 0)
                sfree(c->cpor, sizeof(pdp_cpor_challenge_t));
            break;
        case PDP_SEPDP:
            if ((c->sepdp = malloc(sizeof(pdp_sepdp_challenge_t))) == NULL)
                return -1;
            memset(c->sepdp, 0, sizeof(pdp_sepdp_challenge_t));
            if ((err = sepdp_challenge_gen(ctx, key->sepdp, c->sepdp)) != 0)
                sfree(c->sepdp, sizeof(pdp_sepdp_challenge_t));
            break;
        default:
            err = -1;
            break;
    }
    if (err)
        return -1;
    return 0;
}


/**
 * @brief Create a challenge for the verifier, using the challenger's 
 * (i.e, verifier's) data.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in]     c     The original challenge, generated by the verifier.
 * @param[out]    pchal The challenge structure that is populated.
 * @return 0 on success, non-zero on error
 **/
int pdp_challenge_for_prover(const pdp_ctx_t *ctx, const pdp_challenge_t *c,
                             pdp_challenge_t *pchal)
{
    if (!ctx || !ctx->ops || !ctx->ops->sanitize || !c || !pchal)
        return -1;
    memset(pchal, 0, sizeof(pdp_challenge_t));
    return ctx->ops->sanitize(ctx, c, pchal);
}


/**
 * @brief Free the challenge data structure.
 *
 * Calls the relevant challenge destruction routine,
 * and clears-out the challenge 'envelope'.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in,out] c     The challenge.
 * @return 0 on success, non-zero on error
 **/
int pdp_challenge_free(const pdp_ctx_t *ctx, pdp_challenge_t *c)
{    
    if (!ctx || !c)
        return -1;

    switch(ctx->algo) {
        // we malloc in pdp_gen_challenge, so we free here
        case PDP_MACPDP:
            macpdp_challenge_free(ctx, c->macpdp);
            sfree(c->macpdp, sizeof(pdp_macpdp_challenge_t));
            break;
        case PDP_APDP:
            apdp_challenge_free(ctx, c->apdp);
            sfree(c->apdp, sizeof(pdp_apdp_challenge_t));
            break;
        case PDP_CPOR:
            cpor_challenge_free(ctx, c->cpor);
            sfree(c->cpor, sizeof(pdp_cpor_challenge_t));
            break;
        case PDP_SEPDP:
            sepdp_challenge_free(ctx, c->sepdp);
            sfree(c->sepdp, sizeof(pdp_sepdp_challenge_t));
            break;
        default:
            break;
    }
    // clear out the 'envelope'
    memset(c, 0, sizeof(pdp_challenge_t));
    return 0;
}


/**
 * @brief Generates a proof, associated with a challenge.
 *
 * Calls the relevant algo proof routine.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in]     key   The keys used by the verifier (if any)
 * @param[in]     c     The challenge.
 * @param[out]    p     Pointer to a proof structure that will be
 *                      populated with proof data.
 * @return 0 on success, non-zero on error
 **/
int pdp_proof_gen(const pdp_ctx_t *ctx, const pdp_key_t *key,
                  const pdp_challenge_t *c, pdp_proof_t *p)
{
    int err = 0;

    if (!ctx || !c || !p)
        return -1;

    switch(ctx->algo) {
        // malloc space, remember to free in pdp_proof_free
        case PDP_MACPDP:
            if ((p->macpdp = malloc(sizeof(pdp_macpdp_proof_t))) == NULL)
                return -1;
            memset(p->macpdp, 0, sizeof(pdp_macpdp_proof_t));
            err = macpdp_proof_gen(ctx, c->macpdp, p->macpdp);
            break;
        case PDP_APDP:
            if ((p->apdp = malloc(sizeof(pdp_apdp_proof_t))) == NULL)
                return -1;
            memset(p->apdp, 0, sizeof(pdp_apdp_proof_t));
            err = apdp_proof_gen(ctx, key->apdp, c->apdp, p->apdp);
            break;
        case PDP_CPOR:
            if ((p->cpor = malloc(sizeof(pdp_cpor_proof_t))) == NULL)
                return -1;
            memset(p->cpor, 0, sizeof(pdp_cpor_proof_t));
            err = cpor_proof_gen(ctx, key->cpor, c->cpor, p->cpor);
            break;
        case PDP_SEPDP:
            if ((p->sepdp = malloc(sizeof(pdp_sepdp_proof_t))) == NULL)
                return -1;
            memset(p->sepdp, 0, sizeof(pdp_sepdp_proof_t));
            err = sepdp_proof_gen(ctx, key->sepdp, c->sepdp, p->sepdp);
            break;
        default:
            err = -1;
            break;
    }
    return err;
}


/**
 * @brief Verifies the proof relative to the challenge.
 *
 * Calls the relevant algo proof free routine.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in]     key   The keys used to verify.
 * @param[in]     c     The challenge held by the verifier.
 * @param[in]     p     The proof returned by prover.
 * @return 0 if the proof is verified
 * @return 1 if the proof is not verified
 * @return -1 on error
 **/
int pdp_proof_verify(const pdp_ctx_t *ctx, const pdp_key_t *key,
                     const pdp_challenge_t *c, const pdp_proof_t *p)
{
    int err = 0;

    if (!ctx || !key || !p)
        return -1;

    switch(ctx->algo) {
        case PDP_MACPDP:
            err = macpdp_proof_verify(ctx, key->macpdp, c->macpdp, p->macpdp);
            break;
        case PDP_APDP:
            err = apdp_proof_verify(ctx, key->apdp, c->apdp, p->apdp);
            break;
        case PDP_CPOR:
            err = cpor_proof_verify(ctx, key->cpor, c->cpor, p->cpor);
            break;
        case PDP_SEPDP:
            err = sepdp_proof_verify(ctx, key->sepdp, c->sepdp, p->sepdp);
            break;
        default:
            err = -1;
            break;
    }
    return err;
}


/**
 * @brief Frees the internal data structures of a proof.
 *
 * Simply calls the relevant algo proof free routine.
 *
 * @param[in]     ctx   The PDP context.
 * @param[in,out] proof Pointer to a proof structure.
 * @return 0 on success, non-zero on error
 **/
int pdp_proof_free(const pdp_ctx_t *ctx, pdp_proof_t *proof)
{
    int err = 0;

    if (!ctx || !proof)
        return -1;

    switch(ctx->algo) {
        // we malloc in pdp_proof_gen, so we free here
        case PDP_MACPDP:
            err = macpdp_proof_free(ctx, proof->macpdp);
            sfree(proof->macpdp, sizeof(pdp_macpdp_proof_t));
            break;
        case PDP_APDP:
            err = apdp_proof_free(ctx, proof->apdp);
            sfree(proof->apdp, sizeof(pdp_apdp_proof_t));
            break;
        case PDP_CPOR:
            err = cpor_proof_free(ctx, proof->cpor);
            sfree(proof->cpor, sizeof(pdp_cpor_proof_t));
            break;
        case PDP_SEPDP:
            err = sepdp_proof_free(ctx, proof->sepdp);
            sfree(proof->sepdp, sizeof(pdp_cpor_proof_t));
            break;
        default:
            err = -1;
            break;
    }
    return err;
}

/** @} */
