/**
 * @file
 * Types and structs for libpdp
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @date 2008-2013
 * @copyright BSD 2-Clause License
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
#ifndef __PDP_TYPES_H__
#define __PDP_TYPES_H__

#include <pdp/macpdp_types.h>
#include <pdp/apdp_types.h>
#include <pdp/cpor_types.h>
#include <pdp/sepdp_types.h>

/// Context for the use of a PDP algorithm.
typedef struct {
    unsigned short algo;        ///< pdp algorithms being used
    unsigned short opts;        ///< options
    unsigned short verbose;     ///< print more messages to stdout
    unsigned int num_threads;   ///< number of threads, if threading is used

    char *ifilepath;            ///< path to file that contains input data
    size_t ifilepath_len;       ///< ifilepath length

    char *filepath;             ///< path to file that will be tagged
    size_t filepath_len;        ///< filepath length
    off_t file_st_size;         ///< size of file to tag (in bytes)

    char *ofilepath;            ///< output file, to store data
    size_t ofilepath_len;       ///< ofilepath length

#ifdef _S3_SUPPORT
    char *s3_access_key;
    size_t s3_access_key_len;    

    char *s3_secret_key;
    size_t s3_secret_key_len;

    char *s3_hostname;
    size_t s3_hostname_len;

    char *s3_bucket_name;
    size_t s3_bucket_name_len;
#endif

    /// algorithm-specific params
    union {
        pdp_macpdp_ctx_t *__macpdp;
        pdp_apdp_ctx_t *__apdp;
        pdp_cpor_ctx_t *__cpor;
        pdp_sepdp_ctx_t *__sepdp;
    } __pdp_ctx_param_u;

    struct pdp_ctx_ops *ops;
} pdp_ctx_t;


/// Macro magic to access ctx->macpdp_param->x correctly
#define macpdp_param __pdp_ctx_param_u.__macpdp
/// Macro magic to access ctx->apdp_param->x correctly
#define apdp_param   __pdp_ctx_param_u.__apdp
/// Macro magic to access ctx->cpor_param->x correctly
#define cpor_param   __pdp_ctx_param_u.__cpor
/// Macro magic to access ctx->sepdp_param->x correctly
#define sepdp_param  __pdp_ctx_param_u.__sepdp

/// Holds secret data for PDP algorithms.
typedef union {
    pdp_macpdp_key_t *macpdp;
    pdp_apdp_key_t *apdp;
    pdp_cpor_key_t *cpor;
    pdp_sepdp_key_t *sepdp;
} pdp_key_t;

/// Holds tag data for PDP algorithms.
typedef union {
    pdp_macpdp_tagdata_t *macpdp;
    pdp_apdp_tagdata_t *apdp;
    pdp_cpor_tagdata_t *cpor;
    pdp_sepdp_tagdata_t *sepdp;
} pdp_tag_t;

/// Holds challenge data for PDP algorithms.
typedef union {
    pdp_macpdp_challenge_t *macpdp;
    pdp_apdp_challenge_t *apdp;
    pdp_cpor_challenge_t *cpor;
    pdp_sepdp_challenge_t *sepdp;
} pdp_challenge_t;

/// Holds proof data for PDP algorithms.
typedef union {
    pdp_macpdp_proof_t *macpdp;
    pdp_apdp_proof_t *apdp;
    pdp_cpor_proof_t *cpor;
    pdp_sepdp_proof_t *sepdp;
} pdp_proof_t;

/// struct to store pointers to stateful retrieval operations
struct pdp_ctx_ops {
    int (*get_tag)(const pdp_ctx_t*, unsigned int, void *, unsigned int*);
    int (*get_block)(const pdp_ctx_t*, unsigned int, void *, unsigned int*);
    int (*sanitize)(const pdp_ctx_t*, const pdp_challenge_t*, pdp_challenge_t*);
};

#endif
