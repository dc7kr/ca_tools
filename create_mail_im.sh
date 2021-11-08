openssl req -config mail-intermediate/openssl.cnf -new -sha256 \
      -key mail-intermediate/private/mail-intermediate.key.pem \
      -out mail-intermediate/csr/mail-intermediate.csr.pem

openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in mail-intermediate/csr/mail-intermediate.csr.pem \
      -out mail-intermediate/certs/mail-intermediate.cert.pem

chmod 444 mail-intermediate/certs/mail-intermediate.cert.pem


openssl verify -CAfile certs/ca.cert.pem \
      mail-intermediate/certs/mail-intermediate.cert.pem

cat mail-intermediate/certs/mail-intermediate.cert.pem \
      certs/ca.cert.pem > mail-intermediate/certs/ca-chain.cert.pem
chmod 444 mail-intermediate/certs/ca-chain.cert.pem
