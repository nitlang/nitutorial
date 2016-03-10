# Nit Jail

Proof of concept of a Nit jail / sandbox based on firejail.

Requirements:

 * nodejs 5.4.1
 * npm 3.3.12
 * firejail 0.9.38 https://github.com/netblue30/firejail
 * nit with [experimental nitcc](https://github.com/nitlang/nit/pull/1979)

Installation:

	make install-deps
	make install

To test missions (without the server):

	make test

Run the server:

	make run

The submit can found at http://localhost:3000/.
