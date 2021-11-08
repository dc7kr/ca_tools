#!/bin/bash

. ~/.ca_config

NAME=$1

if [ -z "$NAME" ]
then
  echo "Enter a certificate name (part of the filename)"
  exit 1
fi

openssl genrsa -aes256 -out "$NAME.key.pem" 2048
chmod 400 "$NAME.key.pem"

KEYDIR=$PWD
 

cd $CA_BASE_DIR
# CSR 

openssl req -config mail-intermediate/openssl.cnf \
      -key "$KEYDIR/$NAME.key.pem" \
      -new -sha256 -out "mail-intermediate/csr/$NAME.csr.pem"

openssl ca -config mail-intermediate/openssl.cnf \
      -extensions usr_cert -days 375 -notext -md sha256 \
      -in "mail-intermediate/csr/$NAME.csr.pem" \
      -out "mail-intermediate/certs/$NAME.cert.pem"
chmod 444 "mail-intermediate/certs/$NAME.cert.pem"
