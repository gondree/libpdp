/**
 * @file
 * Implementation of the A-PDP module for libpdp.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup APDP
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>
#include <pdp/apdp.h>
#include "pdp_misc.h"


/**
 * @brief Finds a generator of the quadratic residues 
 * subgroup of \f$ Z^*_N \f$.
 *
 * @param[in]  n   the RSA modulus N 
 * @param[out] gen the generator
 * @return 0 on success, non-zero on error
 **/
static int pick_pdp_generator(BIGNUM **gen, BIGNUM *n)
{
    int status = -1;
    BIGNUM *a = NULL; // random value
    BIGNUM *r0 = NULL; // temp value
    BIGNUM *r1 = NULL; // temp value
    BN_CTX *bctx = NULL; // bignum context
    BIGNUM *g = NULL; // generator
    int found_g = 0;

    if (!gen || !n)
        return -1;    

    if ((g = BN_new()) == NULL) goto cleanup;
    if ((a = BN_new()) == NULL) goto cleanup;
    if ((r0 = BN_new()) == NULL) goto cleanup;
    if ((r1 = BN_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    
    while (!found_g) {
        // Pick a random a < N
        if (!BN_rand_range(a, n)) goto cleanup;

        // Check to see if a is relatively prime to N, i.e.
        //  gcd(a, N) = 1
        if (!BN_gcd(r0, a, n, bctx)) goto cleanup;
        if (!BN_is_one(r0))
            continue;

        // Check to see if a-1 is relatively prime to N, i.e.
        //  gcd(a-1, N) = 1
        if (!BN_sub(r0, a, BN_value_one())) goto cleanup;
        if (!BN_gcd(r1, r0, n, bctx)) goto cleanup;
        if (!BN_is_one(r1))
            continue;

        // Check to see if a+1 is relatively prime to N, i.e.
        // gcd(a+1, N) = 1
        if (!BN_add(r0, a, BN_value_one())) goto cleanup;
        if (!BN_gcd(r1, r0, n, bctx)) goto cleanup;
        if (!BN_is_one(r1))
            continue;

        found_g = 1;
    }
    // Square a to get a generator of the quadratic residues
    if (!BN_sqr(g, a, bctx)) goto cleanup;
    *gen = g;
    status = 0;

cleanup:
    if (bctx) BN_CTX_free(bctx);
    if (a) BN_clear_free(a);
    if (r0) BN_clear_free(r0);
    if (r1) BN_clear_free(r1);
    if (status && g) BN_clear_free(g);
    return status;
}


/**
 * @brief Generate key material.
 *
 * Generates:
 *  - the RSA key pair k->rsa
 *  - the generator k->g
 *  - the symmetric key k->v for the PRF
 *
 * @param[in]   ctx  ptr to context
 * @param[out]  k    keydata
 * @param[out]  pub  public keydata (optional)
 * @return 0 on success, non-zero on error
 **/
int apdp_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub)
{
    int status = -1;
    unsigned short use_safe_primes;
    BN_CTX *bctx = NULL;
    BIGNUM *r1 = NULL;
    BIGNUM *r2 = NULL;
    BIGNUM *phi = NULL;
    pdp_apdp_ctx_t *p = NULL;
    pdp_apdp_key_t *key = NULL;
    pdp_apdp_key_t *pk = NULL;

    if (!is_apdp(ctx) || !k) return -1;
    p = ctx->apdp_param;

    use_safe_primes = (p->opts & APDP_NO_SAFE_PRIMES) ? 0 : 1;

    if ((key = malloc(sizeof(pdp_apdp_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_apdp_key_t));
    k->apdp = key;
    
    // Allocate memory
    if ((r1=BN_new()) == NULL) goto cleanup;
    if ((r2=BN_new()) == NULL) goto cleanup;
    if ((bctx=BN_CTX_new()) == NULL) goto cleanup;
    if ((phi=BN_new()) == NULL) goto cleanup;
    if (use_safe_primes) {
        if ((key->rsa=RSA_new()) == NULL) goto cleanup;
        if ((key->rsa->n=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->d=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->e=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->p=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->q=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->dmp1=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->dmq1=BN_new()) == NULL) goto cleanup;
        if ((key->rsa->iqmp=BN_new()) == NULL) goto cleanup;
    }
    if ((key->v = malloc(p->prf_key_size)) == NULL) goto cleanup;
    memset(key->v, 0, p->prf_key_size);

    // Generate the RSA key pair
    if (!use_safe_primes) {
        key->rsa = RSA_generate_key(p->rsa_key_size, APDP_DEFAULT_RSA_PUB_EXP,
                                    NULL, NULL);
        if (!key->rsa) goto cleanup;
    } else {
        // Generate two different, safe primes p and q
        if (!BN_generate_prime(key->rsa->p, (p->rsa_key_size/2), 1, 
                               NULL, NULL, NULL, NULL))
            goto cleanup;
        if (!BN_is_prime(key->rsa->p, BN_prime_checks, NULL, bctx, NULL))
            goto cleanup;
        if (!BN_generate_prime(key->rsa->q, (p->rsa_key_size/2), 1, 
                               NULL, NULL, NULL, NULL))
            goto cleanup;
        if (!BN_is_prime(key->rsa->q, BN_prime_checks, NULL, bctx, NULL))
            goto cleanup;
        if (BN_cmp(key->rsa->p, key->rsa->q) == 0)
            goto cleanup;
        // Create RSA modulus N
        if (!BN_mul(key->rsa->n, key->rsa->p, key->rsa->q, bctx))
            goto cleanup;
        // Set e
        if (!BN_set_word(key->rsa->e, APDP_DEFAULT_RSA_PUB_EXP))
            goto cleanup;
        // Generate phi and d
        if (!BN_sub(r1, key->rsa->p, BN_value_one()))  // = p-1
            goto cleanup;
        if (!BN_sub(r2, key->rsa->q, BN_value_one()))  // = q-1
            goto cleanup;
        if (!BN_mul(phi, r1, r2, bctx))                // phi = (p-1)(q-1)
            goto cleanup;
        if (!BN_mod_inverse(key->rsa->d, key->rsa->e, phi, bctx)) // = d
            goto cleanup;
        // Calculate d mod (p-1)
        if (!BN_mod(key->rsa->dmp1, key->rsa->d, r1, bctx))
            goto cleanup;
        // Calculate d mod (q-1)
        if (!BN_mod(key->rsa->dmq1, key->rsa->d, r2, bctx))
            goto cleanup;
        // Calculate the inverse of q mod p
        if (!BN_mod_inverse(key->rsa->iqmp, key->rsa->q, key->rsa->p, bctx))
            goto cleanup;
    }
    // Check the RSA key pair
    if (!RSA_check_key(key->rsa)) goto cleanup;

    // Pick a PDP generator, using the RSA modulus N
    if (pick_pdp_generator(&(key->g), key->rsa->n)) goto cleanup;

    // Generate v, the symmetric key for the PRF
    if (!RAND_bytes(key->v, p->prf_key_size)) goto cleanup;

    // if we don't need to output pk, we are done
    if (pub == NULL) {
        status = 0;
        goto cleanup;
    } else {
        status = -1;
    }

    // Copy public components into pk
    if ((pk = malloc(sizeof(pdp_apdp_key_t))) == NULL) goto cleanup;
    memset(pk, 0, sizeof(pdp_apdp_key_t));
    pub->apdp = pk;

    if ((pk->rsa=RSA_new()) == NULL) goto cleanup;
    if ((pk->rsa->n = BN_dup(key->rsa->n)) == NULL) goto cleanup;
    if ((pk->rsa->e = BN_dup(key->rsa->e)) == NULL) goto cleanup;
    pk->rsa->d = pk->rsa->p = pk->rsa->q = NULL;
    pk->rsa->dmp1 = pk->rsa->dmq1 = pk->rsa->iqmp = NULL;
    if ((pk->g = BN_dup(key->g)) == NULL) goto cleanup;
    pk->v = NULL;
 
    status = 0;
    
 cleanup:
    if (r1) BN_clear_free(r1);
    if (r2) BN_clear_free(r2);
    if (phi) BN_clear_free(phi);
    if (bctx) BN_CTX_free(bctx);
    if (status) {
        PDP_ERR("Could not generate keys");
        apdp_key_free(ctx, k);
        apdp_key_free(ctx, pub);
    }
    return status;
}


/**
 * @brief Store key data to files.
 *
 * Serializes and stores key data, protecting private key data
 * using a password-based key.
 *
 * @todo serialize the data in ASN.1 
 *
 * @param[in]   ctx   ptr to context
 * @param[in]   k     keydata
 * @param[in]   path  path to directory to use to store keydata
 * @return 0 on success, non-zero on error
 **/
int apdp_key_store(const pdp_ctx_t *ctx, const pdp_key_t *k, const char *path)
{
    int err, status = -1;
    size_t gen_len, enc_len;
    char passwd[1024];            // password to use in PBKD
    char pri_keypath[MAXPATHLEN]; // path to pri key data
    char pub_keypath[MAXPATHLEN]; // path to pub key data
    FILE *pub_key = NULL;
    FILE *pri_key = NULL;
    EVP_PKEY *pkey = NULL;       // EVP key for the RSA key data
    unsigned char *salt = NULL;  // PBKD password salt
    unsigned char *dk = NULL;    // PBKD derived key, used as KEK
    unsigned char key_v[32];     // 256-bit buffer to hold v
    unsigned char *enc_v = NULL; // buffer for encrypted v
    unsigned char *gen = NULL;   // buffer to hold serialized g
    pdp_apdp_key_t *key = NULL;
    pdp_apdp_ctx_t *p = NULL;

    if (!is_apdp(ctx) || !k || !path || (strlen(path) > MAXPATHLEN))
        return -1;
    p = ctx->apdp_param;
    key = k->apdp;

    if (p->prf_key_size > sizeof(key_v)) {
        PDP_ERR("Buffer for PRF key 'v' is not large enough.");
        return -1;
    }

    // Allocate memory
    if ((pkey = EVP_PKEY_new()) == NULL) goto cleanup;
    if ((salt = malloc(p->prf_key_size)) == NULL) goto cleanup;
    memset(salt, 0, p->prf_key_size);
    memset(key_v, 0, sizeof(key_v));
    
    // Check 'path' exists and derive names for key data files to store there
    err = get_key_paths(pri_keypath, sizeof(pri_keypath),
                        pub_keypath, sizeof(pub_keypath), path, "apdp");
    if (err) goto cleanup;

    if ((access(pri_keypath, F_OK) == 0) || (access(pub_keypath, F_OK) == 0)) {
        // keys already exist --- we don't need to store them
        status = 0;
        goto cleanup;
    }

    // Open, create and truncate the key files
    if ((pri_key = fopen(pri_keypath, "w")) == NULL) goto cleanup;
    if ((pub_key = fopen(pub_keypath, "w")) == NULL) goto cleanup;

    // Get a passphrase to protect the stored key material
    if (pdp_get_passphrase(ctx, (char *) passwd, sizeof(passwd)) != 0)
        goto cleanup;

    // Turn our RSA key into an EVP key
    if (!EVP_PKEY_set1_RSA(pkey, key->rsa)) goto cleanup;

    // Write the EVP key in PKCS8 password-protected format
    err = PEM_write_PKCS8PrivateKey(pri_key, pkey, EVP_aes_256_cbc(), 
                                    NULL, 0, 0, passwd);
    if (!err) goto cleanup;

    // Generate random bytes for a salt
    if (!RAND_bytes(salt, p->prf_key_size)) goto cleanup;

    // Generate an AES key via PBKDF, to use for key wrapping
    // This allocates space for dk
    err = PBKDF2(&dk, p->prp_key_size, (unsigned char *) passwd, 
                 strlen(passwd), salt, p->prf_key_size, 10000);
    if (err) goto cleanup;

    // Pad and NIST-wrap the PRF symetric key, v
    // This allocates space for enc_v
    memcpy(key_v, key->v, p->prf_key_size);
    err = pdp_key_wrap(&enc_v, &enc_len, key_v, sizeof(key_v), 
                       dk, p->prp_key_size);
    if (err) goto cleanup;
    if (enc_len != (sizeof(key_v) + 8)) goto cleanup; // buffer + 8 bytes
    
    // Write the salt
    fwrite(salt, p->prf_key_size, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    
    // Write the encypted value of v
    fwrite(enc_v, enc_len, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    
    // Write the public key
    if (!PEM_write_RSAPublicKey(pub_key, key->rsa)) goto cleanup;

    // Write the length of g
    gen_len = BN_num_bytes(key->g);
    fwrite(&gen_len, sizeof(gen_len), 1, pub_key);
    if (ferror(pub_key)) goto cleanup;

    // Convert g to binary and write it
    if ((gen = malloc(gen_len)) == NULL) goto cleanup;
    memset(gen, 0, gen_len);
    if (!BN_bn2bin(key->g, gen)) goto cleanup;
    fwrite(gen, gen_len, 1, pub_key);
    if (ferror(pub_key)) goto cleanup;
    
    status = 0;

cleanup:
    memset(passwd, 0, sizeof(passwd));
    if (pri_key) fclose(pri_key);
    if (pub_key) fclose(pub_key);
    if (pkey) EVP_PKEY_free(pkey);
    sfree(dk, p->prp_key_size);
    sfree(salt, p->prf_key_size);
    sfree(enc_v, enc_len);
    sfree(gen, gen_len);
    if (status != 0) {
        PDP_ERR("Did not write key pair successfully.");
        if (access(pub_keypath, F_OK) == 0) unlink(pub_keypath);
        if (access(pri_keypath, F_OK) == 0) unlink(pri_keypath);
    }
    return status;
}


/**
 * @brief Reads key files and populates the key structure.
 *
 * Un-serializes and retrieves key data, opening private key data
 * using a password-based key.
 *
 * @param[in]     ctx          context
 * @param[out]    k            public key data
 * @param[in]     pub_keypath  path to public key data
 * @return 0 on success, non-zero on error
 **/
static int apdp_pub_key_open(const pdp_ctx_t *ctx, pdp_key_t *k,
                             const char* pub_keypath)
{
    int status = -1;
    size_t gen_len;
    FILE *pub_key = NULL;
    unsigned char *gen = NULL;   // buffer to hold serialized rep of g
    pdp_apdp_key_t *key = NULL;

    if (!is_apdp(ctx) || !k || !pub_keypath) return -1;
    if (strlen(pub_keypath) > MAXPATHLEN) return -1;

    if ((key = malloc(sizeof(pdp_apdp_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_apdp_key_t));
    k->apdp = key;
    
    // Allocate space for key data
    if ((key->g = BN_new()) == NULL) goto cleanup;

    // Open the key files
    if ((pub_key = fopen(pub_keypath, "r")) == NULL) goto cleanup;

    // Read in the public key
    key->rsa = PEM_read_RSAPublicKey(pub_key, NULL, NULL, NULL);
    if (key->rsa == NULL) goto cleanup;
    if (!key->rsa->n || !key->rsa->e) goto cleanup;
    
    // Read g data length and then binary g data
    fread(&gen_len, sizeof(gen_len), 1, pub_key);
    if (ferror(pub_key)) goto cleanup;
    if ((gen = malloc(gen_len)) == NULL) goto cleanup;
    fread(gen, gen_len, 1, pub_key);
    if (ferror(pub_key)) goto cleanup;

    // Read g from its buffer into 'key'
    if (!BN_bin2bn(gen, gen_len, key->g)) goto cleanup;

    status = 0;

cleanup:
    CRYPTO_cleanup_all_ex_data();
    if (pub_key) fclose(pub_key);
    sfree(gen, gen_len);
    if (status) {
        PDP_ERR("Couldn't open key file.");
        apdp_key_free(ctx, k);
    }    
    return status;
}


/**
 * @brief Reads key files and populates the key structure.
 *
 * Un-serializes and retrieves key data, opening private key data
 * using a password-based key.
 *
 * @param[in]     ctx          context
 * @param[out]    k            private key data
 * @param[in]     pri_keypath  path to private key data
 * @param[in]     pub_keypath  path to public key data
 * @return 0 on success, non-zero on error
 **/
static int apdp_pri_key_open(const pdp_ctx_t *ctx, pdp_key_t *k,
                             const char* pri_keypath, const char* pub_keypath)
{
    int err, status = -1;
    size_t key_v_len, gen_len;
    char passwd[1024];            // password to use in PBKD
    FILE *pri_key = NULL;
    FILE *pub_key = NULL;
    EVP_PKEY *pkey = NULL;       // EVP key for the RSA key data
    unsigned char *salt = NULL;  // PBKD password salt
    unsigned char *dk = NULL;    // PBKD derived key
    unsigned char *enc_v = NULL; // v, encryted using the KEK
    size_t enc_v_len = 32 + 8;   // 256-bit buffer + 8 bytes
    unsigned char *key_v = NULL; // 256-bit buffer to store serialized v
    unsigned char *gen = NULL;   // buffer to hold serialized rep of g
    RSA *rsa = NULL;
    BN_CTX *bctx = NULL;
    BIGNUM *r1 = NULL;
    BIGNUM *r2 = NULL;
    pdp_apdp_key_t *key = NULL;
    pdp_apdp_ctx_t *p = NULL;

    if (!is_apdp(ctx) || !k || !pri_keypath || !pub_keypath)
        return -1;
    if (strlen(pri_keypath) > MAXPATHLEN) return -1;
    if (strlen(pub_keypath) > MAXPATHLEN) return -1;
    p = ctx->apdp_param;

    if ((key = malloc(sizeof(pdp_apdp_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_apdp_key_t));
    k->apdp = key;
    
    // Allocate space for key data  
    if ((key->g = BN_new()) == NULL) goto cleanup;
    if ((key->v = malloc(p->prf_key_size)) == NULL) goto cleanup;
    if ((r1 = BN_new()) == NULL)  goto cleanup;    
    if ((r2 = BN_new()) == NULL) goto cleanup;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;
    if ((salt = malloc(p->prf_key_size)) == NULL) goto cleanup;
    if ((enc_v = malloc(enc_v_len)) == NULL) goto cleanup;
    memset(key->v, 0, p->prf_key_size);
    memset(enc_v, 0, enc_v_len);
    memset(salt, 0, p->prf_key_size);

    // Open the key files
    if ((pri_key = fopen(pri_keypath, "r")) == NULL) goto cleanup;
    if ((pub_key = fopen(pub_keypath, "r")) == NULL) goto cleanup;

    // Get passphrase to access the private key material
    if (pdp_get_passphrase(ctx, (char *) passwd, sizeof(passwd)) != 0)
        goto cleanup;

    // Use passwd to read out private RSA EVP data
    if ((pkey = PEM_read_PrivateKey(pri_key, NULL, NULL, passwd)) == NULL)
        goto cleanup;
    
    // Read RSA EVP into 'key' and check it
    if ((key->rsa = EVP_PKEY_get1_RSA(pkey)) == NULL) goto cleanup;
    if (!RSA_check_key(key->rsa)) goto cleanup;

    // Get the salt and the encrypted PRF key v
    fread(salt, p->prf_key_size, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    fread(enc_v, enc_v_len, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    
    // Generate a password-based key
    err = PBKDF2(&dk, p->prp_key_size, (unsigned char *) passwd, 
                 strlen(passwd), salt, p->prf_key_size, 10000);
    if (err) goto cleanup;
    
    // We no longer need passwd
    memset(passwd, 0, sizeof(passwd));

    // Unwrap and strip the padding from the key v
    err = pdp_key_unwrap(&key_v, &key_v_len, enc_v, enc_v_len, 
                         dk, p->prp_key_size);
    if (err) goto cleanup;
    if (key_v_len < p->prf_key_size) goto cleanup; // should be a padded key
    
    // Read v from its buffer into 'key'
    memcpy(key->v, key_v, p->prf_key_size);

    // Skip over the public key
    rsa = PEM_read_RSAPublicKey(pub_key, NULL, NULL, NULL);
    if (!rsa) goto cleanup;
    
    // Read g data length and then binary g data
    fread(&gen_len, sizeof(gen_len), 1, pub_key);
    if (ferror(pub_key)) goto cleanup;
    if ((gen = malloc(gen_len)) == NULL) goto cleanup;
    fread(gen, gen_len, 1, pub_key);
    if (ferror(pub_key)) goto cleanup;

    // Read g from its buffer into 'key'
    if (!BN_bin2bn(gen, gen_len, key->g)) goto cleanup;

    status = 0;

cleanup:
    memset(passwd, 0, sizeof(passwd));
    CRYPTO_cleanup_all_ex_data();
    if (pri_key) fclose(pri_key);
    if (pub_key) fclose(pub_key);
    if (r1) BN_clear_free(r1);
    if (r2) BN_clear_free(r2);
    if (bctx) BN_CTX_free(bctx);
    if (pkey) EVP_PKEY_free(pkey);
    if (rsa) RSA_free(rsa);
    sfree(key_v, key_v_len);
    sfree(dk, p->prp_key_size);
    sfree(salt, p->prf_key_size);
    sfree(enc_v, enc_v_len);
    sfree(gen, gen_len);
    if (status) {
        PDP_ERR("Couldn't open key files.");
        apdp_key_free(ctx, k);
    }    
    return status;
}


/**
 * @brief Reads key files and populates the key structure.
 *
 * @param[in]     ctx   context
 * @param[out]    k     private key data (NULL, if not desired)
 * @param[out]    pub   public key data (NULL, if not desired)
 * @param[in]     path  path to directory used to store keydata
 * @return 0 on success, non-zero on error
 **/
int apdp_key_open(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub,
                  const char* path)
{
    char pri_keypath[MAXPATHLEN]; // path to pri key data
    char pub_keypath[MAXPATHLEN]; // path to pub key data
    int err = -1;

    if (!is_apdp(ctx) || !path || (strlen(path) > MAXPATHLEN))
        return -1;
    
    // Check 'path' exists and derive names for key data files
    err = get_key_paths(pri_keypath, sizeof(pri_keypath),
                        pub_keypath, sizeof(pub_keypath), path, "apdp");
    if (err) goto cleanup;
    if (access(pri_keypath, F_OK) && access(pub_keypath, F_OK)) goto cleanup;

    if (k) {
        err = apdp_pri_key_open(ctx, k, pri_keypath, pub_keypath);
        if (err) goto cleanup;
    }
    if (pub) {
        err = apdp_pub_key_open(ctx, pub, pub_keypath);
        if (err) goto cleanup;    
    }
    return 0;

cleanup:
    apdp_key_free(ctx, k);
    apdp_key_free(ctx, pub);
    return -1;
}


/**
 * @brief Destroy and free key material.
 * @param[in]       ctx   context
 * @param[in,out]   k     keydata
 * @return 0 on success, non-zero on error
 **/
int apdp_key_free(const pdp_ctx_t *ctx, pdp_key_t *k)
{
    pdp_apdp_key_t *key = NULL;
    pdp_apdp_ctx_t *p = NULL;

    if (!k || !k->apdp)
        return -1;
    p = ctx->apdp_param;
    key = k->apdp;

    if (key->rsa) RSA_free(key->rsa);
    if (key->g) BN_clear_free(key->g);
    sfree(key->v, p->prf_key_size);
    sfree(key, sizeof(pdp_apdp_key_t));
    CRYPTO_cleanup_all_ex_data();
    return 0;
}

/** @} */
