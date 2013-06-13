/* 
 * Interfaces for the libpdp library
 *
 * \author Copyright (c) 2012, Mark Gondree
 * \author Copyright (c) 2012, Alric Althoff
 * \author Copyright (c) 2008, Zachary N J Peterson
 * \date 2008-2013
 * \copyright BSD 2-Clause License
 *            See http://opensource.org/licenses/BSD-2-Clause
 */
/** @addtogroup STORAGE
 * @{ 
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/param.h>
#include <sys/stat.h>
#ifdef _S3_SUPPORT
#include <libgen.h>
#include <libs3.h>
#endif
#include <pdp.h>
#include "pdp_storage.h"
#include "pdp_misc.h"


/**
 * @brief Gets a block from a file
 *
 * @param[in]     ctx    pointer to a context structure.
 * @param[in]     i      the index of block.
 * @param[in] block_size block size
 * @param[out]    buf    pointer to an output buffer.
 * @param[in,out] len    initially the size of buf, output bytes written.
 * @return 0 on success, non-zero on error
 **/
int pdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
                       unsigned int block_size, unsigned char *buf, 
                       unsigned int *len)
{
    static FILE* file = NULL;
    unsigned int pos = 0;

    // if buf is NULL, its a signal to re-set the stateful variables
    if (!buf && file) {
        fclose(file);
        file = NULL;
        return 0;
    }

    if (!ctx || !block_size || !buf || !len || !*len)
        return -1;

    if (*len % block_size) {
        PDP_ERR("warning: reading a partial block (buffer is "
                "%d bytes; tag is %d bytes)", *len, block_size);
    }
    memset(buf, 0, *len);

    // if file is not open already, open it
    if (!file && ((file = fopen(ctx->filepath, "r")) == NULL)) {
        PDP_ERR("unable to open %s: %d", ctx->filepath, ferror(file));
        return -1;
    }
    
    // seek to correct place in file and read out the requested tag
    pos = i * block_size;
    if (fseek(file, pos, SEEK_SET) != 0) {
        PDP_ERR("fseek error %d", errno);
        return -1;
    }
    *len = fread(buf, 1, *len, file);
    if (ferror(file)) return -1;

    return 0;
}

/** @} */
