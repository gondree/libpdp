/**
 * @file
 * Interfaces for MR-PDP module backend storage logic.
 *
 * @author Copyright (c) 2012, Mark Gondree
 * @author Copyright (c) 2012, Alric Althoff
 * @author Copyright (c) 2008, Zachary N J Peterson
 * @date 2008-2013
 * @copyright BSD 2-Clause License,
 *            See http://opensource.org/licenses/BSD-2-Clause
 **/
/** @addtogroup MRPDP
 * @{ 
 */
#ifndef __MR_PDP_MISC_H__
#define __MR_PDP_MISC_H__


/*
 * function prototypes - mrpdp.c
 */
pdp_mrpdp_tag_t *mrpdp_tag_new(void);
void mrpdp_tag_free(pdp_mrpdp_tag_t *tag);

/*
 * function prototypes - mrpdp_serialize.c
 */
unsigned int mrpdp_serialized_tag_size(const pdp_ctx_t *ctx);
int mrpdp_serialize_tags(const pdp_ctx_t *ctx, const pdp_mrpdp_tagdata_t* t,
        unsigned char **buffer, unsigned int *buffer_len);
int mrpdp_deserialize_tag(const pdp_ctx_t *ctx, pdp_mrpdp_tag_t* tag,
        unsigned char *buffer, unsigned int buffer_len);

#endif
/** @} */
