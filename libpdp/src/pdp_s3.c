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
/** @addtogroup STORAGE
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <libgen.h>
#ifdef _S3_SUPPORT
#include <libs3.h>
#endif
#include <pdp.h>
#include "pdp_misc.h"
#include "pdp_storage.h"

#ifdef _S3_SUPPORT
// ------------------------ internal functions for S3 support -----------------

static unsigned int s3_initialized = 0;  ///< ensures we init once

struct buffer_pointer {
    unsigned char *buf;
    int offset;
    size_t len;
};

static int putObjectFileCallback(int bufferSize, char *buffer, 
                                 void *callbackData)
{
    return fread(buffer, 1, bufferSize, callbackData);  
}


static int putObjectDataCallback(int bufferSize, char *buffer, 
                                 void *callbackData)
{
    struct buffer_pointer *bp = callbackData;
    unsigned int len = (bp->len < bufferSize) ? bp->len : bufferSize;

    memcpy((char *)buffer, (char *)bp->buf, len);
    bp->buf += len;
    bp->len -= len;
    return len; 
}


/*
static S3Status getObjectFileCallback(int bufferSize, const char *buffer, 
                                          void *callbackData)
{
    FILE *outfile = (FILE *) callbackData;
    size_t wrote = fwrite(buffer, 1, bufferSize, outfile);
    return ((wrote < (size_t) bufferSize) ? S3StatusAbortedByCallback : 
                                            S3StatusOK);
}
*/

static S3Status getObjectDataCallback(int bufferSize, const char *buffer, 
                                      void *callbackData)
{
    struct buffer_pointer *bp = callbackData;
    unsigned int len = (bp->len < bufferSize) ? bp->len : bufferSize;

    memcpy((char *)bp->buf + bp->offset, (char *)buffer, len);
    bp->offset += len;
    bp->len -= len;
    return ((bp->len <= 0) ? S3StatusAbortedByCallback : S3StatusOK);
}


static S3Status responsePropertiesCallback(
            const S3ResponseProperties *properties, void *callbackData)
{
    return S3StatusOK;
}


static void responseCompleteCallback(S3Status status, 
            const S3ErrorDetails *error, void *callbackData)
{
    return;
}


static S3Status responseSizeCallback(const S3ResponseProperties *properties,
                                     void *callbackData)
{         
    *(size_t*)callbackData = (size_t)properties->contentLength;
    return S3StatusOK; 
}

// ------------------------ internal functions for S3 support -----------------
#endif // _S3_SUPPORT


/**
 * @brief Writes data to an S3 bucket.
 *
 * @param[in] ctx         pointer to a PDP context
 * @param[in] data        buffer holding data to write
 * @param[in] data_len    number of bytes of data in the buffer
 * @param[in] filepath    the name of the file to associate with the data
 * @return 0 on success, non-zero on error
 **/
int pdp_write_data_to_s3(const pdp_ctx_t *ctx, const char* filepath,
                         unsigned char *data, size_t data_len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    struct buffer_pointer bp;
    S3Status status = S3StatusErrorUnknown;

    if (!filepath || (strlen(filepath) >= MAXPATHLEN))
        return -1;

    bp.buf = data;
    bp.len = data_len;
    
    // initialize the S3 library
    if (!s3_initialized) {
        status = S3_initialize("s3", S3_INIT_ALL, ctx->s3_hostname);
        if (status != S3StatusOK) {
            PDP_ERR("failed to initialize libs3: %s", S3_get_status_name(status));
            goto cleanup;
        }
        s3_initialized = 1;
        atexit(S3_deinitialize);
    }
    // set the S3 context
    S3BucketContext bucketContext = {
        0,
        ctx->s3_bucket_name,
        S3ProtocolHTTP,
        S3UriStylePath,
        ctx->s3_access_key,
        ctx->s3_secret_key
    };
    
    // set the object properties
    S3PutProperties putProperties = {
        0,          // content-type defaults to "binary/octet-stream"
        0,          // md5 sum, not required
        0,          // cacheControl, not required
        0,          // contentDispositionFilename, This is only relevent for 
                    //  objects which are intended to be shared to users via 
                    //  web browsers and which is additionally intended to be
                    //  downloaded rather than viewed.
        0,          // contentEncoding, This is only applicable to encoded 
                    //  (usually, compressed) content, and only relevent if 
                    //  the object is intended to be downloaded via a browser.
        (int64_t)-1,// expires, This information is typically only delivered 
                    //  to users who download the content via a web browser.
        S3CannedAclPrivate,
        0,          // metaPropertiesCount, This is the number of values 
                    //  in the metaData field.
        0           // metaProperties
    };

    // set the callbacks
    S3PutObjectHandler putObjectHandler = {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &putObjectDataCallback
    };
    
    S3_put_object(&bucketContext, basename((char *)filepath), data_len,
                  &putProperties, 0, &putObjectHandler, &bp);
    return 0;

cleanup:
    return -1;
#endif
}


/**
 * @brief Writes a file to an S3 bucket.
 *
 * @param[in] ctx           pointer to a PDP context
 * @param[in] filepath      path to file holding the data to write
 * @return 0 on success, non-zero on error
 **/
int pdp_write_file_to_s3(const pdp_ctx_t *ctx, const char* filepath)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    FILE *file = NULL;
    struct stat statbuf;
    S3Status status = S3StatusErrorUnknown;
    
    if (!filepath || (strlen(filepath) >= MAXPATHLEN))
        return -1;

    // get the file size
    if (stat(filepath, &statbuf) == -1) {
        PDP_ERR("failed to stat file %s: ", filepath);
        goto cleanup;
    }
   
    if ((file = fopen(filepath, "r")) == NULL) {
        PDP_ERR("Couldn't open file %s", filepath);
        goto cleanup;
    }
    
    // initialize the S3 library
    if (!s3_initialized) {
        status = S3_initialize("s3", S3_INIT_ALL, ctx->s3_hostname);
        if (status != S3StatusOK) {
            PDP_ERR("failed to initialize libs3: %s", S3_get_status_name(status));
            goto cleanup;
        }
        s3_initialized = 1;
        atexit(S3_deinitialize);
    }
    
    // set the S3 context
    S3BucketContext bucketContext = {
        0,
        ctx->s3_bucket_name,
        S3ProtocolHTTP,
        S3UriStylePath,
        ctx->s3_access_key,
        ctx->s3_secret_key
    };
    
    // set the object properties
    S3PutProperties putProperties = {
        0,          // content-type defaults to "binary/octet-stream"
        0,          // md5 sum, not required
        0,          // cacheControl, not required
        0,          // contentDispositionFilename, This is only relevent for 
                    //  objects which are intended to be shared to users via 
                    //  web browsers and which is additionally intended to be
                    //  downloaded rather than viewed.
        0,          // contentEncoding, This is only applicable to encoded 
                    //  (usually, compressed) content, and only relevent if 
                    //  the object is intended to be downloaded via a browser.
        (int64_t)-1,// expires, This information is typically only delivered 
                    //  to users who download the content via a web browser.
        S3CannedAclPrivate,
        0,          // metaPropertiesCount, This is the number of values 
                    //  in the metaData field.
        0           // metaProperties
    };

    // set the callbacks
    S3PutObjectHandler putObjectHandler = {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &putObjectFileCallback
    };
    
    S3_put_object(&bucketContext, basename((char *)filepath), statbuf.st_size,
                  &putProperties, 0, &putObjectHandler, file);
    
    if (file)
        fclose(file);
    return 0;

cleanup:
    if (file)
        fclose(file);
    return -1;
#endif
}


/** 
 * @brief Gets a file from an S3 bucket.
 *
 * @note The caller must free the returned buffer, manually.
 *
 * @param[in]      ctx       pointer to a PDP context
 * @param[in]      filepath  file id associated with the bucket's data
 * @param[out]     buf       pointer to buffer filled with output data
 * @param[out]     buf_len   size of buffer returned
 * @return 0 on success, non-zero on error
 **/

int pdp_get_file_from_s3(const pdp_ctx_t *ctx, const char *filepath,
                         unsigned char **buf, size_t *buf_len)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    int err;
    size_t len = 0;
    unsigned char *data = NULL;
    
    err = pdp_get_chunk_from_s3(ctx, filepath, &data, &len, 0);
    if (!err) {
        *buf = data;
        *buf_len = len;
    }
    return err;
#endif
}


/** 
 * @brief Gets a chunk of data from an S3 bucket.
 *
 * Gets a chunk from S3, and writes it to the buffer pointed to by 'buf'. 
 * If *buf is NULL and *buf_len is 0, then the entire file 
 * will be retrieved into a newly allocated buffer, and 'buf' will
 * point to that location. 
 *
 * This keeps state using static variables and resources are
 * freed then when function is called with NULL inputs.
 *
 * @note The caller must free the returned buffer, manually.
 *
 * @param[in]      ctx       pointer to a PDP context
 * @param[in]      filepath  file id associated with the bucket's data
 * @param[in,out]  buf       pointer to buffer for output data
 * @param[in,out]  buf_len   size of buffer
 * @param[in]      index     index to begin reading byte data
 * @return 0 on success, non-zero on error
 **/
int pdp_get_chunk_from_s3(const pdp_ctx_t *ctx, const char *filepath,
                          unsigned char **buf, size_t *buf_len, 
                          unsigned int index)
{
#ifndef _S3_SUPPORT
    PDP_UNSUPPORTED("S3");
    return -1;
#else
    struct buffer_pointer bp;
    unsigned char *chunk = NULL;
    S3Status status = S3StatusErrorUnknown;
    int chunk_alloc = 0;

    if (!filepath || (strlen(filepath) >= MAXPATHLEN) || !buf || !buf_len)
        return -1;

    chunk = *buf;

    // initialize the S3 library
    if (!s3_initialized) {
        status = S3_initialize("s3", S3_INIT_ALL, ctx->s3_hostname);
        if (status != S3StatusOK) {
            PDP_ERR("failed to initialize libs3: %s", S3_get_status_name(status));
            goto cleanup;
        }
        s3_initialized = 1;
        atexit(S3_deinitialize);
    }

    // set the S3 context
    S3BucketContext bucketContext = {
        0,
        ctx->s3_bucket_name,
        S3ProtocolHTTP,
        S3UriStylePath,
        ctx->s3_access_key,
        ctx->s3_secret_key
    };

    S3GetConditions getConditions = {
        -1,     // ifModifiedSince,
        -1,     // ifNotModifiedSince,
        0,      // ifMatch,
        0       // ifNotMatch
    };

    if ((chunk == NULL) && (*buf_len == 0) && (index == 0)) {
        S3ResponseHandler sizeHandler = {
            &responseSizeCallback, 
            &responseCompleteCallback
        };

        S3_head_object(&bucketContext, basename((char*)filepath), 0, 
                       &sizeHandler, (void*) buf_len);

        if ((chunk = malloc(*buf_len)) == NULL)
            goto cleanup;
        chunk_alloc = 1;
    }
    memset(chunk, 0, *buf_len);
    bp.buf = chunk;
    bp.offset = 0;
    bp.len = *buf_len;

    S3GetObjectHandler getObjectHandler = {
        { &responsePropertiesCallback, &responseCompleteCallback },
        &getObjectDataCallback
    };

    S3_get_object(&bucketContext, basename((char*)filepath), &getConditions,
                  index, *buf_len, 0, &getObjectHandler, &bp);
    *buf = bp.buf;
    return 0;
    
cleanup:
    if (chunk_alloc)
        free(chunk);
    return -1;
#endif
}

/** @} */
