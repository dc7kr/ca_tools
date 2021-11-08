#!/bin/bash

NAME=$1
CA_BASEDIR="$(realpath $(dirname $0))"

if [ -z "$NAME" ]
then
    echo "Usage: $0 <name>"
    exit 1
fi

cd "$CA_BASEDIR"

openssl ca -config vpn-intermediate/openssl.cnf -revoke "vpn-intermediate/certs/$NAME.cert.pem"

openssl ca -config vpn-intermediate/openssl.cnf \
        -extensions server_cert -days 375 -notext -md sha256 \
              -in "vpn-intermediate/csr/$NAME.csr.pem" \
                    -out "vpn-intermediate/certs/$NAME.cert.pem"
