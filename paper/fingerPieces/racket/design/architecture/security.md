**Table of Contents**

  - [Securing diSimpExplorer's frontend/backend communication](#securing-disimpexplorer-s-frontend-backend-communication)
    - [Problem](#problem)
    - [Goals](#goals)
    - [Requirements](#requirements)
    - [Solution](#solution)
    - [Questions and Risk](#questions-and-risk)
    - [Resources](#resources)

<!--- END TOC -->

# Securing diSimpExplorer's frontend/backend communication

## Problem

The diSimpExplorer has been designed as a browser based frontend 
communicating via HTTP over TCP/IP to a Racket based backend webserver.

While the typical setup will have the backend webserver listening on a 
more or less random IP-port on the localhost, the fact that it *is* 
listening on a IP-port on the localhost means that *any* other user of 
the local host can potentially gain access to the backend server.

Since, typically, this backend server will be running as a given user, 
this means that other user's potentially have the ability to corrupt the 
given user's disk space and possibly even gain access to the given user's 
UNIX account.

This presents roughly the same security problems as the "old" MIT 
X-Windows exploits.

For typical usage patterns this presents a very low security risk, 
however it *is* a security risk for which we should have a "story" if not 
implementation.

## Goals

Provide a *simple* mechanism to ensure that only the permitted user 
accesses the backend server which does not have major impacts on the 
overall usability or performance of the diSimpExplorer tool.

## Requirements

> The communication between the frontend client and backend server WILL 
> NOT be encrypted.

> The communication between the frontend client and backend server WILL 
> be authenticated.

> "Person in the middle" attacks MUST be prevented.

> "Replay" attacks MUST be prevented.

## Solution

When the Racket based backend server opens its first connection with the 
user's preferred browser, one half of a [symmetric 
key-pair](https://en.wikipedia.org/wiki/Public-key_cryptography) together 
with a [nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce), will 
be handed to the frontend javascript.

On each subsequent communication between the frontend client and the 
backend server, the nonce will be traded back and forth.

To communicate with the backend web-server, the frontend client will 
encrypt the current nonce with its key.

The webserver will verify the client by decrypting the nonce encrypted 
by the client and comparing it with the current nonce.

Since a given user's interaction with the backend web-server will not 
typically be very long, the symmetric key-pair nor the 
encryption/decryption routines do not need to be particularly complex.

## Questions and Risk

How does the user open multiple windows/tabs on the backend server from 
within the same browser?

## Resources