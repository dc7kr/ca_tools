#!/bin/bash

NAME=$1
SUB_CA=$2

if [ -z "$NAME" ]
then
  echo "ERROR: Enter a certificate name (part of the filename)"
  echo "Usage: $0 <name> <sub-ca>"
  exit 1
fi

if [ -z "$SUB_CA" ]
then
  echo "ERROR: Enter sub-ca name"
  echo "Usage: $0 <name> <sub-ca>"
  exit 2
fi



KEYDIR=$PWD
cd $HOME/Juwent-CA

if [ ! -f "$SUB_CA-intermediate/certs/$NAME.cert.pem" ]
then
  echo "File not found"
  exit 1
fi


openssl pkcs12 -export -out $KEYDIR/$NAME.pfx -inkey $KEYDIR/$NAME.key.pem -in "$SUB_CA-intermediate/certs/$NAME.cert.pem" -certfile "$SUB_CA-intermediate/certs/ca-chain.cert.pem"
