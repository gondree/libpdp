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
/** @addtogroup CPOR
 * @{ 
 */
#ifndef __CPOR_PDP_TYPES_H__
#define __CPOR_PDP_TYPES_H__

/// Holds parameter data for CPOR
typedef struct {
    unsigned int block_size;    ///< block size (bytes)
    unsigned int sector_size;   ///< sector size (bytes)
    unsigned int num_sectors;   ///< number of sectors per block
    unsigned int num_blocks;    ///< total number of blocks in file
    unsigned int num_challenge_blocks;  ///< num of blocks to challenge
    unsigned int lambda;        ///< security parameter
    unsigned int Zp_bits;       ///< size (in bits) of the prime for Z_p
    size_t prf_key_size;        ///< size of key (bytes)
    size_t enc_key_size;        ///< size of ENC key (bytes)
    size_t mac_key_size;        ///< size of MAC key (bytes)
} pdp_cpor_ctx_t;


/// Holds key data for CPOR
typedef struct {
    unsigned char *k_enc;   ///< The user's secret encryption key
    size_t k_enc_size;      ///< Encryption size in bytes
    unsigned char *k_mac;   ///< The user's secret MAC key
    size_t k_mac_size;      ///< MAC key size in bytes
    BIGNUM *Zp;             ///< The prime p that defines the field Zp
} pdp_cpor_key_t;


/// Holds data for a single tag
typedef struct {
    unsigned int index;     ///< The index for the authenticator, i
    BIGNUM *sigma;          ///< The resulting authenticator, sigma_i
} pdp_cpor_tag_t;


/// Holds tag data for CPOR
typedef struct {
    unsigned char *k_prf;   ///< The randomly generated PRF key for the file
    pdp_cpor_tag_t **tags;  ///< Array of tags
    size_t tags_num;        ///< Number of elements in the array
    size_t tags_size;       ///< Size of array
    BIGNUM **alpha;         ///< Array of per-file, per-sector secrets
    size_t alpha_size;      ///< Size of alpha
} pdp_cpor_tagdata_t;


/// Holds challenge data for CPOR
typedef struct {
    unsigned int ell;       ///< The number of elements to be tested
    unsigned int *I;        ///< An array of ell indicies to be tested
    unsigned int I_size;    ///< Size of array, I
    unsigned int nu_size;   ///< Size of array, nu
    BIGNUM **nu;            ///< An array of ell random elements
} pdp_cpor_challenge_t;


/// Holds proof data for CPOR
typedef struct {
    BIGNUM *sigma;
    BIGNUM **mu;
    unsigned int mu_size;   ///< Size of array, mu
} pdp_cpor_proof_t;


#endif
/** @} */
