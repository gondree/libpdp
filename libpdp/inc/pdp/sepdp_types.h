/**
 * @file
 * Type interfaces for the MAC-PDP module for libpdp.
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
#ifndef __SEPDP_TYPES_H__
#define __SEPDP_TYPES_H__

/// Holds parameter data for SEPDP
typedef struct {
    unsigned int block_size;            ///< block size (bytes)
    unsigned int num_blocks;            ///< total number of blocks in file
    unsigned int year;                  ///< period for audit material (years)
    unsigned int min;                   ///< audit regularity (minutes)
    size_t prf_key_size;                ///< size of key (bytes)
    size_t prp_key_size;                ///< size of key (bytes)
    size_t ae_key_size;                 ///< size of key (bytes)
    unsigned int num_challenge_blocks;  ///< num of blocks to challenge
    unsigned int num_chal_created;      ///< total number of challenged created
    unsigned int num_chal_used;         ///< total number of challenges made
} pdp_sepdp_ctx_t;


/// Holds key data for SEPDP
typedef struct {
    unsigned char *W;
    size_t W_size;
    unsigned char *Z;
    size_t Z_size;
    unsigned char *K;
    size_t K_size;
} pdp_sepdp_key_t;


/// Holds data for a single token
typedef struct {
    size_t index;               ///< index for token
    size_t iv_size;             ///< length of the IV
    unsigned char *iv;          ///< the IV used for the AE-scheme
    size_t tok_size;            ///< length of the token
    unsigned char *tok;         ///< the token
    size_t mac_size;            ///< length of the mac
    unsigned char *mac;         ///< the mac of the token
} pdp_sepdp_tag_t;


/// Holds tag data for MAC-PDP
typedef struct {
    pdp_sepdp_tag_t **tokens;
    size_t tokens_num;
    size_t tokens_size;
} pdp_sepdp_tagdata_t;


/// Holds challenge data for MAC-PDP
typedef struct {
    unsigned int i;
    unsigned char *ki;
    size_t ki_size;
    unsigned char *ci;
    size_t ci_size;
} pdp_sepdp_challenge_t;


/// Holds proof data for MAC-PDP
typedef struct {
    size_t z_size;
    unsigned char *z;
    size_t iv_size;
    unsigned char *iv;
    size_t tok_size;
    unsigned char *tok;
    size_t mac_size;
    unsigned char *mac;
} pdp_sepdp_proof_t;


#endif
/** @} */
