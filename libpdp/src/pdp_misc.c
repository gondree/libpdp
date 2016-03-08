/**
 * @file
 * Support routines for PDP.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup MISC
 * @{ 
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <openssl/bn.h>
#include <openssl/hmac.h>
#include <openssl/rand.h>
#include <openssl/rsa.h>
#include <openssl/sha.h>
#include <openssl/aes.h>
#include <pdp.h>
#include "pdp_misc.h"


#ifdef _PDP_DEBUG
void pdp_hexdump(const char* msg, unsigned int index, 
                 const unsigned char *buf, size_t len)
{
    int j, k = 16;
    DEBUG(1, "\n\t%10s [%02d] ", msg, index);
    for (j=0; j<len; j++) {
        if ((j>0)&&((j%k)==0)) DEBUG(1, "\n\t%16s", " ");
        DEBUG(1, " 0x%02x ", (unsigned int) buf[j]);
    }
}
#endif // _PDP_DEBUG


/**
 * @brief Checks to see if the i-th bit is set in bit-vector bv.
 * @param[in] bv     pointer to an array of char
 * @param[in] i      the number of the bit to check
 * @return 0 on if not set, 1 if set
 **/
static inline unsigned char check_bit(unsigned char *bv, unsigned int i)
{
    return (bv[i / (sizeof(unsigned char)*8)] & (1 << (i % 8)));
}


/**
 * @brief Sets the i-th bit in bit-vector bv.
 * @param[in,out] bv     pointer to an array of char
 * @param[in]     i      the number of the bit to set
 * @return 0 on if not set, 1 if set
 **/
static inline void set_bit(unsigned char *bv, unsigned int i) 
{
    bv[i / (sizeof(unsigned char)*8)] |= (1 << (i % 8));
}


/**
 * @brief Fight evil by converting to a positive power of 2. 
 * If x is already a power of 2, x is returned unchanged. 
 **/
unsigned int next_pow_2(int x)
{
    if (x < 0)
        x = -1*x;
    // convert all bits after the first "1" to ones
    x--;
    x = (x >> 1) | x;
    x = (x >> 2) | x;
    x = (x >> 4) | x;
    x = (x >> 8) | x;
    x = (x >> 16) | x;
    x++; 
    // zero is not a power of 2, and we won't return 1
    return (x == 0) ? 2 : x;
}


/**
 * @brief Returns the largest power of two less than x.
 **/
unsigned int prev_pow_2(unsigned int x)
{
    register int count = -1;
    while(x != 0) {
        x = (x >> 1);
        count++;
    }
    return (1 << count);
}


/**
 * @brief Uses AES as a PRP to generating a random value in some range.
 *
 * On input z, finds x >= z s.t. PRP(Ki, x) = y and y < upper_bound.
 * If upper_bound is not a power of two, we use the largest power of two < y
 * as the bound.
 *
 * @param[in]     upper_bound    the output y will be in the range [0, y]
 * @param[in]     ki             pointer to AES key, Ki
 * @param[in]     prp_key_size   size of Ki
 * @param[in,out] keyidx         initally z, later the value x
 * @param[out]    out            the output value y
 * @return 0 on success, non-zero on error
 **/
static int rand_range_AES(unsigned int upper_bound, const unsigned char *ki,
        unsigned int prp_key_size, unsigned int *keyidx, unsigned int *out)
{
    unsigned char *prp_result = NULL;
    unsigned char *prp_input = NULL;
    unsigned int max, r;
    AES_KEY aes_key;
    int status = -1;

    // Max mod is the next power of two, 
    // any r s.t. upper_bound <= r < max is biased
    max = prev_pow_2(upper_bound) << 1;
    r = 0;

    // Allocate memory
    if ((prp_result = calloc(1, prp_key_size)) == NULL) goto cleanup;
    if ((prp_input = calloc(1, prp_key_size)) == NULL) goto cleanup;
    memset(&aes_key, 0, sizeof(AES_KEY));

    // Setup the AES key
    if (AES_set_encrypt_key(ki, 128, &aes_key)) goto cleanup;

    // This could theoretically loop forever but each retry has
    // p > 0.5 (worst case) of selecting a number inside the range we need, 
    // so it should rarely need to re-roll.
    //  
    do {
        // Setup in the input buffer
        memcpy(prp_input, keyidx, sizeof(int));

        // Perform AES on the index
        AES_encrypt(prp_input, prp_result, &aes_key);

        // Turn the PRP result into a number
        memcpy(&r, prp_result, sizeof(unsigned int));

        r %= max;
        (*keyidx)++;
    } while(r >= upper_bound);

    *out = r;
    status = 0;

cleanup:
    sfree(prp_result, prp_key_size);
    sfree(prp_input, prp_key_size);
    memset(&aes_key, 0, sizeof(AES_KEY));
    return status;
}



/**
 * @brief Sampling without replacement (Floyd's algorithm).
 *
 * @param[in]      samp_sz   Number to points to sample from set A.
 * @param[in]      pop_sz    The set A is defined as [0, pop_sz-1].
 * @param[out]     S         An array large enough to store
 *                           the samp_sz elements selected from A.
 * @return 0 on success, non-zero on error
 **/
int sample_sans_replacement(unsigned int samp_sz, unsigned int pop_sz, 
        unsigned int S[])
{
    unsigned char* ki = NULL;
    unsigned int ki_size = 16; // 16 bytes == 128 bits
    int err = -1;
    
    if ((ki = malloc(ki_size)) == NULL) goto cleanup;
    if (!RAND_bytes(ki, ki_size)) goto cleanup;
    err = sample_prp_sans_replacement(ki, ki_size, samp_sz, pop_sz, S);

cleanup:
    sfree(ki, ki_size);
    return err;
}


/**
 * @brief Sampling using a PRP, without replacement (Floyd's algorithm).
 *
 * Uniformly samples samp_sz elements from the set A of unsigned ints,
 * where A = [0, pop_sz-1], and stored the result in S, following
 * Floyd's algorithm (J. Bentley and R. Floyd. Programming pearls - a 
 * sample of brilliance. Comm. of ACM, pp. 754--757, 1987.)
 *
 * @code
 * initialize set S to empty
 *   for J := N-M + 1 to N do
 *       T := RandInt(1, J)
 *       if T is not in S then
 *           insert T in S
 *       else
 *           insert J in S
 * @endcode
 *
 * @param[in]      ki        Key used for PRP
 * @param[in]      ki_size   Size of ki
 * @param[in]      samp_sz   Number to points to sample from set A.
 * @param[in]      pop_sz    The set A is defined as [0, pop_sz-1].
 * @param[out]     S         An array large enough to store
 *                           the samp_sz elements selected from A.
 * @return 0 on success, non-zero on error
 **/
int sample_prp_sans_replacement(const unsigned char *ki, unsigned int ki_size, 
        unsigned int samp_sz, unsigned int pop_sz, unsigned int S[])
{
    unsigned int N, M, V, i, j, keyidx;
    unsigned char* hist = NULL;
    unsigned int hist_size;
    int status = -1;

    N = pop_sz;
    M = samp_sz;
    V = 0;
    keyidx = 0;
    
    // a list of bits indicating set membership
    hist_size = pop_sz / (sizeof(unsigned char)*8);
    if (pop_sz % (sizeof(unsigned char)*8))
        hist_size++;
    hist = calloc(1, hist_size);
        
    if (hist == NULL) goto cleanup;

    // a little speed up: sample everything, when appropriate
    if (N == M) {
        for (i = 0; i < M; i++) S[i] = i;
        status = 0;
        goto cleanup;
    } else if (N < M) {
        status = -1;
        goto cleanup;
    }

    for(j = 0, i = N - M; i < N; j++, i++) {
        if (rand_range_AES(i+1, ki, ki_size, &keyidx, &V))
            goto cleanup;
        if (check_bit(hist, V)) {
            S[j] = i;
            set_bit(hist, i);
        } else {
            S[j] = V;
            set_bit(hist, V);
        }
    }
    status = 0;

cleanup:
    sfree(hist, hist_size);
    return status;
}


/**
 * @brief The implementation of the full-domain hash fuction h().  
 *
 * This implementation of an FDH function takes an input and its size and an
 * RSA modulus associated with a key.  It concatenates a counter to the 
 * input and performs a SHA1 hash.  The result is appended to the final 
 * output. This process is repeated until the result is the size of the RSA 
 * modulus and the value is less than the RSA modulus.
 *
 * @param[in] key    RSA key
 * @param[in] input  input to FDH
 * @param[in] len    size of input in bytes
 * @return BIGNUM representation of the value, or NULL on failure.
 **/
BIGNUM *gen_fdh(const RSA *key, const unsigned char *input, size_t len)
{
    unsigned int num_hashes, i, counter;
    size_t n_len = 0;
    size_t sha1_input_len = len + sizeof(unsigned int);
    unsigned char *sha1_input = NULL;
    unsigned char *fdh = NULL;
    BIGNUM *fdh_bn = NULL;
    int err = -1;

    if (!key || !key->n || !input || !len)
        return NULL;
    
    // Get the size of the RSA modulus in bytes
    n_len = BN_num_bytes(key->n);
    
    // Calculate the number of hashes to perform minus one
    num_hashes = n_len/SHA_DIGEST_LENGTH;
    
    // Allocate memory
    if ((sha1_input = malloc(sha1_input_len)) == NULL) goto cleanup;
    if ((fdh_bn = BN_new()) == NULL) goto cleanup;
    if ((fdh = malloc((num_hashes+1) * SHA_DIGEST_LENGTH)) == NULL)
        goto cleanup;
    memset(fdh, 0, n_len);
    
    // Fill all but the most significant bits of the fdh hash
    counter = 0;
    for(i = num_hashes, counter = 0; i > 0; i--){
        // Hash the output of the PRF appended with a counter
        memset(sha1_input, 0, sha1_input_len);
        memcpy(sha1_input, &counter, sizeof(unsigned int));
        memcpy(sha1_input + sizeof(unsigned int), input, len);
        SHA1(sha1_input, sha1_input_len, (fdh + (i*SHA_DIGEST_LENGTH)));
        counter++;
    }
    // Hash the most significant bits and re-hash until the 
    // FDH is smaller than the RSA modulus, N
    do {
        memset(sha1_input, 0, sha1_input_len);
        memcpy(sha1_input, &counter, sizeof(unsigned int));
        memcpy(sha1_input + sizeof(unsigned int), input, len);
        if (!SHA1(sha1_input, sha1_input_len, fdh)) goto cleanup;
        // Turn the first sizeof(rsa->n) bytes into a big number
        if (!BN_bin2bn(fdh, n_len, fdh_bn)) goto cleanup;
        counter++;
    } while (BN_ucmp(fdh_bn, key->n) > 0);
    err = 0;

cleanup:
    sfree(sha1_input, sha1_input_len);
    sfree(fdh, n_len);
    if (err && fdh_bn) BN_clear_free(fdh_bn);
    if (err) return NULL;
    return fdh_bn;
}


/**
 * @brief The implementation of a hash fuction H().  
 *
 * Basically, a pass-through to SHA1.
 *
 * @param[in]     input    a BIGNUM
 * @param[in,out] len      length of output
 * @return an allocated buffer holding the output, or NULL on failure.
 **/
unsigned char *gen_bn_H(const BIGNUM *input, size_t *len)
{
    unsigned char *H_result = NULL;
    unsigned char *H_input  = NULL;
    
    if (!input || !len)
        return NULL;
    
    // Allocate memory
    if ((H_result = malloc(SHA_DIGEST_LENGTH)) == NULL) goto cleanup;
    if ((H_input = malloc(BN_num_bytes(input))) == NULL) goto cleanup;
    memset(H_result, 0, SHA_DIGEST_LENGTH);
    memset(H_input, 0, BN_num_bytes(input));

    // Convert input to char array for hashing
    BN_bn2bin(input, H_input);

    // Compute the SHA1
    if (!SHA1(H_input, BN_num_bytes(input), H_result)) goto cleanup;

    // Set the result size
    *len = SHA_DIGEST_LENGTH;

    if (H_input) sfree(H_input, BN_num_bytes(input));
    return H_result;
    
cleanup:
    if (H_input) sfree(H_input, BN_num_bytes(input));
    if (H_result) sfree(H_result, SHA_DIGEST_LENGTH);
    return NULL;
}


/**
 * @brief The implementation of the hash fuction H().
 *
 * Hashes an array of byte values, with a nonce.
 *
 * @param[in] nonce         a buffer holding nonce bytes
 * @param[in] nonce_len     length of nonce
 * @param[in] vals          an array of bytes
 * @param[in] vals_num      the size of the array
 * @param[in] val_len       the length of each byte value in the array
 * @param[out] len          length of output
 * @return an allocated buffer holding the output, or NULL on failure.
 **/
unsigned char *gen_ar_H(unsigned char *nonce, size_t nonce_len, 
                        unsigned char **vals, unsigned int vals_num, 
                        unsigned int val_len, size_t *len)
{
    SHA_CTX ctx;
    unsigned char *result = NULL; // the token, aka hash result
    int i = 0;

    if (!nonce || !vals || !vals_num || !val_len || !len) return NULL;
    
    if ((result = malloc(SHA_DIGEST_LENGTH)) == NULL) goto cleanup;
    memset(result, 0, SHA_DIGEST_LENGTH);
    
    if (!SHA1_Init(&ctx)) return NULL;

    // Add nonce to the hash
    if (!SHA1_Update(&ctx, nonce, nonce_len)) goto cleanup;
    
    for(i = 0; i < vals_num; i++){
        if (!vals[i]) goto cleanup;
        if (!SHA1_Update(&ctx, vals[i], val_len)) goto cleanup;
    }
    if (!SHA1_Final(result, &ctx)) goto cleanup;

    *len = SHA_DIGEST_LENGTH;
    return result;

 cleanup:
    if (result) sfree(result, SHA_DIGEST_LENGTH);
    if (len) *len = 0;
    return NULL;
}


/**
 * @brief The implementation of the pseudo-random funcation.  
 *
 * In this implementation we use HMAC-SHA1.
 *
 * @param[in] key       key
 * @param[in] key_size  key size
 * @param[in] index     block index
 * @param[in] len       the size of the PRF output
 * @return An allocated buffer containing the PRF output, or NULL on failure
 **/
unsigned char *gen_prf_f(const unsigned char *key, size_t key_size, 
                         unsigned int index, size_t *len)
{
    unsigned char *result = NULL;
    
    if (!key || !len)
        return NULL;
    
    if ((result = malloc(EVP_MAX_MD_SIZE)) == NULL) goto cleanup;
    memset(result, 0, EVP_MAX_MD_SIZE);
    
    // Perform the HMAC on the block index
    if (!HMAC(EVP_sha1(), key, key_size, (unsigned char *)&index, sizeof(int), 
              result, (unsigned int *)len))
        goto cleanup;
    return result;
    
cleanup:
    sfree(result, EVP_MAX_MD_SIZE);
    if (len) *len = 0;
    return NULL;
}


/**
 * @brief The implementation of the pseudo-random funcation prf_k(i).  
 *
 * In this implementation we use HMAC-SHA1.
 *
 * @param[in] key      key
 * @param[in] key_len  length of key
 * @param[in] index    block index
 * @return Pointer to a BN, or NULL on error
 **/
BIGNUM *gen_prf_k(unsigned char *key, size_t key_len, unsigned int index)
{
    unsigned char *result = NULL;
    BIGNUM *result_bn = NULL;
    size_t len = 0;
    int status = -1;
    
    if (!key || !key_len)
        return NULL;
    
    // allocate memory
    if ((result = malloc(EVP_MAX_MD_SIZE)) == NULL) goto cleanup;
    memset(result, 0, EVP_MAX_MD_SIZE);

    // Perform the HMAC on the block index
    if (!HMAC(EVP_sha1(), key, key_len, 
              (unsigned char *) &index, sizeof(unsigned int), 
               result, (unsigned int *) &len))
        goto cleanup;

    // convert PRF result into a BIGNUM
    if ((result_bn = BN_new()) == NULL) goto cleanup;
    if (!BN_bin2bn(result, len, result_bn)) goto cleanup;
    status = 0;
    
cleanup:
    sfree(result, EVP_MAX_MD_SIZE);
    if (status && result_bn) BN_clear_free(result_bn);
    if (status) return NULL;
    return result_bn;
}


/**
 * @brief Generates a set of indices using a PRP. 
 *
 * @param[in] key      key
 * @param[in] key_len  the length of key
 * @param[in] total    total number of indices available
 * @param[in] c        number of indices to generate
 * @return An array of indices.
 **/
unsigned int *gen_prp_pi(const unsigned char *key, unsigned int key_len, 
                         unsigned int total, unsigned int c)
{
    unsigned int *indices = NULL;

    if (!key || !key_len || !total)
        return NULL;

    if ((indices = malloc(c * sizeof(unsigned int))) == NULL)
        goto cleanup;
    if (sample_prp_sans_replacement(key, key_len, c, total, indices) != 0)
        goto cleanup;
    return indices;

cleanup:
    if (indices) sfree(indices, c);
    return NULL;
}


/** @} */
