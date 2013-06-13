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
/** @addtogroup MACPDP
 * @{ 
 */
#ifndef __MAC_PDP_TYPES_H__
#define __MAC_PDP_TYPES_H__

/// Holds parameter data for MAC-PDP
typedef struct {
    unsigned int block_size;            ///< block size (bytes)
    unsigned int num_blocks;            ///< total number of blocks in file
    unsigned int num_challenge_blocks;  ///< num of blocks to challenge
    unsigned int tag_size;              ///< size of an individual tag (bytes)
    size_t prf_key_size;                ///< size of key (bytes)
} pdp_macpdp_ctx_t;


/// Holds key data for MAC-PDP
typedef struct {
    unsigned char *prf_key;
    size_t prf_key_size;
} pdp_macpdp_key_t;


/// Holds tag data for MAC-PDP
typedef struct {
    unsigned char *tags;
    size_t tags_size;
} pdp_macpdp_tagdata_t;


/// Holds challenge data for MAC-PDP
typedef struct {
    unsigned int ell;   ///< ell, the number of elements to be tested
    unsigned int *I;    ///< an array of ell indicies (the blocks to test)
} pdp_macpdp_challenge_t;


/// Holds proof data for MAC-PDP
typedef struct {
    unsigned char *B;   ///< array of ell blocks
    unsigned char *T;   ///< array of ell tags
    unsigned int ell;   ///< ell, the number of elements to be tested
} pdp_macpdp_proof_t;


#endif
/** @} */
