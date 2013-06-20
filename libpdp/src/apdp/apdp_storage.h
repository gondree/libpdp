/**
 * @file
 * Interfaces for MAC-PDP module backend storage logic.
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
#ifndef __A_PDP_STORAGE_H__
#define __A_PDP_STORAGE_H__

/*
 * function prototypes - apdp_file.c
 */
int apdp_write_tags_to_file(const pdp_ctx_t *ctx, 
        const pdp_apdp_tagdata_t* t);
int apdp_get_tag_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);
int apdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);
/*
 * function prototypes - apdp_s3.c
 */
int apdp_write_data_to_s3(const pdp_ctx_t *ctx, const pdp_apdp_tagdata_t* t);
int apdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *b, unsigned int* buf_len);
int apdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *b, unsigned int* len);

#endif
/** @} */
