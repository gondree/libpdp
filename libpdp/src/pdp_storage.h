/**
 * @file
 * Support routines for interfacing libpdp with libs3.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 *
 * @defgroup STORAGE PDP Storage
 * \brief Interfaces for using various storage back-ends.
 **/
#ifndef __PDP_S3_H__
#define __PDP_S3_H__

#include <pdp.h>

/*
 * function prototypes - in pdp_file.c
 */ 
int pdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
        unsigned int block_size, unsigned char *buf, 
        unsigned int *len);


/*
 * function prototypes - in pdp_s3.c
 */
int pdp_write_file_to_s3(const pdp_ctx_t *ctx, const char* filepath);
int pdp_write_data_to_s3(const pdp_ctx_t *ctx, const char* filepath,
        unsigned char *data, unsigned int data_len);
int pdp_get_chunk_from_s3(const pdp_ctx_t *ctx, const char *filepath,
        unsigned char **buf, unsigned int *buf_len, unsigned int index);

#endif
/** @} */
