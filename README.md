# libpdp, a library for Proofs of Data Possession
A provable data possession scheme allows a client that has stored data at 
an untrusted server to verify that the server possesses the original data 
without retrieving it or storing a copy himself. It accomplishes this by 
generating probabilistic proofs using an interactive protocol with the 
remote server.

libpdp currently implements the following cryptographic proof schemes:

* MACPDP -- The simple MAC-based PDP scheme.
* A-PDP -- An implementation of the Ateniese, Burns, Curtmola, Herring, 
     Kissner, Peterson and Song provable data possession (PDP) scheme.
* CPOR -- An implementation of the Shacham and Waters POR scheme.
* SEPDP -- An implementation of the Ateniese, Pietro, Mancini and Tsudik
     PDP scheme.

All modules are listed in the <a href="modules.html">Module Documentation</a>

