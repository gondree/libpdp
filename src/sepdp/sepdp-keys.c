/* 
* sepdp-keys.c
*
* Copyright (c) 2010, Zachary N J Peterson <znpeters@nps.edu>
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the Naval Postgraduate School nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY ZACHARY N J PETERSON ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL ZACHARY N J PETERSON BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "sepdp.h"

SEPDP_key *sepdp_get_keys(){
  
	return generate_sepdp_key();
}

void destroy_sepdp_key(SEPDP_key *key){
  
	if(!key) return;
	if(key->W) sfree(key->W, params.prf_key_size);
	if(key->Z) sfree(key->Z, params.prf_key_size);
	if(key->K) sfree(key->K, params.ae_key_size);
	key->W_size = 0;
	key->Z_size = 0;
	key->K_size = 0;
	sfree(key, sizeof(SEPDP_key));
  
	return;
}

SEPDP_key *generate_sepdp_key(){
  
	SEPDP_key *key = NULL;
  
	if( (key = malloc(sizeof(SEPDP_key))) == NULL) return NULL;
	memset(key, 0, sizeof(SEPDP_key));
  
	if( ((key->W = malloc(params.prf_key_size)) == NULL)) goto cleanup;
	if( ((key->Z = malloc(params.prf_key_size)) == NULL)) goto cleanup;
	if( ((key->K = malloc(params.ae_key_size)) == NULL)) goto cleanup;	
  
	/* Generate symmetric keys */
/*
	if(!RAND_bytes(key->W, params.prf_key_size)) goto cleanup;
	if(!RAND_bytes(key->Z, params.prf_key_size)) goto cleanup;
	if(!RAND_bytes(key->K, params.ae_key_size)) goto cleanup;
	*/
	memset(key->W, 'W', params.prf_key_size);
	memset(key->Z, 'Z', params.prf_key_size);
	memset(key->K, 'K', params.ae_key_size);
	key->W_size = params.prf_key_size;
	key->Z_size = params.prf_key_size;
	key->K_size = params.ae_key_size;

	return key;
  
 cleanup:
	if(key) destroy_sepdp_key(key);
	return NULL;
}
