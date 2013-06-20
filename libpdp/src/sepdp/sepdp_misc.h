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
/** @addtogroup SEPDP
 * @{ 
 */
#ifndef __SEPDP_MISC_H__
#define __SEPDP_MISC_H__


/*
 * function prototypes - sepdp_serialize.c
 */
unsigned int sepdp_serialized_tag_size(const pdp_ctx_t *ctx);
int sepdp_serialize_tags(const pdp_ctx_t *ctx, const pdp_sepdp_tagdata_t* t,
        unsigned char **buffer, unsigned int *buffer_len);
int sepdp_deserialize_tag(const pdp_ctx_t *ctx, pdp_sepdp_tag_t* tag,
        unsigned char *buf, unsigned int buf_len);


/*
 * function prototypes - sepdp.c
 */
void sepdp_tag_free(const pdp_ctx_t *ctx, pdp_sepdp_tag_t *token);


#endif
/** @} */
