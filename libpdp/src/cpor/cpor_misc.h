/**
 * @file
 * Interfaces for A-PDP module backend storage logic.
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
#ifndef __CPOR_PDP_MISC_H__
#define __CPOR_PDP_MISC_H__

/*
 * function prototypes - cpor_serialize.c
 */
unsigned int cpor_serialized_tag_size(const pdp_ctx_t *ctx);
int cpor_serialize_tags(const pdp_ctx_t *ctx, const pdp_cpor_tagdata_t* t,
        unsigned char **buffer, unsigned int *buffer_len);
int cpor_deserialize_tag(const pdp_ctx_t *ctx, pdp_cpor_tag_t* tag,
        unsigned char *buf, unsigned int buf_len);

/*
 * function prototypes - cpor.c
 */
pdp_cpor_tag_t *cpor_tag_new(void);
void cpor_tag_free(pdp_cpor_tag_t *tag);
int cpor_fkey_open(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
        pdp_cpor_tagdata_t **td);
int cpor_fkey_store(const pdp_ctx_t *ctx, const pdp_cpor_key_t *key, 
        const pdp_cpor_tagdata_t *td);

#endif
/** @} */
