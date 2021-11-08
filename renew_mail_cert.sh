#!/bin/bash

CA_BASEDIR="$(realpath $(dirname $0))"

NAME=$1
SUB_CA="mail-intermediate"

if [ -z "$NAME" ]
then
  echo "Enter a certificate name (part of the filename)"
  exit 1
fi

if [ ! -f "$SUB_CA/csr/$NAME.csr.pem" ]
then
  echo "$NAME.csr does not exist."
  exit 2
fi

KEYDIR=$PWD
 

cd "$CA_BASEDIR"

# CSR 

if [ -f "$SUB_CA/certs/$NAME.cert.pem" ]
then
  # revoke the old cert
  openssl ca -config $SUB_CA/openssl.cnf \
          -revoke "$SUB_CA/certs/$NAME.cert.pem"

  NOW=$(date +%s)
  BACKUP_FILE="$SUB_CA/certs/$NAME.cert.pem.$NOW"
  echo "Creating backup of old cert: $BACKUP_FILE"
  mv "$SUB_CA/certs/$NAME.cert.pem" "$BACKUP_FILE" || exit 3
fi

openssl ca -config $SUB_CA/openssl.cnf \
      -extensions usr_cert -days 375 -notext -md sha256 \
      -in "$SUB_CA/csr/$NAME.csr.pem" \
      -out "$SUB_CA/certs/$NAME.cert.pem"
chmod 444 "$SUB_CA/certs/$NAME.cert.pem"
