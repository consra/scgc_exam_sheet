#!/bin/bash

# Generate a private key.
openssl genrsa -out nginx.key 4096;

# Generate a signing request.
openssl req -new -sha256 \
	-out nginx.csr \
	-key nginx.key \
	-config ssl.conf

# Check the CSR.
openssl req -text -noout -in nginx.csr

# Generate the certificate.
openssl x509 -req \
    -sha256 \
    -days 3650 \
    -in nginx.csr \
    -signkey nginx.key \
    -out nginx.crt \
    -extensions req_ext \
    -extfile ssl.conf

