/**
 * @file
 * A simple utility for benchmarking PDP operations.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
#include <stdio.h>
#include <string.h>
#include <getopt.h>
#include <libgen.h>
#include <pdp.h>
#include <pdp/macpdp.h>
#include <pdp/apdp.h>
#include <pdp/sepdp.h>
#include <pdp/cpor.h>
#include "time_it.h"

//
// Constants
//
#define POR_OP_NOOP     0x00 ///< no operation selected
#define POR_OP_TAG      0x01 ///< tagging operation
#define POR_OP_CHA      0x02 ///< challenge operation
#define POR_OP_VER      0x04 ///< verify operation
#define POR_OP_PRF      0x08 ///< proof operation
#define POR_LOOP        0x10 ///< cpu tests


/// Macro to print output to stdout, based on a condition.
#define VERBOSE(c, ...) \
    do { \
        if (c) { \
            fprintf(stdout, __VA_ARGS__); \
            fflush(stdout); \
        } \
    } while(0)


/// Macro for printing errors to stderr.
#define ERROR(...) \
    do { \
        fprintf(stderr, "\n%s: ", __FUNCTION__); \
        fprintf(stderr, __VA_ARGS__); \
        fprintf(stderr, "\n"); \
        fflush(stderr); \
    } while(0)


/// argv options
static struct option long_opts[] = {
    // 0
    {"algo", required_argument, NULL, 'a'},
    {"filename", required_argument, NULL, 'f'},
    {"filesize", required_argument, NULL, 'n'},
    {"key", required_argument, NULL, 'k'},
    {"noninteractive", no_argument, NULL, '*'},
    {"help", no_argument, NULL, 'h'},
    {"verbose", no_argument, NULL, 'v'},
    {"tag", no_argument, NULL, 'T'},
    {"challenge", no_argument, NULL, 'C'},
    {"prove", no_argument, NULL, 'P'},
    // 10
    {"verify", no_argument, NULL, 'V'},
    {"timing_output", required_argument, NULL, 't'},
    {"timing_data", required_argument, NULL, 'd'},
    {"cpu", required_argument, NULL, 'c'},
    {"cparam", required_argument, NULL, 'l'},
    {"blocksize", required_argument, NULL, 'b'},
    {"sectorsize", required_argument, NULL, 'm'},
    {"prf_key_size", required_argument, NULL, '4'},
    {"prp_key_size", required_argument, NULL, '5'},
    {"rsa_key_size", required_argument, NULL, '6'},
    // 20
    {"enc_key_size", required_argument, NULL, '7'},
    {"mac_key_size", required_argument, NULL, '8'},
    {"lambda", required_argument, NULL, '~'},
    {"apdp_no_safe", no_argument, NULL, '!'},
    {"apdp_use_epdp", no_argument, NULL, '#'},
    {"minutes", required_argument, NULL, 'M'},
    {"year", required_argument, NULL, 'Y'},
#ifdef _THREAD_SUPPORT
    {"numthreads", required_argument, NULL, 'r'},
#endif
#ifdef _S3_SUPPORT
    {"s3", no_argument, NULL, '3'},
    {"https", no_argument, NULL, '$'},
#endif
    {0, 0, 0, 0}
};

//
// Useage message
//
#define opts_len (sizeof(long_opts) / sizeof(struct option))

typedef struct {
    int index;
    const char *name;
} opts_desc_t;

/// A data structure that organizes long_opts into a help menu
const opts_desc_t opts_desc[] = {
    {-1, "Required arguments"},
    {0, " [MAC-PDP, APDP, SEPDP, CPOR], select the algorithm"},
    {1, " [filename], the name of file to process"},
    {-1, "Operation arguments"},
    {7, ", tag the file"},
    {8, ", challenge the file"},
    {9, ", generate a proof in response to a challenge"},
    {10, ", verify the file"},
    {-1, "generic OPTIONS"},
    {5, ", display this usage message"},
    {6, ", send verbose messages to stdout"},
    {2, " [bytes], manually input file size (e.g., using -C with no -T)"},
    {3, " [filepath], use filepath to open or store saved key data"},
#ifdef _THREAD_SUPPORT
    {opts_len-4, " [num], number of threads (defaults to core count)"},
#endif
#ifdef _S3_SUPPORT
    {opts_len-3, ", use S3 for storage (default is flat file storage)"},
    {opts_len-2, ", force using HTTPS"},
#endif
    {-1, "benchmarking OPTIONS"},    
    {11, " [filename], output timing data"},
    {12, " [w, a], either overwrite or append timing data"},
    {13, " [loops], run operation 'loops' times, for cpu utilization data"},
    {4, ", use passphrase stored in the environment to open key files"},
    {-1, "algorithm OPTIONS"},
    {15, " [num], select non-default block size"},
    {14, " [num], select non-default challenge param"},
    {-1, "MAC-PDP algorithm OPTIONS"},
    {17, " [bytes], PRF key length"},
    {-1, "APDP algorithm OPTIONS"},
    {17, " [bytes], PRF key length"},
    {18, " [bytes], PRP key length"},
    {19, " [bits], RSA key length (APDP)"},
    {20, " [bytes], encryption key length"},
    {23, ", no provable security / faster key generation (APDP)"},
    {24, ", use a weaker protocol, the E-PDP variant (of APDP)"},
    {-1, "CPOR algorithm OPTIONS"},
    {16, " [num], select non-default sector size (CPOR)"},
    {22, " [bits], bit-length of prime over which Z_p is generated (CPOR)"},
    {17, " [bytes], PRF key length"},
    {20, " [bytes], encryption key length"},
    {21, " [bytes], MAC key length"},
    {-1, "SEPDP algorithm OPTIONS"},
    {17, " [bytes], PRF key length"},
    {18, " [bytes], PRP key length"},
    {20, " [bytes], encryption key length"},
    {25, " [num], number of years for the audit period"},
    {26, " [num], minutes elapsed between audits"},
};

void usage(const char* arg, int x)
{
    int i;
    printf("%s, built using %s (%s)\n", 
            basename((char *)arg), LIBPDP_NAME, LIBPDP_VERS);
    printf("%s", "Usage: ");
    printf("%s -a [algo] -f [file] [operations] [OPTIONS], where\n", arg);
    for (i = 0; i < sizeof(opts_desc) / sizeof(opts_desc_t); i++) {
        if (opts_desc[i].index < 0) {
            printf("  %s\n", opts_desc[i].name);
        } else {
            printf("\t-%c, --%s%s\n", long_opts[opts_desc[i].index].val, 
                long_opts[opts_desc[i].index].name, opts_desc[i].name);
        }
    }    
    exit(x);
}


/// a struct, to store argv params
typedef struct {
    unsigned short verb;
    unsigned short ops;
    unsigned short noninteractive;
    unsigned short force_https;
    unsigned int file_st_size;
    unsigned int alg;
    unsigned int block_size;
    unsigned int sector_size;
    unsigned int numfileblocks;
    unsigned int num_threads;
    unsigned int num_loops;
    unsigned int cparam;
    unsigned short s3;
    unsigned int prf_key_size;
    unsigned int prp_key_size;
    unsigned int apdp_opts;
    unsigned int rsa_key_size;
    unsigned int aes_key_size;
    unsigned int enc_key_size;
    unsigned int mac_key_size;
    unsigned int lambda;
    unsigned int minutes;
    unsigned int year;
    char *algo;
    char *filename;
    char *keypath;
    char *timing_filename;
    char *timing_data_opt;
} param_t;


/**
 * @brief A program used to test and benchmark libpdp.
 **/
int main(int argc, char **argv)
{
    struct stat statbuf;
    char meta[MAX_CSV_CELL] = {0};
    pdp_ctx_t context, *ctx = &context;
    pdp_key_t key, pk;
    pdp_tag_t tag;
    pdp_challenge_t ver_chal; // holds the verifier's challenge data
    pdp_challenge_t prv_chal; // the public challenge for the prover
    pdp_proof_t proof;
    param_t params;
    int i, key_stat, error = 0;
    int proof_stat = -1;
    int opt = -1;

    memset(&statbuf, 0, sizeof(struct stat));
    memset(&context, 0, sizeof(pdp_ctx_t));
    memset(&key, 0, sizeof(pdp_key_t));
    memset(&pk, 0, sizeof(pdp_key_t));
    memset(&tag, 0, sizeof(pdp_tag_t));
    memset(&ver_chal, 0, sizeof(pdp_challenge_t));
    memset(&prv_chal, 0, sizeof(pdp_challenge_t));
    memset(&proof, 0, sizeof(pdp_proof_t));
    memset(&params, 0, sizeof(param_t));

    //
    // initialize vars and sensible defaults
    //
    params.algo = "MAC-PDP";
    params.ops = POR_OP_NOOP;
    params.verb = 1;
    params.timing_data_opt = "a";
    params.timing_filename = "pdp-timing-data.csv";
    params.filename = NULL;
    params.keypath = NULL;
    params.num_threads = 1;
    params.num_loops = 1;
    params.force_https = 0;
    time_it_init();

    if (argc < 2) {
        usage(argv[0], -1);
        return -1;
    }

    while ((opt = getopt_long(argc, argv, "a:b:c:d:ef:hk:l:m:n:r:t:vCM:PTVY:3"
                              "4:5:6:7:8:~:*!#$", long_opts, NULL)) != -1) {
        switch(opt) {
            case 'a':
                params.algo = optarg;
                break;
            case 'b':
                params.block_size = atoi(optarg);
                break;
            case 'c':
                params.ops |= POR_LOOP;
                params.num_loops = atoi(optarg);
                break;
            case 'd':
                params.timing_data_opt = optarg;
            case 'f':
                params.filename = optarg;
                break;
            case 'h':
                usage(argv[0], 0);
                return 0;
                break;
            case 'k':
                params.keypath = optarg;
                break;
            case 'l':
                params.cparam = atoi(optarg);
                break;
            case 'm':
                params.sector_size = atoi(optarg);
                break;
            case 'n':
                params.file_st_size = atoi(optarg);
                break;
            case 'r':
                params.num_threads = atoi(optarg);
                break;
            case 't':
                params.timing_filename = optarg;
                break;
            case 'v':
                params.verb = 1;
                break;
            case 'C':
                params.ops |= POR_OP_CHA;
                break;
            case 'M':
                params.minutes = atoi(optarg);
                break;
            case 'P':
                params.ops |= POR_OP_PRF;
                break;
            case 'T':
                params.ops |= POR_OP_TAG;
                break;
            case 'V':
                params.ops |= POR_OP_VER;
                break;
            case 'Y':
                params.year = atoi(optarg);
                break;
            case '3':
                params.s3 = 1;
                break;
            case '4':
                params.prf_key_size = atoi(optarg);
                break;
            case '5':
                params.prp_key_size = atoi(optarg);
                break;
            case '6':
                params.rsa_key_size = atoi(optarg);
                break;
            case '7':
                params.enc_key_size = atoi(optarg);
                break;
            case '8':
                params.mac_key_size = atoi(optarg);
                break;
            case '~':
                params.lambda = atoi(optarg);
                break;
            case '*':
                params.noninteractive = 1;
                break;
            case '!':
                params.apdp_opts |= APDP_NO_SAFE_PRIMES;
                break;
            case '#':
                params.apdp_opts |= APDP_USE_E_PDP;
                break;
            case '$':
                params.force_https = 1;
                break;
            default:
                usage(argv[0], -1);
                return -1;
                break;
        }
    }

    //
    // parse algorithm options
    //
    if (strncmp(params.algo, "MAC-PDP", strlen("MAC-PDP")) == 0) {
        params.alg = PDP_MACPDP;
    } else if (strncmp(params.algo, "APDP", strlen("APDP")) == 0) {
        params.alg = PDP_APDP;
    } else if (strncmp(params.algo, "SEPDP", strlen("SEPDP")) == 0) {
        params.alg = PDP_SEPDP;
    } else if (strncmp(params.algo, "CPOR", strlen("CPOR")) == 0) {
        params.alg = PDP_CPOR;
    } else {
        ERROR("error: %s not a legitimate [algo]", params.algo);
        usage(argv[0], -1);
        return -1;
    }

    //
    // initialize ctx and populate context with non-default values
    //
    PDP_SELECT(ctx, params.alg);
    if ((error = pdp_ctx_init(ctx))) {
        ERROR("error: couldn't init context");
        goto cleanup;
    }
    if (params.s3) {
        ctx->opts |= PDP_OPT_USE_S3;
        if (params.force_https) {
            ctx->opts |= PDP_OPT_HTTPS;
        }
    }
    if (params.noninteractive) {
        ctx->opts |= PDP_PW_NOINPUT;
    }
    if (params.num_threads > 1) {
        ctx->num_threads = params.num_threads;
        ctx->opts |= PDP_OPT_THREADED;
    }
    ctx->verbose = params.verb;
    ctx->file_st_size = params.file_st_size;
    switch(params.alg) {
        case PDP_MACPDP:
            if (params.block_size)
                ctx->macpdp_param->block_size = params.block_size;
            if (params.cparam)
                ctx->macpdp_param->num_challenge_blocks = params.cparam;
            if (params.prf_key_size)
                ctx->macpdp_param->prf_key_size = params.prf_key_size;
            break;
        case PDP_APDP:
            if (params.block_size)
                ctx->apdp_param->block_size = params.block_size;
            if (params.cparam)
                ctx->apdp_param->num_challenge_blocks = params.cparam;
            if (params.prf_key_size)
                ctx->apdp_param->prf_key_size = params.prf_key_size;
            if (params.prp_key_size)
                ctx->apdp_param->prp_key_size = params.prp_key_size;
            if (params.rsa_key_size)
                ctx->apdp_param->rsa_key_size = params.rsa_key_size;
            if (params.apdp_opts)
                ctx->apdp_param->opts = params.apdp_opts;
            break;
        case PDP_CPOR:
            if (params.block_size)
                ctx->cpor_param->block_size = params.block_size;
            if (params.sector_size)
                ctx->cpor_param->sector_size = params.sector_size;
            if (params.cparam)
                ctx->cpor_param->num_challenge_blocks = params.cparam;
            if (params.lambda)
                ctx->cpor_param->lambda = params.lambda;
            if (params.prf_key_size)
                ctx->cpor_param->prf_key_size = params.prf_key_size;
            if (params.enc_key_size)
                ctx->cpor_param->enc_key_size = params.enc_key_size;
            if (params.mac_key_size)
                ctx->cpor_param->mac_key_size = params.mac_key_size;
        case PDP_SEPDP:
            if (params.block_size)
                ctx->sepdp_param->block_size = params.block_size;
            if (params.enc_key_size)
                ctx->sepdp_param->ae_key_size = params.enc_key_size;
            if (params.prf_key_size)
                ctx->sepdp_param->prf_key_size = params.prf_key_size;
            if (params.prp_key_size)
                ctx->sepdp_param->prp_key_size = params.prp_key_size;
            if (params.cparam)
                ctx->sepdp_param->num_challenge_blocks = params.cparam;
            if (params.year)
                ctx->sepdp_param->year = params.year;
            if (params.minutes)
                ctx->sepdp_param->min = params.minutes;
        default:
            break;
    }
    
    //
    // create default ctx
    //
    if ((error = pdp_ctx_create(ctx, params.filename, NULL))) {
        ERROR("error: couldn't create context");
        goto cleanup;
    }

    //
    // generate key
    //
    key_stat = 0;
    // if we do an op that needs a key, prepare the key
    if (params.keypath) {
        VERBOSE(params.verb, "Trying to open keys...");
        if ((error = pdp_key_open(ctx, &key, &pk, params.keypath)) != 0) {
            VERBOSE(params.verb, "None found at [%s].\n", params.keypath);
        } else {
            key_stat = 1;
            VERBOSE(params.verb, "Done.\n");
        }
    }
    if (!key_stat) {
        VERBOSE(params.verb, "Generating keys...");
        if ((error = pdp_key_gen(ctx, &key, &pk)) != 0) {
            ERROR("error: couldn't generate keys");
            goto cleanup;
        }
        VERBOSE(params.verb, "Done.\n");
    }
    if (!key_stat && params.keypath) {
        VERBOSE(params.verb, "Store keys...");
        if ((error = pdp_key_store(ctx, &key, params.keypath)) != 0) {
            ERROR("error: couldn't store keys at [%s]", params.keypath);
            goto cleanup;
        }
        VERBOSE(params.verb, "Done.\n");
    }

    //
    // output parameter header
    //
    if (params.verb) {        
        printf("\tFilename: %s\n", ctx->filepath);
        printf("\tFile Size: %ld\n", ctx->file_st_size);
        printf("\tNumber of threads: %d\n", ctx->num_threads);
        switch(params.alg) {
            case PDP_MACPDP:
                printf("\tBlocksize: %d\n", ctx->macpdp_param->block_size);
                printf("\tNumber of challenges: %d\n", 
                        ctx->macpdp_param->num_challenge_blocks);
                printf("\tKey Len: %zd\n", ctx->macpdp_param->prf_key_size);
                break;
            case PDP_APDP:
                printf("\tBlocksize: %d\n", ctx->apdp_param->block_size);
                printf("\tNumber of challenges: %d\n", 
                        ctx->apdp_param->num_challenge_blocks);
                printf("\tPRF Key Len: %zd\n", ctx->apdp_param->prf_key_size);
                printf("\tPRP Key Len: %zd\n", ctx->apdp_param->prp_key_size);
                printf("\tRSA Key Len: %zd\n", ctx->apdp_param->rsa_key_size);
                break;
            case PDP_CPOR:
                printf("\tBlocksize: %d\n", ctx->cpor_param->block_size);
                printf("\tLambda: %u\n", ctx->cpor_param->lambda);
                printf("\tPRF Key Len: %zd\n", ctx->cpor_param->prf_key_size);
                printf("\tENC Key Len: %zd\n", ctx->cpor_param->enc_key_size);
                printf("\tMAC Key Len: %zd\n", ctx->cpor_param->mac_key_size);
                break;
            case PDP_SEPDP:
                printf("\tBlocksize: %d\n", ctx->sepdp_param->block_size);
                printf("\tPRF Key Len: %zd\n", ctx->sepdp_param->prf_key_size);
                printf("\tPRP Key Len: %zd\n", ctx->sepdp_param->prp_key_size);
                printf("\tENC Key Len: %zd\n", ctx->sepdp_param->ae_key_size);
                break;
            default:
                break;
        }
    }

    //
    // prepare the file for tagging
    //
    if (params.ops & POR_OP_TAG) {
        VERBOSE(params.verb, "Pre-processing file...");
        if ((error = pdp_file_preprocess(ctx))) {
            ERROR("error: could't pre-process file");
            goto cleanup;
        }
        VERBOSE(params.verb, "Done.\n");
    }

    //
    // tagging logic
    //
    if (params.ops & POR_OP_TAG) {
        for(i = 0; i < params.num_loops; i++) {
            VERBOSE(params.verb, "Tagging file...");
TIC;
            if ((error = pdp_tags_gen(ctx, &key, &tag))) {
                ERROR("error: couldn't generate tags");
                goto cleanup;
            }
TOC("Create tag");
            VERBOSE(params.verb, "Done.\n");

            if (!(params.ops & POR_OP_TAG) || (i >= params.num_loops-1)) {
                break;
            }
            pdp_tags_free(ctx, &tag);
        }
    }

    //
    // Store the tags
    //
    if (params.ops & POR_OP_TAG) {
        // if we generated new tags, we should store them
        VERBOSE(params.verb, "Storing tag and file data...");
TIC;
        // save tag data
        if ((error = pdp_store(ctx, &key, &tag))) {
            goto cleanup;
        }
TOC("Put tag to S3");
        VERBOSE(params.verb, "Done.\n");
    }

    //
    // challenge logic
    //
    if ((params.ops & POR_OP_CHA) || (params.ops & POR_OP_VER)) {
        // to verify, we need a challenge
        for(i = 0; i < params.num_loops; i++) {
            VERBOSE(params.verb, "Creating challenge...");
TIC;
            if ((error = pdp_challenge_gen(ctx, &key, &ver_chal))) {
                ERROR("error: couldn't create challenge");
                goto cleanup;
            }
TOC("Create challenge");
            VERBOSE(params.verb, "Done.\n");

            if (!(params.ops & POR_OP_CHA) || (i >= params.num_loops-1)) {
                break;
            }
            pdp_challenge_free(ctx, &ver_chal);
        }
        pdp_challenge_for_prover(ctx, &ver_chal, &prv_chal);
    }

    //
    // generate proof
    //
    if ((params.ops & POR_OP_PRF) || (params.ops & POR_OP_VER)) {
        // need to generate a proof, if we want to verify
        for(i = 0; i < params.num_loops; i++) {
            VERBOSE(params.verb, "Generating proof...");
TIC;
            if ((error = pdp_proof_gen(ctx, &pk, &prv_chal, &proof))) {
                ERROR("error: couldn't generate proof");
                goto cleanup;
            }
TOC("Create proof");
            VERBOSE(params.verb, "Done.\n");

            if (!(params.ops & POR_OP_PRF) || (i >= params.num_loops-1)) {
                break;
            }
            pdp_proof_free(ctx, &proof);
        }
    }

    //
    // verify proof
    //
    if (params.ops & POR_OP_VER) {
        for(i = 0; i < params.num_loops; i++) {
            VERBOSE(params.verb, "Verifying proof...");
TIC;
            proof_stat = pdp_proof_verify(ctx, &key, &ver_chal, &proof);
            if (proof_stat == -1) {
                ERROR("error: couldn't verify proof");
                goto cleanup;
            }
TOC("Verify file");
            VERBOSE(params.verb, "Done.\n");

            if (!(params.ops & POR_OP_VER) || (i >= params.num_loops-1)) {
                break;
            }
        }
    }

    //
    // output summary of params and results
    //
    if (params.verb) {        
        switch(params.alg) {
            case PDP_MACPDP:
                printf("\tNum blocks: %d\n", ctx->macpdp_param->num_blocks);
                if (tag.macpdp)
                    printf("\tTag length: %zd bytes\n", tag.macpdp->tags_size);
                if (ver_chal.macpdp)
                    printf("\tNum challenges: %u\n", ver_chal.macpdp->ell);
                break;
            case PDP_APDP:
                printf("\tNum blocks: %d\n", ctx->apdp_param->num_blocks);
                if (ver_chal.apdp)
                    printf("\tNum challenges: %d\n", ver_chal.apdp->c);
                break;
            case PDP_CPOR:
                printf("\tNum blocks: %d\n", ctx->cpor_param->num_blocks);
                printf("\tNum Sectors: %u\n", ctx->cpor_param->num_sectors);
                if (ver_chal.cpor)
                    printf("\tNum challenges: %d\n", ver_chal.cpor->ell);
                break;
            case PDP_SEPDP:
                printf("\tNum blocks: %d\n", ctx->sepdp_param->num_blocks);
                printf("\tNo. chal/token: %d\n", 
                    ctx->sepdp_param->num_challenge_blocks);
                printf("\tNum challenges: %d\n",
                    (ctx->sepdp_param->num_blocks < 
                        ctx->sepdp_param->num_challenge_blocks) ? 
                        ctx->sepdp_param->num_blocks : 
                        ctx->sepdp_param->num_challenge_blocks);                
                printf("\tNum tokens: %d\n", 
                    ctx->sepdp_param->num_chal_created);
                printf("\tNum used tokens: %d\n", 
                    ctx->sepdp_param->num_chal_used);
            default:
                break;
        }
        if (params.ops & POR_OP_VER) {
            printf("File Integrity: %s\n", proof_stat ? "NO" : "Yes");
        }
    }

    //
    // print timing data for benchmarking
    //
    switch(params.alg) {
        case PDP_MACPDP:
            sprintf(meta, "%s:%s %d:%s %d:%s %d:%s %s", params.algo,
                    "Block size", ctx->macpdp_param->block_size,
                    "# challenges", 
                        ver_chal.macpdp ? ver_chal.macpdp->ell : params.cparam,
                    "# threads", ctx->num_threads,
                    "Filename", ctx->filepath);
            break;
        case PDP_APDP:
            sprintf(meta, "%s:%s %d:%s %zd:%s %zd:%s %zd: %s %hu:"
                          "%s %hu:%s %d:%s %d:%s %s", 
                    params.algo,
                    "Block size", ctx->apdp_param->block_size,
                    "PRF key size", ctx->apdp_param->prf_key_size,
                    "PRP key size", ctx->apdp_param->prp_key_size,
                    "RSA key size", ctx->apdp_param->rsa_key_size,
                    "use E-PDP", 
                        (params.apdp_opts & APDP_USE_E_PDP) ? 1 : 0,
                    "use safe primes", 
                        (params.apdp_opts & APDP_NO_SAFE_PRIMES) ? 0: 1,
                    "# challenges", 
                        ver_chal.apdp ? ver_chal.apdp->c : params.cparam,
                    "# threads", ctx->num_threads,
                    "Filename", ctx->filepath);
            break;
        case PDP_CPOR:
            sprintf(meta, "%s:%s %d:%s %zd:%s %zd:%s %zd:%s %u:%s %u:"
                          "%s %d:%s %d:%s %d:%s %s",
                    params.algo,
                    "Block size", ctx->cpor_param->block_size,
                    "PRF key size", ctx->cpor_param->prf_key_size,
                    "ENC key size", ctx->cpor_param->enc_key_size,
                    "MAC key size", ctx->cpor_param->mac_key_size,
                    "lambda", ctx->cpor_param->lambda,
                    "Zp bits", ctx->cpor_param->Zp_bits,
                    "sector size", ctx->cpor_param->sector_size,
                    "# challenge blocks",
                        ctx->cpor_param->num_challenge_blocks,
                    "# threads", ctx->num_threads,
                    "Filename", ctx->filepath);
            break;
        case PDP_SEPDP:
            sprintf(meta, "%s:%s %d:%s %zd:%s %zd:%s %zd:%s %hu:%s %hu:"
                          "%s %d:%s %d:%s %s",
                    params.algo,
                    "Block size", ctx->sepdp_param->block_size,
                    "PRF key size", ctx->sepdp_param->prf_key_size,
                    "PRP key size", ctx->sepdp_param->prp_key_size,
                    "AE key size", ctx->sepdp_param->ae_key_size,
                    "years", ctx->sepdp_param->year,
                    "minutes", ctx->sepdp_param->min,
                    "# challenge blocks",
                        ctx->cpor_param->num_challenge_blocks,
                    "# threads", ctx->num_threads,
                    "Filename", ctx->filepath);
        default:
            break;
    }
    TIME_IT_ADD_META(meta);
    time_it_write_csv(params.timing_filename, params.timing_data_opt);
    
cleanup:
    pdp_proof_free(ctx, &proof);
    pdp_challenge_free(ctx, &ver_chal);
    pdp_challenge_free(ctx, &prv_chal);
    pdp_tags_free(ctx, &tag);
    pdp_key_free(ctx, &key);
    pdp_key_free(ctx, &pk);
    pdp_ctx_free(ctx);
    time_it_cleanup();
    
    if (error)
        return error;
    if (!error && proof_stat == -1)
        return 0;
    return proof_stat;
}
