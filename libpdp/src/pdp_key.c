/**
 * @file
 * Support routines for managing PDP keys and secrets.
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
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>
#include <stdlib.h>
#include <termios.h>
#include <paths.h>
#include <signal.h>
#include <arpa/inet.h>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>
#include <openssl/aes.h>
#include "pdp_misc.h"


/**
 * @brief Display the prompt and read a password from the terminal.
 * 
 * @param[in] prompt   an optional user prompt to display
 * @param[out] passwd  a pre-allocated output buffer for the password
 * @param[in] len      the size of the allocated buffer
 * @return 0 on success, non-zero on error
 **/
int pdp_read_password(const char *prompt, unsigned char *passwd, size_t len)
{
    FILE *term = NULL;
    sigset_t saved_signals, set_signals;
    struct termios saved_term;
    struct termios set_term;
    int termfd = -1;
    char ch = 0;
    int ctr = 0;
    int status = -1;
    
    if (!passwd || !len)
        return -1;
    
    // Open the terminal
    if ((term = fopen(_PATH_TTY, "r+")) == NULL)
        goto cleanup;

    // Get the file descriptor
    termfd = fileno(term);
    
    // Display the prompt
    if (prompt) {
        fprintf(term, "%s", prompt);
        fflush(term);
    }
    
    // Turn off interuption
    sigemptyset(&set_signals);
    sigaddset(&set_signals, SIGINT);
    sigaddset(&set_signals, SIGTSTP);
    sigprocmask(SIG_BLOCK, &set_signals, &saved_signals);
    
    // Save state and turn off echo
    tcgetattr(termfd, &saved_term);
    set_term = saved_term;
    set_term.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL);
    tcsetattr(termfd, TCSAFLUSH, &set_term);
    
    /* Get the password off the terminal */
    for(;;) {
        if (ctr >= len) goto cleanup;
        switch(read(termfd, &ch, 1)) {
            case 1:
                if (ch != '\n') break;
            case 0:
                passwd[ctr] = '\0';
                goto done;
            default:
                goto cleanup;
        }
        passwd[ctr] = ch;
        ctr++;
    }

done:
    fprintf(term, "\n");
    status = 0;

    // Re-set the state of the term
    tcsetattr(termfd, TCSAFLUSH, &saved_term);
    sigprocmask(SIG_SETMASK, &saved_signals, 0);
    
cleanup:
    if (term) fclose(term);
    return status;
}


/**
 * @brief Gets a password from the user, and writes it to a pre-allocated
 *        output buffer.
 *
 * If an option is set, uses the (unsafe) method of fetching the user
 * password from an environment variable, instead.
 *
 * @param[in]  ctx        context for the requst
 * @param[out] passwd     a pre-allocated output buffer
 * @param[in]  len        the size of the pre-allocated buffer
 * @return 0 on success, non-zero on error
 **/
int pdp_get_passphrase(const pdp_ctx_t *ctx, char *passwd, size_t len)
{
    char *passwd2 = NULL;
    char *tmp = NULL;
    int status = -1;
    int interactive = 1;
    int got_password = 0;
    
    if (!ctx || !passwd || !len)
        return -1;

    interactive = (ctx->opts & PDP_PW_NOINPUT) ? 0 : 1;
    if ((passwd2 = malloc(len)) == NULL)
        goto cleanup;

    // Get passphrase from the user, by default
    while (!got_password && interactive) {
        memset(passwd, 0, len);
        memset(passwd2, 0, len);
        if (pdp_read_password("Enter passphrase:", (unsigned char *) passwd, len))
            goto cleanup;
        if (pdp_read_password("Re-enter passphrase:", (unsigned char *) passwd2, len))
            goto cleanup;
        if (strncmp(passwd, passwd2, len) != 0) {
            fprintf(stdout, "Passphrases do not match.  Try again.\n");
        } else {
            got_password = 1;
        }
    }
    // Get password non-interactively (if requested)
    if (!interactive) {
        tmp = getenv("RSA_ACCESS_KEY");
        if (tmp == NULL) {
            PDP_ERR("RSA_ACCESS_KEY environment variable not set");
            goto cleanup;
        } else if (strlen(tmp) >= sizeof(passwd)) {
            PDP_ERR("RSA_ACCESS_KEY value is too long");
            goto cleanup;
        } else {
            strncpy(passwd, tmp, len);
        }
    }
    status = 0;

cleanup:
    sfree(passwd2, len);
    return status;
}


/**
 * @brief Generates expected filenames for keys based on path.
 * @param[out]  pri_path    output buffer for key path
 * @param[in]   pri_len     size of available buffer at pri_keypath
 * @param[out]  pub_path    output buffer for key path
 * @param[in]   pub_len     size of available buffer at pub_keypath
 * @param[in]   kpath       base path for key files
 * @param[in]   name        base name for the key file
 * @return 0 on success, non-zero on error
 **/
int get_key_paths(char *pri_path, size_t pri_len, 
                  char *pub_path, size_t pub_len,
                  const char *kpath, const char *name)
{
    char *path = strdup(kpath);
    size_t len = strlen(path);
    int status = -1;

    // strip off trailing slash
    if ((len > 0) && (path[len-1] == '/'))
        path[len-1] = '\0';
    
    if ((access(path, F_OK) != 0) && (mkdir(path, 0700) < 0)) {
        PDP_ERR("Could not create directory '%s'", path);
        goto cleanup;
    }
    if (snprintf(pri_path, pri_len, "%s/%s.pri", path, name) + 1 > pri_len)
        goto cleanup;
    if (snprintf(pub_path, pub_len, "%s/%s.pub", path, name) + 1 > pub_len)
        goto cleanup;
    status = 0;

cleanup:
    free(path);
    return status;
}


/**
 * @brief A support function for PBKDF2()
 *
 * Implements the 'F' function in the PKCS5-PBKDF2 spec,
 * for calculating the intermediate digests, round-by-round.
 *
 * @param[out]    T         output buffer, holding intermediate SHA digest
 * @param[in]     pw        buffer holding a passphrase
 * @param[in]     pw_len    length of pw
 * @param[in]     salt      buffer holding the salt
 * @param[in]     salt_len  length of salt
 * @param[in]     c         number of rounds
 * @param[in]     i         value of current round
 * @return 0 on success, non-zero on error
 **/
static int PBKDF2_F(unsigned char *T, unsigned char *pw, size_t pw_len,
                    unsigned char *salt, size_t salt_len, int c, int i)
{
    size_t h_len = SHA_DIGEST_LENGTH;
    unsigned char U[SHA_DIGEST_LENGTH];
    unsigned char *U1 = NULL;
    unsigned int swapped_i = 0;
    unsigned int U_len = 0;
    int j, k;
    
    if (!T || !pw || !pw_len || !salt || !salt_len || !c)
        return -1;
    
    if ((U1 = malloc(salt_len + sizeof(unsigned int))) == NULL)
        return -1;

    memset(U, 0, h_len);
    memset(U1, 0, salt_len + sizeof(int));
    
    // Cat the salt and swapped byte-order of i
    swapped_i = htonl(i);
    memcpy(U1, salt, salt_len);
    memcpy(U1 + salt_len, &swapped_i, sizeof(unsigned int));
    
    // Initial U value,  U_1 = PRF(P, S | i)
    HMAC(EVP_sha1(), pw, pw_len, U1, 
         salt_len + sizeof(unsigned int), U, &U_len);
    if (U_len != h_len) goto cleanup;
    
    for(j = 0; j < c; j++){
        // XOR the last value of U into T, the final U value
        for(k = 0; k < h_len; k++)
            T[k] ^= U[k];
        // U_i = PRF(P, U_i-c)
        HMAC(EVP_sha1(), pw, pw_len, U, h_len, U, &U_len);
        if (U_len != h_len) goto cleanup;
    }
    // Perform the final XOR
    for (k = 0; k < h_len; k++)
        T[k] ^= U[k];

    sfree(U1, salt_len + sizeof(unsigned int));
    return 0;

cleanup:
    sfree(U1, salt_len + sizeof(unsigned int));
    return -1;
}


/**
 * @brief PKCS5-PBKDF2 password-based key derivation.
 *
 * The underlying PRF used is HMAC-SHA1.
 * 
 * @param[out] key        pointer to the derived key
 * @param[in]  dkey_len   desired length for key in bytes
 * @param[in]  pw         pointer to passphrase to use
 * @param[in]  pw_len     length of pw in bytes
 * @param[in]  salt       salt to use
 * @param[in]  salt_len   length of salt in bytes
 * @param[in]  c          number of iterations
 * @return 0 on success, non-zero on error
 **/
int PBKDF2(unsigned char **key, size_t dkey_len,
           unsigned char *pw, size_t pw_len, 
           unsigned char *salt, size_t salt_len, unsigned int c)
{
    int i;
    unsigned int l = 0;
    // unsigned int r = 0; // @TODO appears unused
    unsigned char *dk = NULL;
    unsigned char T[SHA_DIGEST_LENGTH];
    size_t h_len = SHA_DIGEST_LENGTH;
    size_t remaining_bytes = dkey_len;

    if (!key || !dkey_len || !pw || !pw_len || !salt || !salt_len || !c )
        return -1;

    // @NOTE the spec says we should ensure dkey_len <= (2^32 - 1) * hLen
    // but size_t is small enough on most arch that this is not the case

    if ((dk = malloc(dkey_len)) == NULL) return -1;
    memset(dk, 0, dkey_len);
    memset(T, 0, sizeof(T));

    // derive l, the number of SHA blocks in the derived key
    l = (dkey_len/h_len);
    if (dkey_len % h_len) {
        l++;
    }
    // derive remainder r, the number of bytes in the last block
    // r = dkey_len - ((l - 1) * h_len); // @TODO appears unused
    
    // Compute T_i
    for (i = 0; i < l; i++) {
        if (PBKDF2_F(T, pw, pw_len, salt, salt_len, c, i) != 0)
            goto cleanup;
        // Add T_i to the derived key
        if (remaining_bytes >= h_len) {
            memcpy(dk + (i * h_len), T, h_len);
            remaining_bytes -= h_len;
        } else {
            memcpy(dk + (i * h_len), T, remaining_bytes);
            remaining_bytes -= remaining_bytes;
        }
    }
    *key = dk;
    return 0;
    
cleanup:
    sfree(dk, dkey_len);
    return -1;
}


/** 
 * @brief Performs the NIST AES Key Wrap to securely and authentically 
 * encrypt a key for storage on an unstrusted medium, e.g. a disk.
 *
 * @param[out] enc      points to an allocated buffer containing the encrypted key,
 * @param[out] enc_len  size allocated / written to enc (key_len + 8 bytes)
 * @param[in] key       key to be encrypted
 * @param[in] key_len   size of key in bytes (at least 128 bits)
 * @param[in] kek       key encrypting key, used with AES
 * @param[in] kek_len   size of kek in bytes (128, 192, 256 bits)
 * @return 0 on success, non-zero on error
 **/
int pdp_key_wrap(unsigned char** enc, size_t *enc_len,
                 unsigned char *key, size_t key_len, 
                 unsigned char *kek, size_t kek_len)
{
    unsigned int i, j, n, t;
    unsigned char *r_array = NULL; // Wrap registers
    unsigned char *c_array = NULL; // Ciphertext
    AES_KEY aes_key;
    unsigned char aes_input[AES_BLOCK_SIZE];
    unsigned char aes_output[AES_BLOCK_SIZE];
    unsigned char A[8];

    if (!enc || !key || key_len < 16 || !kek || !kek_len)
        return -1;

    // Set the A to the magic number
    memset(A, 0xA6, 8);
    memset(&aes_key, 0, sizeof(AES_KEY));
    memset(aes_input, 0, sizeof(aes_input));
    memset(aes_output, 0, sizeof(aes_output));
        
    // n = the number of 64 bit values in key
    n = (key_len/8);
    if (key_len % 8) n++;

    // Set up the R array, n 64 bit blocks 
    if ((r_array = malloc(8*n)) == NULL)
        goto cleanup;
    memcpy(r_array, key, (8*n));

    // Turn the KEK into an AES key
    if (AES_set_encrypt_key(kek, 8*kek_len, &aes_key) != 0)
        goto cleanup;
        
    for(j = 0; j < 6; j++) {
        for(i = 0; i < n; i++) {
            // Copy A into the first 64 bits of the input
            memcpy(aes_input, A, 8);
            
            // Copy R_i into the second 64 bits of the input
            memcpy((aes_input + 8), (r_array + (i*8)), 8);
            
            // AES(A | R_i)
            AES_encrypt(aes_input, aes_output, &aes_key);

            // Put the 64 most significant bits from the output into A
            memcpy(A, aes_output, 8);
            
            // XOR A and t, where t = (n * j) + i 
            t = ((n * j) + (i + 1));
            A[7] = A[7] ^ t;

            // R_i gets the least significat 64 bits of the aes_output
            memcpy((r_array + (i*8)), (aes_output + 8), 8);     
        }
    }
    
    // Set up the C array, n + 1 64 bit blocks
    if ((c_array = malloc(8*(n+1))) == NULL)
        goto cleanup;

    // C_0 gets A
    memcpy(c_array, A, 8);
    // C_i gets R_i
    memcpy((c_array + 8), r_array, 8*n);    
    *enc = c_array;
    if (enc_len) *enc_len = 8*(n+1);

    sfree(r_array, 8*n);
    return 0;
    
cleanup:
    sfree(r_array, 8*n);
    sfree(c_array, (8*(n+1)));
    return -1;
}


/** 
 * @brief Performs the NIST AES Key Wrap unwraping function used to securely and 
 *        authentically decrypt a key that has been wrapped.
 *
 * @param[out] key      a newly allocated buffer for the (decrypted) key
 * @param[out] key_len  size of output buffer in bytes (ekey_len - 8 bytes)
 * @param[in] ekey      the encrypted key, to be decrypted
 * @param[in] ekey_len  size of ekey in bytes (original key + 8 bytes)
 * @param[in] kek       the key-encryption-key
 * @param[in] kek_len   size of kek in bytes (128, 192, 256 bits)
 * @return 0 on success, non-zero on error
 **/
int pdp_key_unwrap(unsigned char **key, size_t *key_len,
                   unsigned char *ekey, size_t ekey_len,
                   unsigned char *kek, size_t kek_len)
{
    AES_KEY aes_key;
    unsigned char A[8], A_check[8];
    unsigned char aes_input[AES_BLOCK_SIZE];
    unsigned char aes_output[AES_BLOCK_SIZE];
    unsigned char *r_array = NULL; // Wrap registers
    unsigned int n, t;
    int i, j, status = -1;

    if (!key || !key_len || !ekey || !ekey_len || !kek || !kek_len)
        return -1;

    // Set the A_check to the magic number
    memset(A_check, 0xA6, 8);
    memset(aes_input, 0, sizeof(aes_input));
    memset(aes_output, 0, sizeof(aes_output));
    memset(&aes_key, 0, sizeof(AES_KEY));
        
    // set n = the number of 64 bit values in key
    n = (ekey_len/8) - 1;
    if (ekey_len % 8) n++;
    
    // Set up the R array = n 64 bit blocks
    if ((r_array = malloc(8*n)) == NULL)
        goto cleanup;   
    // Setup the AES key
    if (AES_set_decrypt_key(kek, 8*kek_len, &aes_key) != 0)
        goto cleanup;   

    // Initialize A and R arrays
    memcpy(A, ekey, 8);
    memcpy(r_array, ekey + 8, n*8);

    for (j = 5; j >= 0; j--) {
        for (i = (n-1); i >= 0; i--) {
            // XOR A and t, where t = (n * j) + i
            t = ((n * j) + (i + 1));
            A[7] = A[7] ^ t;
            // Copy A XOR t into the first 64 bits of the input
            memcpy(aes_input, A, 8);
            // Copy R_i into the second 64 bits of the input
            memcpy((aes_input + 8), (r_array + (i*8)), 8);
            // AES-1(A | R_i)
            AES_decrypt(aes_input, aes_output, &aes_key);
            // Get the 64 most significant bits from output and put them in A
            memcpy(A, aes_output, 8);
            // R_i gets the least significat 64 bits of the aes_output
            memcpy((r_array + (i*8)), (aes_output + 8), 8);     
        }
    }
    // Perform an integrity check on A
    if (memcmp(A, A_check, 8) != 0) goto cleanup;

    *key = r_array;
    if (key_len) *key_len = 8*n;
    status = 0;
    
cleanup:
    if (status) {
        sfree(r_array, 8*n);
    }
    return status;
}


/** 
 * @brief Performs basic Encrypt-then-MAC style Authenticated Encryption.
 *
 * @param[in] ekey          a buffer holding the ENC key
 * @param[in] ekey_len      len of ekey buffer
 * @param[in] mkey          a buffer holding the MAC key
 * @param[in] mkey_len      len of mkey buffer
 * @param[in] input         the plaintext message
 * @param[in] input_len     len of message buffer
 * @param[in,out] ctxt      an allocated buffer, will hold the ciphertext
 * @param[in,out] ctxt_len  length of buffer, will hold length of ciphertext
 * @param[in,out] mac       an allocated buffer, will hold the MAC
 * @param[in,out] mac_len   length of buffer, will hold length of MAC
 * @param[in,out] iv        a randomly chosen iv (optional)
 * @param[in] iv_len        length of buffer for iv (optional)
 * @return 0 on success, non-zero on error
 **/
int encrypt_then_mac(const unsigned char *ekey, size_t ekey_len, 
                     const unsigned char *mkey, size_t mkey_len,
                     const unsigned char *input, size_t input_len,
                     unsigned char *ctxt, size_t *ctxt_len,
                     unsigned char *mac, size_t *mac_len,
                     unsigned char *iv, size_t iv_len)
{
    EVP_CIPHER_CTX *ctx;
    ctx = EVP_CIPHER_CTX_new();
    EVP_CIPHER *cipher = NULL;
    int len;
    
    if (!ekey || !ekey_len || !mkey || !mkey_len || 
        !input_len || !ctxt || !ctxt_len || !mac || !mac_len)
        return -1;
    
    OpenSSL_add_all_algorithms();
    
    EVP_CIPHER_CTX_init(ctx);
    switch(ekey_len){
        case 16:
            cipher = (EVP_CIPHER *)EVP_aes_128_cbc();
            break;
        case 24:
            cipher = (EVP_CIPHER *)EVP_aes_192_cbc();
            break;
        case 32:
            cipher = (EVP_CIPHER *)EVP_aes_256_cbc();
            break;
        default:
            return -1;
    }

    if (iv && iv_len) {
        if (!RAND_bytes(iv, iv_len)) goto cleanup;
    }

    if (!EVP_EncryptInit(ctx, cipher, ekey, iv)) goto cleanup;    

    *ctxt_len = 0;
    if (!EVP_EncryptUpdate(ctx, ctxt, (int *) ctxt_len, input, input_len))
        goto cleanup;
    EVP_EncryptFinal(ctx, ctxt + *ctxt_len, &len);
    *ctxt_len += len;
    
    // Do the HMAC-SHA1
    *mac_len = 0;
    if (!HMAC(EVP_sha1(), mkey, mkey_len, ctxt, *ctxt_len,
                          mac, (unsigned int *) mac_len))
        goto cleanup;
    EVP_CIPHER_CTX_cleanup(ctx);
    return 0;
    
cleanup:
    if (ctxt_len) *ctxt_len = 0;
    if (mac_len) *mac_len = 0;
    return 1;
}

/** 
 * @brief Performs basic Encrypt-then-MAC style Authenticated Encryption.
 *
 * @param[in] ekey            a buffer holding the ENC key
 * @param[in] ekey_len        len of ekey buffer
 * @param[in] mkey            a buffer holding the MAC key
 * @param[in] mkey_len        len of mkey buffer
 * @param[in] ctxt            a buffer holding the ciphertext
 * @param[in] ctxt_len        length of ciphertext
 * @param[in] mac             a buffer holding the MAC
 * @param[in] mac_len         length of MAC
 * @param[in] iv              an iv (optional)
 * @param[in] iv_len          length of iv (optional)
 * @param[out] output         an allocated buffer, will hold the plaintext
 * @param[in,out] output_len  length of buffer, will hold length of plaintext
 * @return 0 on success, non-zero on error
 **/
int verify_then_decrypt(const unsigned char *ekey, size_t ekey_len, 
                        const unsigned char *mkey, size_t mkey_len,
                        const unsigned char *ctxt, size_t ctxt_len,
                        const unsigned char *mac, size_t mac_len,
                        const unsigned char *iv, size_t iv_len,
                        unsigned char *output, size_t *output_len)
{
    EVP_CIPHER_CTX *ctx;
    ctx = EVP_CIPHER_CTX_new();
    EVP_CIPHER *cipher = NULL;
    unsigned char auth[EVP_MAX_MD_SIZE];
    size_t auth_len = EVP_MAX_MD_SIZE;
    int len;
    
    if (!ekey || !ekey_len || !mkey || !mkey_len || 
        !ctxt || !ctxt_len || !mac || !mac_len || !output || !output_len)
        return -1;
    
    OpenSSL_add_all_algorithms();
    memset(auth, 0, auth_len);

    // Verify the HMAC-SHA1
    if (!HMAC(EVP_sha1(), mkey, mkey_len, ctxt, ctxt_len, 
              auth, (unsigned int *) &auth_len))
        goto cleanup;
    if (auth_len != mac_len) goto cleanup;
    if (memcmp(mac, auth, mac_len) != 0) goto cleanup;

    EVP_CIPHER_CTX_init(ctx);
    switch(ekey_len){
        case 16:
            cipher = (EVP_CIPHER *)EVP_aes_128_cbc();
            break;
        case 24:
            cipher = (EVP_CIPHER *)EVP_aes_192_cbc();
            break;
        case 32:
            cipher = (EVP_CIPHER *)EVP_aes_256_cbc();
            break;
        default:
            return -1;
    }
    if (*output_len < ctxt_len) goto cleanup;
    *output_len = 0;

    if (!EVP_DecryptInit(ctx, cipher, ekey, iv)) goto cleanup;
    if (!EVP_DecryptUpdate(ctx, output, (int *) output_len, 
                           ctxt, ctxt_len)) goto cleanup;
    EVP_DecryptFinal(ctx, output + *output_len, &len);
    *output_len += len;
    
    EVP_CIPHER_CTX_cleanup(ctx);
    return 0;
    
cleanup:
    *output_len = 0;
    return 1;
}

/** @} */
