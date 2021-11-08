#!/bin/bash


SUB_CA="$1"

if [ -z "$SUB_CA" ]
then
  echo "Enter an intermediate CA (mail | vpn)"
  exit 1
fi


ls $SUB_CA-intermediate/certs/*.pem | while read cert
do

  openssl x509 -checkend 0 -noout -in "$cert"

  if [ $? -ne 0 ]
  then
    echo "Expired: $cert"
  fi

  
done


