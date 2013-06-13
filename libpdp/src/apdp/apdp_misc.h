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
/** @addtogroup APDP
 * @{ 
 */
#ifndef __A_PDP_MISC_H__
#define __A_PDP_MISC_H__


/*
 * function prototypes - apdp.c
 */
pdp_apdp_tag_t *apdp_tag_new(void);
void apdp_tag_free(pdp_apdp_tag_t *tag);

/*
 * function prototypes - apdp_serialize.c
 */
size_t apdp_serialized_tag_size(const pdp_ctx_t *ctx);
int apdp_serialize_tags(const pdp_ctx_t *ctx, const pdp_apdp_tagdata_t* t,
		unsigned char **buffer, size_t *buffer_len);
int apdp_deserialize_tag(const pdp_ctx_t *ctx, pdp_apdp_tag_t* tag,
		unsigned char *buffer, size_t buffer_len);

#endif
/** @} */
