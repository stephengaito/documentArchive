**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Problem: Secure access](#problem-secure-access)
- [Goals](#goals)
- [Research](#research)
		- [HTTPSC (two way HTTPS)](#httpsc-two-way-https)
		- [VPN](#vpn)
- [Requirements](#requirements)

## Problem: Secure access

Current secure communication technologies vary in their ease of use.

For our purposes the most secure communication technologies are HTTPS
(HTTP over SSL/TLS).  HTTPS can, today, optionally require clients to
supply a client certificate.  By requiring both the standard server and
the rarely used client certificates in the HTTPS protocol, we ensure
there is a very low probability of a "agent in the middle attack" (that
is, there is no agent in the middle who is listening to the
communication). We also raise the confidence that the client is who
they say they are.

Again, for our purposes, another secure communication technology is VPN
(virtual private networks).  If a FandianPF instance is bound
exclusively to VPN interfaces, then it should be assumed that all
communication is secure (enough).

Finally for easy use by one user (a very typical use case), we should
assume that a FandianPF instance which is bound exclusively to the
localhost loopback interface (127.0.0.1) is secure (enough).

## Goals

Allow a range of secure (enough) communication channels.

Allow different user roles to use communication channels with different
levels of security.

## Research

#### HTTPSC (two way HTTPS)

From a quick review of the [Puma](http://puma.io/) code, it looks like
it does not currently support the use of client SSL certificates ([Two
way](http://en.wikipedia.org/wiki/Mutual_authentication) see also
[Transport Layer
Security](http://en.wikipedia.org/wiki/Secure_Sockets_Layer) ). It
looks like it would be possible to add this function and then
contribute the fix back to the main development at some future time.

From an equally quick look at the Ruby HTTP code, it looks like people
say one can establish client connections to HTTPS servers which use two
way authentication... but I can not really see where in the code this
happens.

See:

 * [How to validate SSL certificate chain in ruby with net/http](http://stacko$

 * [Ruby 1.8.7 and Net::HTTP: Making an SSL GET request with client cert?](htt$

 * in the http.rb code, there is a discussion about the cert and
cert_store options in the documentation above the HTTP.start function
definition.

#### VPN

 * [OpenVPN](http://openvpn.net/) is the lightest weight VPN, all other
POSIX/Linux based VPNs require access to the kernel to make
modifications.

 * OpenVPN has servers on all POSIX/Linux as well as windows computers.

 * OpenVPN has clients on all POSIX/Linux as well as windows computers.

 * OpenVPN can NOT be used with either Heroku or Google Apps, since the
clients require access to the TUN Ethernet interface.

## Requirements

> It MUST be possible to use HTTPS (with server certificates) (HTTPS).

> It MUST be possible to use HTTPS with BOTH client and server
> certificates (HTTPSC).

> It MUST be possible to configure an instance to allow the use of any
> of HTTP, HTTPS, or HTTPSC on any particular route.

> User roles who are "just" reading the content, SHOULD not need to use
> HTTPSC or VPN communication channels.

> It SHOULD be possible to run "our own" highly secure (HTTPSC) OpenID
> server.

> It MIGHT be possible to have "our own" highly secure OpenID server
> require multiple types of credentials.

> It MUST be possible to override all HTTPS or HTTPSC requirements IF
> the FandianPF instance is bound exclusively to the 127.0.0.1
> (localhost loopback) interface.

> It MUST be possible to override all HTTPS or HTTPSC requirements IF
> the FandianPF instance is bound exclusively to VPN secured
> interfaces.


