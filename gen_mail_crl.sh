#!/bin/bash

SUB_CA="mail-intermediate"

openssl ca -config $SUB_CA/openssl.cnf -gencrl -out $SUB_CA/crl/$sub_CA.crl.pem
