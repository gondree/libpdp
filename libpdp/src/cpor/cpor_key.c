/**
 * @file
 * Implementation of the CPOR module for libpdp.
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
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <libgen.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>
#include <pdp/cpor.h>
#include "pdp_misc.h"


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
int cpor_key_gen(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub)
{
    int status = -1;
    pdp_cpor_ctx_t *p = NULL;
    pdp_cpor_key_t *key = NULL;
    pdp_cpor_key_t *pk = NULL;
    BN_CTX *bctx = NULL;

    if (!is_cpor(ctx) || !k) return -1;
    p = ctx->cpor_param;

    // check params
    if (!p->Zp_bits)
        goto cleanup;

    // allocate key structure
    if ((key = malloc(sizeof(pdp_cpor_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_cpor_key_t));
    k->cpor = key;
    if ((pk = malloc(sizeof(pdp_cpor_key_t))) == NULL) goto cleanup;
    memset(pk, 0, sizeof(pdp_cpor_key_t));
    pub->cpor = pk;
    if ((bctx = BN_CTX_new()) == NULL) goto cleanup;

    // generate key data
    if ((key->k_enc = malloc(p->enc_key_size)) == NULL) goto cleanup;
    key->k_enc_size = p->enc_key_size;
    if ((key->k_mac = malloc(p->mac_key_size)) == NULL) goto cleanup;
    key->k_mac_size = p->mac_key_size;
    if (!RAND_bytes(key->k_enc, key->k_enc_size)) goto cleanup;
    if (!RAND_bytes(key->k_mac, key->k_mac_size)) goto cleanup;

    // generate Zp
    key->Zp = BN_new();
    // Generate a Zp_bits sized safe prime for our group Zp
    if (!BN_generate_prime_ex(key->Zp, p->Zp_bits, 1, NULL, NULL, NULL))
        goto cleanup;
    // Check to see it's prime
    if (!BN_is_prime_ex(key->Zp, BN_prime_checks, bctx, NULL))
        goto cleanup;

    // duplicate Zp so prover has access to it  
    if ((pk->Zp = BN_dup(key->Zp)) == NULL) goto cleanup;

    status = 0;

cleanup:
    if (bctx) BN_CTX_free(bctx);
    if (status) {
        cpor_key_free(ctx, k);
        cpor_key_free(ctx, pub);
    }
    return status;
}


/**
 * @brief Store key data to files.
 *
 * Serializes and stores key data.
 *
 * @todo protect private data with a passphrase
 * @todo serialize the data in ASN.1
 *
 * @param[in]   ctx   ptr to context
 * @param[in]   k     keydata
 * @param[in]   path  path to directory to use to store keydata
 * @return 0 on success, non-zero on error
 **/
int cpor_key_store(const pdp_ctx_t *ctx, const pdp_key_t *k, const char *path)
{
    int err, status = -1;
    pdp_cpor_key_t *key = NULL;
    char pri_keypath[MAXPATHLEN]; // path to pri key data
    char pub_keypath[MAXPATHLEN]; // path to pub key data
    FILE *pub_key = NULL;
    FILE *pri_key = NULL;
    unsigned char *Zp = NULL;
    size_t Zp_size = 0;

    if (!is_cpor(ctx) || !k || !path || (strlen(path) > MAXPATHLEN))
        return -1;
    key = k->cpor;

    // Check 'path' exists and derive names for key data files to store there
    err = get_key_paths(pri_keypath, sizeof(pri_keypath),
                        pub_keypath, sizeof(pub_keypath), path, "cpor");
    if (err) goto cleanup;

    if ((access(pri_keypath, F_OK) == 0) || (access(pub_keypath, F_OK) == 0)) {
        // keys already exist --- we don't need to store them
        status = 0;
        goto cleanup;
    }

    // Open, create and truncate the key files
    if ((pri_key = fopen(pri_keypath, "w")) == NULL) goto cleanup;
    if ((pub_key = fopen(pub_keypath, "w")) == NULL) goto cleanup;

    fwrite(&key->k_enc_size, sizeof(size_t), 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    fwrite(key->k_enc, key->k_enc_size, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    fwrite(&key->k_mac_size, sizeof(size_t), 1, pri_key);
    if (ferror(pri_key)) goto cleanup;
    fwrite(key->k_mac, key->k_mac_size, 1, pri_key);
    if (ferror(pri_key)) goto cleanup;

    Zp_size = BN_num_bytes(key->Zp);
    fwrite(&Zp_size, sizeof(size_t), 1, pri_key);
    fwrite(&Zp_size, sizeof(size_t), 1, pub_key);
    if ((Zp = malloc(Zp_size)) == NULL) goto cleanup;
    memset(Zp, 0, Zp_size);
    if (!BN_bn2bin(key->Zp, Zp)) goto cleanup;
    fwrite(Zp, Zp_size, 1, pri_key);
    fwrite(Zp, Zp_size, 1, pub_key);
    
    status = 0;

cleanup:
    if (pri_key) fclose(pri_key);
    if (pub_key) fclose(pub_key);
    sfree(Zp, Zp_size);
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
 * @param[in]     keypath      path to public key data
 * @return 0 on success, non-zero on error
 **/
static int cpor_pub_key_open(const pdp_ctx_t *ctx, pdp_key_t *k,
                             const char* keypath)
{
    int status = -1;
    pdp_cpor_key_t *key = NULL;
    unsigned char *Zp = NULL;
    size_t Zp_size = 0;
    FILE *fp = NULL;

    if (!is_cpor(ctx) || !k || !keypath)
        return -1;
    if (strlen(keypath) > MAXPATHLEN) return -1;

    if ((key = malloc(sizeof(pdp_cpor_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_cpor_key_t));
    k->cpor = key;

    // Open the key file
    if ((fp = fopen(keypath, "r")) == NULL) goto cleanup;

    fread(&Zp_size, sizeof(size_t), 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((Zp = malloc(Zp_size)) == NULL) goto cleanup;
    memset(Zp, 0, Zp_size);
    fread(Zp, Zp_size, 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((key->Zp = BN_new()) == NULL) goto cleanup;
    if (!BN_bin2bn(Zp, Zp_size, key->Zp)) goto cleanup;

    status = 0;

cleanup:
    sfree(Zp, Zp_size);
    if (fp) fclose(fp);
    if (status) {
        PDP_ERR("Couldn't open key files.");
        cpor_key_free(ctx, k);
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
 * @param[in]     keypath      path to private key data
 * @return 0 on success, non-zero on error
 **/
static int cpor_pri_key_open(const pdp_ctx_t *ctx, pdp_key_t *k,
                             const char* keypath)
{
    int status = -1;
    unsigned char *Zp = NULL;
    size_t Zp_size = 0;
    FILE *fp = NULL;
    pdp_cpor_key_t *key = NULL;

    if (!is_cpor(ctx) || !k || !keypath)
        return -1;
    if (strlen(keypath) > MAXPATHLEN) return -1;

    if ((key = malloc(sizeof(pdp_cpor_key_t))) == NULL) goto cleanup;
    memset(key, 0, sizeof(pdp_cpor_key_t));
    k->cpor = key;

    // Open the key file
    if ((fp = fopen(keypath, "r")) == NULL) goto cleanup;

    fread(&(key->k_enc_size), sizeof(size_t), 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((key->k_enc = malloc(key->k_enc_size)) == NULL) goto cleanup;
    memset(key->k_enc, 0, key->k_enc_size);
    fread(key->k_enc, key->k_enc_size, 1, fp);
    if (ferror(fp)) goto cleanup;
    fread(&(key->k_mac_size), sizeof(size_t), 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((key->k_mac = malloc(key->k_mac_size)) == NULL) goto cleanup;
    memset(key->k_mac, 0, key->k_mac_size);
    fread(key->k_mac, key->k_mac_size, 1, fp);
    if (ferror(fp)) goto cleanup;
    fread(&Zp_size, sizeof(size_t), 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((Zp = malloc(Zp_size)) == NULL) goto cleanup;
    memset(Zp, 0, Zp_size);
    fread(Zp, Zp_size, 1, fp);
    if (ferror(fp)) goto cleanup;
    if ((key->Zp = BN_new()) == NULL) goto cleanup;
    if (!BN_bin2bn(Zp, Zp_size, key->Zp)) goto cleanup;

    status = 0;

cleanup:
    sfree(Zp, Zp_size);
    if (fp) fclose(fp);
    if (status) {
        PDP_ERR("Couldn't open key files.");
        cpor_key_free(ctx, k);
    }
    return status;
}


static size_t ctx_overhead(void)
{
    size_t len = 0;

    EVP_CIPHER_CTX *ctx;
    ctx = EVP_CIPHER_CTX_new();
    if (!EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, NULL, NULL))
        return 0;
    len = EVP_CIPHER_CTX_block_size(ctx);
    EVP_CIPHER_CTX_cleanup(ctx);
    return len;
}


/**
 * @brief Reads the per-file secret data (the file key) .
 *
 * Reads the file key associated with the file's tag and
 * populated the tag structure.
 *
 * file key is of the format <len, |ctxt|, ctxt, |mac|, mac>, where
 *  ctxt = <m+1 , E(|key|, key, |alpha-0|, alpha-0, ..., |alpha-m|, alpha-m)>
 *
 * @param[in]     ctx   context
 * @param[in]     key   key
 * @param[out]    td    a pointer to where tagdata will be populated
 * @return 0 on success, non-zero on error
 **/
int cpor_fkey_open(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
                   pdp_cpor_tagdata_t **td)
{
    pdp_cpor_ctx_t *p = NULL;
    char filepath[MAXPATHLEN];
    FILE *file = NULL;
    pdp_cpor_tagdata_t *t = NULL;
    unsigned char *ctxt = NULL;
    unsigned char *mac = NULL;
    unsigned char *buf = NULL;
    unsigned char *alpha = NULL;
    unsigned char *tmp_ptr = NULL;
    size_t len, ctxt_len, mac_len, buf_len, alpha_size;
    unsigned int num_sectors;
    int i, status = -1;

    if (!is_cpor(ctx) || !td || !key)
        return -1;
    p = ctx->cpor_param;

    // there should not already be tagdata, here
    if (*td != NULL) {
        cpor_tags_free(ctx, *td);
    }
    if (strlen(ctx->ofilepath) > MAXPATHLEN) return -1;

    // Open per-file secret (filepath.tag.secret )
    memset(filepath, 0, sizeof(filepath));
    len = snprintf(filepath, sizeof(filepath), "%s.secret", ctx->ofilepath)+1;
    if (len > sizeof(filepath)) {
        goto cleanup;
    } else if ((file = fopen(filepath, "r")) == NULL) {
        PDP_ERR("unable to open %s", filepath);
        goto cleanup;
    }

    // allocate space for tagdata
    if ((t = malloc(sizeof(pdp_cpor_tagdata_t))) == NULL) goto cleanup;
    memset(t, 0, sizeof(pdp_cpor_tagdata_t));

    // read len of file contents
    fread(&len, sizeof(len), 1, file);
    if (ferror(file)) goto cleanup;

    // read ctxt and mac
    fread(&ctxt_len, sizeof(ctxt_len), 1, file);
    if (ferror(file)) goto cleanup;
    if ((ctxt = malloc(ctxt_len)) == NULL) goto cleanup;
    fread(ctxt, ctxt_len, 1, file);
    if (ferror(file)) goto cleanup; 
    fread(&mac_len, sizeof(mac_len), 1, file);
    if (ferror(file)) goto cleanup;
    if ((mac = malloc(mac_len)) == NULL) goto cleanup;
    fread(mac, mac_len, 1, file);
    if (ferror(file)) goto cleanup; 

    // double-check file contents look sane
    if (len != sizeof(ctxt_len) + ctxt_len + sizeof(mac_len) + mac_len)
        goto cleanup;

    // read num_sectors from the front of ctxt
    memcpy(&num_sectors, ctxt, sizeof(num_sectors));

    // double-check num_blocks matched ctx
    if (p->num_sectors != num_sectors) goto cleanup;

    // tmp_ptr points to ciphertext
    tmp_ptr = ctxt + sizeof(num_sectors);
    len = ctxt_len - sizeof(num_sectors);
    
    // ciphertext length is upper-bound on plaintext length
    buf_len = len;
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;
    
    /// @todo fix NULL iv
    if (verify_then_decrypt(key->k_enc, key->k_enc_size, key->k_mac, 
                            key->k_mac_size, tmp_ptr, len, mac, mac_len, 
                            NULL, 0, buf, &buf_len) != 0)
        goto cleanup;

    // read key out of plaintext
    tmp_ptr = buf;
    if ((t->k_prf = malloc(p->prf_key_size)) == NULL) goto cleanup;
    memset(t->k_prf, 0, p->prf_key_size);
    memcpy(t->k_prf, tmp_ptr, p->prf_key_size);    

    // allocate space for alphas
    t->alpha_size = sizeof(BIGNUM *) * p->num_sectors;
    if ((t->alpha = malloc(t->alpha_size)) == NULL) goto cleanup;
    memset(t->alpha, 0, sizeof(t->alpha_size));

    // read alphas out of plaintext
    tmp_ptr += p->prf_key_size;
    for (i = 0; i < p->num_sectors; i++) {
        memcpy(&alpha_size, tmp_ptr, sizeof(alpha_size));
        tmp_ptr += sizeof(alpha_size);

        if ((alpha = malloc(alpha_size)) == NULL) goto cleanup;
        memset(alpha, 0, alpha_size);
        memcpy(alpha, tmp_ptr, alpha_size);
        tmp_ptr += alpha_size;

        if ((t->alpha[i] = BN_new()) == NULL) goto cleanup;
        if (!BN_bin2bn(alpha, alpha_size, t->alpha[i])) goto cleanup;
        sfree(alpha, alpha_size);
        
        alpha = NULL;
        alpha_size = 0;
    }
    *td = t;
    status = 0;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Read Key File - ");
    DEBUG(1, "\n  CTXT Length [%d]",  ctxt_len);
    DEBUG(1, "\n  MAC Length [%d]",  mac_len);
    DEBUG(1, "\n  Num Sectors Length [%d]",  p->num_sectors);
    for(i=0; i < p->num_sectors; i++) {
        DEBUG(1, "\n Sector %02d", i);
        DEBUG(1, "\n  Alpha Size [%d]",  BN_num_bytes(t->alpha[i]));
        DEBUG(1, "\n  Alpha (hex) [%s]", BN_bn2hex(t->alpha[i]));
    }
#endif // _PDP_DEBUG

cleanup:
    if (file) fclose(file);    
    sfree(ctxt, ctxt_len);
    sfree(mac, mac_len);
    sfree(buf, buf_len);
    sfree(alpha, alpha_size);
    if (status) {
        cpor_tags_free(ctx, t);
        if (td) *td = NULL;
    }
    return status;
}


/**
 * @brief Stores the per-file secret data (the file key).
 *
 * Stores the file key associated with the file's tag.
 *
 * file key is of the format <len, |ctxt|, ctxt, |mac|, mac>, where
 *  ctxt = <m+1 , E(|key|, key, |alpha-0|, alpha-0, ..., |alpha-m|, alpha-m)>
 *
 * @param[in]    ctx   context
 * @param[in]    key   key
 * @param[in]    td    the tag data, populated with per-file secrets
 * @return 0 on success, non-zero on error
 **/
int cpor_fkey_store(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
                    const pdp_cpor_tagdata_t *td)
{
    pdp_cpor_ctx_t *p = NULL;
    char filepath[MAXPATHLEN];
    unsigned char *k_ptxt = NULL;
    unsigned char *k_ctxt = NULL;
    unsigned char *k_mac = NULL;
    unsigned char *alpha = NULL;
    unsigned char *buf = NULL;
    unsigned char *tmp_ptr = NULL;
    FILE *file = NULL;
    size_t len, buf_len, alpha_len, k_ptxt_len, k_ctxt_len, k_mac_len;
    int i, status = -1;

    if (!is_cpor(ctx) || !td || !key)
        return -1;
    p = ctx->cpor_param;

    if (strlen(ctx->ofilepath) > MAXPATHLEN) return -1;

    // Create per-file secret (filepath.tag.secret )
    memset(filepath, 0, sizeof(filepath));
    len = snprintf(filepath, sizeof(filepath), "%s.secret", ctx->ofilepath)+1;
    if (len > sizeof(filepath)) {
        goto cleanup;
    }
    if ((access(filepath, F_OK) == 0) && (ctx->verbose)) {
        PDP_ERR("WARNING: overwriting [%s]", filepath);
    }
    if ((file = fopen(filepath, "w")) == NULL) {
        PDP_ERR("unable to open %s", filepath);
        goto cleanup;
    }

    // Generate the plaintext, holding k_prf and alphas
    k_ptxt_len = p->prf_key_size;
    if ((k_ptxt = malloc(k_ptxt_len)) == NULL) goto cleanup;
    memcpy(k_ptxt, td->k_prf, k_ptxt_len);

    for(i=0; i < p->num_sectors; i++) {
        alpha_len = BN_num_bytes(td->alpha[i]);
        if ((alpha = malloc(alpha_len)) == NULL) goto cleanup;
        memset(alpha, 0, alpha_len);
        if (!BN_bn2bin(td->alpha[i], alpha)) goto cleanup;

        tmp_ptr = realloc(k_ptxt, k_ptxt_len + sizeof(alpha_len) + alpha_len);
        if (tmp_ptr == NULL) goto cleanup;
        k_ptxt = tmp_ptr;
        tmp_ptr = NULL;

        memcpy(k_ptxt + k_ptxt_len, &alpha_len, sizeof(alpha_len));
        memcpy(k_ptxt + k_ptxt_len + sizeof(alpha_len), alpha, alpha_len);
        k_ptxt_len += sizeof(alpha_len) + alpha_len;
        
        sfree(alpha, alpha_len);
        alpha = NULL;
        alpha_len = 0;
    }

    // ctxt holds number of blocks, followed by the encryption of k_ptxt
    k_ctxt_len = sizeof(p->num_sectors) + k_ptxt_len + ctx_overhead();
    if ((k_ctxt = malloc(k_ctxt_len)) == NULL) goto cleanup;
    memset(k_ctxt, 0, k_ctxt_len);

    k_mac_len = EVP_MAX_MD_SIZE;
    if ((k_mac = malloc(k_mac_len)) == NULL) goto cleanup;
    memset(k_mac, 0, k_mac_len);
    
    // copy the number of blocks in the file into output
    memcpy(k_ctxt, &(p->num_sectors), sizeof(p->num_sectors));
    
    // advance ptr past num_sectors, to where ciphertext will go
    tmp_ptr = k_ctxt + sizeof(p->num_sectors);
    len = k_ctxt_len - sizeof(p->num_sectors);
    
    /// @todo fix NULL iv    
    if (encrypt_then_mac(key->k_enc, key->k_enc_size, key->k_mac, 
                         key->k_mac_size, k_ptxt, k_ptxt_len, tmp_ptr, &len,
                         k_mac, &k_mac_len, NULL, 0) != 0) goto cleanup;
    tmp_ptr = NULL;
    
    // get length of what was output into k_ctxt
    k_ctxt_len = len + sizeof(p->num_sectors);

    // create buffer to hold total output
    buf_len = sizeof(k_ctxt_len) + k_ctxt_len + sizeof(k_mac_len) + k_mac_len;
    if ((buf = malloc(buf_len)) == NULL) goto cleanup;

    // write k_ctxt and k_mac into output buffer
    tmp_ptr = buf;
    memcpy(tmp_ptr, &k_ctxt_len, sizeof(k_ctxt_len));
    tmp_ptr += sizeof(k_ctxt_len);
    memcpy(tmp_ptr, k_ctxt, k_ctxt_len);
    tmp_ptr += k_ctxt_len;
    memcpy(tmp_ptr, &k_mac_len, sizeof(k_mac_len));
    tmp_ptr += sizeof(k_mac_len);
    memcpy(tmp_ptr, k_mac, k_mac_len);
    tmp_ptr = NULL;
    
    // write output buffer
    fwrite(&buf_len, sizeof(buf_len), 1, file);
    if (ferror(file)) goto cleanup;
    fwrite(buf, buf_len, 1, file);
    if (ferror(file)) goto cleanup;
    status = 0;

#ifdef _PDP_DEBUG
    DEBUG(1, "\n Wrote Key File - ");
    DEBUG(1, "\n  CTXT Length [%d]",  k_ctxt_len);
    DEBUG(1, "\n  MAC Length [%d]",  k_mac_len);
    DEBUG(1, "\n  Num Sectors Length [%d]",  p->num_sectors);
    for(i=0; i < p->num_sectors; i++) {
        DEBUG(1, "\n Sector %02d", i);
        DEBUG(1, "\n  Alpha Size [%d]",  BN_num_bytes(td->alpha[i]));
        DEBUG(1, "\n  Alpha (hex) [%s]", BN_bn2hex(td->alpha[i]));
    }
#endif // _PDP_DEBUG

cleanup:
    sfree(alpha, alpha_len);
    sfree(k_ptxt, k_ptxt_len);
    sfree(k_ctxt, k_ctxt_len);
    sfree(k_mac, k_mac_len);
    sfree(buf, buf_len);
    if (file) fclose(file);
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
int cpor_key_open(const pdp_ctx_t *ctx, pdp_key_t *k, pdp_key_t *pub,
                  const char* path)
{
    char pri_keypath[MAXPATHLEN]; // path to pri key data
    char pub_keypath[MAXPATHLEN]; // path to pub key data
    int err = -1;

    if (!is_cpor(ctx) || !path || (strlen(path) > MAXPATHLEN))
        return -1;
    
    // Check 'path' exists and derive names for key data files
    err = get_key_paths(pri_keypath, sizeof(pri_keypath),
                        pub_keypath, sizeof(pub_keypath), path, "cpor");
    if (err) goto cleanup;
    if (access(pri_keypath, F_OK) && access(pub_keypath, F_OK)) goto cleanup;

    if (k) {
        err = cpor_pri_key_open(ctx, k, pri_keypath);
        if (err) goto cleanup;
    }
    if (pub) {
        err = cpor_pub_key_open(ctx, pub, pub_keypath);
        if (err) goto cleanup;    
    }
    return 0;

cleanup:
    cpor_key_free(ctx, k);
    cpor_key_free(ctx, pub);
    return -1;
}


/**
 * @brief Destroy and free key material.
 * @param[in]       ctx   context
 * @param[in,out]   k     keydata
 * @return 0 on success, non-zero on error
 **/
int cpor_key_free(const pdp_ctx_t *ctx, pdp_key_t *k)
{
    pdp_cpor_key_t *key = NULL;
    pdp_cpor_ctx_t *p = NULL;

    if (!k || !k->cpor)
        return -1;
    p = ctx->cpor_param;
    key = k->cpor;

    if (key->Zp) BN_clear_free(key->Zp);
    sfree(key->k_enc, p->enc_key_size);
    sfree(key->k_mac, p->mac_key_size);

    sfree(key, sizeof(pdp_cpor_key_t));
    CRYPTO_cleanup_all_ex_data();
    return 0;
}

/** @} */
