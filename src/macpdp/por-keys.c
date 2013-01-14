/* 
* por-keys.c
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

#include "por.h"

POR_key *por_get_keys(){
  
	return generate_por_key();
}

void destroy_por_key(POR_key *key){
  
	if(!key) return;
	if(key->prf_key) sfree(key->prf_key, POR_PRF_KEY_SIZE);
	key->prf_key_size = 0;
	sfree(key, sizeof(POR_key));
  
	return;
}

POR_key *generate_por_key(){
  
	POR_key *key = NULL;
  
	if((key = malloc(sizeof(POR_key))) == NULL) 
		return NULL;
	memset(key, 0, sizeof(POR_key));
  
	if((key->prf_key = malloc(POR_PRF_KEY_SIZE)) == NULL) 
		goto cleanup;
  
	/* Generate symmetric keys */
	/*
	if(!RAND_bytes(key->prf_key, POR_PRF_KEY_SIZE)) goto cleanup;
	*/
	memset(key->prf_key, 'Z', POR_PRF_KEY_SIZE);
	key->prf_key_size = POR_PRF_KEY_SIZE;

	return key;
  
 cleanup:
	if(key) 
		destroy_por_key(key);
	return NULL;
}
