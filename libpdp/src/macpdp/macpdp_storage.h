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
/** @addtogroup MACPDP
 * @{ 
 */
#ifndef __MAC_PDP_STORAGE_H__
#define __MAC_PDP_STORAGE_H__

/*
 * function prototypes - macpdp_file.c
 */
int macpdp_write_tags_to_file(const pdp_ctx_t *ctx, 
        const pdp_macpdp_tagdata_t* t);
int macpdp_get_tag_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);
int macpdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);
/*
 * function prototypes - macpdp_s3.c
 */
int macpdp_write_data_to_s3(const pdp_ctx_t *ctx,
        const pdp_macpdp_tagdata_t* t);
int macpdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *b, unsigned int* len);
int macpdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *b, unsigned int* len);
#endif
/** @} */
