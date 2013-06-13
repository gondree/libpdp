/**
 * @file
 * Support routines for libpdp.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 *
 * @defgroup MISC Support Routines
 * \brief Generic routines for keys and crypto primitives.
 **/
#ifndef __PDP_MISC_H__
#define __PDP_MISC_H__

#include <stddef.h>
#include <stdio.h>
#include <openssl/rsa.h>
#include <openssl/bn.h>
#include <pdp.h>

/**
 * @brief A macro for printing errors to stderr.
 **/
#define PDP_ERR(...) \
    do { \
        fprintf(stderr, "\n%s: ", __FUNCTION__); \
        fprintf(stderr, __VA_ARGS__); \
        fflush(stderr); \
    } while(0)


/**
 * @brief A macro for announcing a feature is not supported.
 **/
#define PDP_UNSUPPORTED(x) \
    do { \
        PDP_ERR("%s was not build with %s support", LIBPDP_NAME, x); \
    } while(0)


/**
 * @brief A macro for debugging.
 **/
#ifdef _PDP_DEBUG
#define DEBUG(x, ...) \
    do { if (x) { \
            fprintf(stderr, __VA_ARGS__); \
            fflush(stderr); \
    }    } while(0)
#else
#define DEBUG(x, ...) while(0) {}
#endif


/**
 * @brief A generic "safe" free routine.
 **/
#define sfree(ptr, len) \
    do { \
        if (ptr) { \
            if (len) memset(ptr, 0, len); \
            free(ptr); \
        } \
        ptr = NULL; \
    } while(0)


/**
 * @brief Returns 1 if the context is appropriate for macpdp.
 **/
#define is_macpdp(ctx) \
    ((!ctx || (ctx->algo != PDP_MACPDP) || !ctx->macpdp_param) ? 0 : 1)

/**
 * @brief Returns 1 if the context is appropriate for apdp.
 **/
#define is_apdp(ctx) \
    ((!ctx || (ctx->algo != PDP_APDP) || !ctx->apdp_param) ? 0 : 1)

/**
 * @brief Returns 1 if the context is appropriate for cpor.
 **/
#define is_cpor(ctx) \
    ((!ctx || (ctx->algo != PDP_CPOR) || !ctx->cpor_param) ? 0 : 1)

/**
 * @brief Returns 1 if the context is appropriate for sepdp.
 **/
#define is_sepdp(ctx) \
    ((!ctx || (ctx->algo != PDP_SEPDP) || !ctx->sepdp_param) ? 0 : 1)


/*
 * function prototypes - debug, in pdp_misc.c
 */
#ifdef _PDP_DEBUG
void pdp_hexdump(const char* msg, unsigned int index, 
                 const unsigned char *buf, size_t len);
#endif // _PDP_DEBUG


/*
 * function prototypes - in pdp_misc.c
 */
unsigned int next_pow_2(int x);
unsigned int prev_pow_2(unsigned int x);
int sample_sans_replacement(unsigned int samp_sz, unsigned int pop_sz, 
        unsigned int S[]);
int sample_prp_sans_replacement(const unsigned char *ki, unsigned int ki_size, 
        unsigned int samp_sz, unsigned int pop_sz, unsigned int S[]);
BIGNUM *gen_fdh(const RSA *key, const unsigned char *input, size_t len);
unsigned char *gen_bn_H(const BIGNUM *input, size_t *len);
unsigned char *gen_ar_H(unsigned char *nonce, size_t nonce_len, 
        unsigned char **vals, unsigned int vals_num, 
        unsigned int val_len, size_t *len);
unsigned char *gen_prf_f(const unsigned char *key, size_t key_size, 
        unsigned int index, size_t *len);
BIGNUM *gen_prf_k(unsigned char *key, size_t key_len, unsigned int index);
unsigned int *gen_prp_pi(const unsigned char *key, unsigned int key_len, 
        unsigned int total, unsigned int c);

/*
 * function prototypes - in pdp_key.c
 */ 
int pdp_read_password(const char *prompt, unsigned char *passwd, size_t len);
int pdp_get_passphrase(const pdp_ctx_t *ctx, char *passwd, size_t len);
int get_key_paths(char *pri_path, size_t pri_len, 
        char *pub_path, size_t pub_len,
        const char *kpath, const char *name);
int PBKDF2(unsigned char **key, size_t dkey_len,
        unsigned char *pw, size_t pw_len, 
        unsigned char *salt, size_t salt_len, unsigned int c);
int pdp_key_wrap(unsigned char** enc, size_t *enc_len,
        unsigned char *key, size_t key_len, 
        unsigned char *kek, size_t kek_len);
int pdp_key_unwrap(unsigned char **key, size_t *key_len,
        unsigned char *ekey, size_t ekey_len,
        unsigned char *kek, size_t kek_len);
int encrypt_then_mac(const unsigned char *ekey, size_t ekey_len, 
        const unsigned char *mkey, size_t mkey_len, 
        const unsigned char *input, size_t input_len,
        unsigned char *ctxt, size_t *ctxt_len,
        unsigned char *mac, size_t *mac_len,
        unsigned char *iv, size_t iv_len);
int verify_then_decrypt(const unsigned char *ekey, size_t ekey_len, 
        const unsigned char *mkey, size_t mkey_len,
        const unsigned char *ctxt, size_t ctxt_len,
        const unsigned char *mac, size_t mac_len,
        const unsigned char *iv, size_t iv_len,
        unsigned char *output, size_t *output_len);

#endif
