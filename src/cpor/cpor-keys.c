
/* 
* cpor-keys.c
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

#include "cpor.h"

CPOR_key *allocate_cpor_key(){

	CPOR_key *key = NULL;

	if( ((key = malloc(sizeof(CPOR_key))) == NULL)) goto cleanup;
	if( ((key->k_enc = malloc(params.enc_key_size)) == NULL)) goto cleanup;
	key->k_enc_size = params.enc_key_size;
	if( ((key->k_mac = malloc(params.mac_key_size)) == NULL)) goto cleanup;
	key->k_mac_size = params.mac_key_size;
	key->global = NULL;
	
	return key;
	
cleanup:
	if(key) destroy_cpor_key(key);
	return NULL;
	
}

void destroy_cpor_key(CPOR_key *key){

	if(!key) return;
	if(key->k_enc) sfree(key->k_enc, params.enc_key_size);
	key->k_enc_size = 0;
	if(key->k_mac) sfree(key->k_mac, params.mac_key_size);
	key->k_mac_size = 0;
	if(key->global) destroy_cpor_global(key->global);
	sfree(key, sizeof(CPOR_key));

	return;
}

//Read keys from disk
CPOR_key *cpor_get_keys(){

	CPOR_key *key = NULL;
	FILE *keyfile = NULL;
	size_t Zp_size = 0;
	unsigned char *Zp = NULL;

	if( ((key = allocate_cpor_key()) == NULL)) goto cleanup;
	if( ((key->global = allocate_cpor_global()) == NULL)) goto cleanup;

	keyfile = fopen("./cpor.key", "r");
	if(!keyfile){
		PRINT_ERR("ERROR: Was not able to create keyfile.\n");
		goto cleanup;
	}
	
	fread(&key->k_enc_size, sizeof(size_t), 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fread(key->k_enc, key->k_enc_size, 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fread(&key->k_mac_size, sizeof(size_t), 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fread(key->k_mac, key->k_mac_size, 1, keyfile);
	if(ferror(keyfile)) goto cleanup;

	fread(&Zp_size, sizeof(size_t), 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	if( ((Zp = malloc(Zp_size)) == NULL)) goto cleanup;
	memset(Zp, 0, Zp_size);
	fread(Zp, Zp_size, 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	if(!BN_bin2bn(Zp, Zp_size, key->global->Zp)) goto cleanup;
	
	if(Zp) sfree(Zp, Zp_size);
	if(keyfile) fclose(keyfile);
	
	return key;
	
cleanup:
	if(Zp) sfree(Zp, Zp_size);
	if(keyfile) fclose(keyfile);
	if(key) destroy_cpor_key(key);
	return NULL;
}


//TODO:  This is totally insecure -- keys are written unencrypted to the disk.  Take a look at the PDP key stuff.  
/* Create and write keys.*/
CPOR_key *cpor_create_new_keys(){

	CPOR_key *key = NULL;
	FILE *keyfile = NULL;
	size_t Zp_size = 0;
	unsigned char *Zp = NULL;
	
	if( ((key = allocate_cpor_key()) == NULL)) goto cleanup;
	if( ((key->global = cpor_create_global(params.Zp_bits)) == NULL)) goto cleanup;

	if(!RAND_bytes(key->k_enc, params.enc_key_size)) goto cleanup;
	key->k_enc_size = params.enc_key_size;	
	if(!RAND_bytes(key->k_mac, params.mac_key_size)) goto cleanup;
	key->k_mac_size = params.mac_key_size;
	
	/* Check to see if the key file exists */
	//TODO, fix this
	/*
	if( (access("./cpor.key", F_OK) == 0)){
		fprintf(stdout, "WARNING: Key files for %s already exist; do you want to overwite (y/N)?", filepath);
		scanf("%c", &yesorno);
		if(yesorno != 'y') goto exit;
	}
	*/
	
	keyfile = fopen("./cpor.key", "w");
	if(!keyfile){
		PRINT_ERR("ERROR: Was not able to create keyfile.\n");
		goto cleanup;
	}

	fwrite(&key->k_enc_size, sizeof(size_t), 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fwrite(key->k_enc, key->k_enc_size, 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fwrite(&key->k_mac_size, sizeof(size_t), 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	fwrite(key->k_mac, key->k_mac_size, 1, keyfile);
	if(ferror(keyfile)) goto cleanup;
	
	Zp_size = BN_num_bytes(key->global->Zp);
	fwrite(&Zp_size, sizeof(size_t), 1, keyfile);
	if( ((Zp = malloc(Zp_size)) == NULL)) goto cleanup;
	memset(Zp, 0, Zp_size);
	if(!BN_bn2bin(key->global->Zp, Zp)) goto cleanup;
	fwrite(Zp, Zp_size, 1, keyfile);
	
	if(keyfile) fclose(keyfile);
	if(Zp) sfree(Zp, Zp_size);
	
	return key;

cleanup:
	if(key) destroy_cpor_key(key);
	if(keyfile) fclose(keyfile);
	if(Zp) sfree(Zp, Zp_size);
	
	return NULL;
}
