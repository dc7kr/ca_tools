#!/bin/bash

CA_BASEDIR="$(realpath $(dirname $0))"

NAME=$1

if [ -z "$NAME" ]
then
  echo "Enter a certificate name (part of the filename)"
  exit 1
fi

openssl genrsa -aes256 -out "$NAME.key.pem" 2048
chmod 400 "$NAME.key.pem"

KEYDIR=$PWD
 

cd "$CA_BASEDIR"
# CSR 

openssl req -config vpn-intermediate/openssl.cnf \
      -key "$KEYDIR/$NAME.key.pem" \
      -new -sha256 -out "vpn-intermediate/csr/$NAME.csr.pem"

openssl ca -config vpn-intermediate/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in "vpn-intermediate/csr/$NAME.csr.pem" \
      -out "vpn-intermediate/certs/$NAME.cert.pem"
chmod 444 "vpn-intermediate/certs/$NAME.cert.pem"
