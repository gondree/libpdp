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
/** @addtogroup SEPDP
 * @{ 
 */
#ifndef __SEPDP_STORAGE_H__
#define __SEPDP_STORAGE_H__

/*
 * function prototypes - sepdp_file.c
 */
int sepdp_write_tags_to_file(const pdp_ctx_t *ctx, 
        const pdp_sepdp_tagdata_t* t);
int sepdp_get_tag_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);
int sepdp_get_block_file(const pdp_ctx_t* ctx, unsigned int i, 
        void *b, unsigned int *len);

/*
 * function prototypes - sepdp_s3.c
 */
int sepdp_write_data_to_s3(const pdp_ctx_t *ctx,
        const pdp_sepdp_tagdata_t* t);
int sepdp_get_tag_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *buffer, unsigned int *len);
int sepdp_get_block_s3(const pdp_ctx_t* ctx, unsigned int index, 
        void *b, unsigned int *len);

#endif
/** @} */
