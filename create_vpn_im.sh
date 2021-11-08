openssl req -config vpn-intermediate/openssl.cnf -new -sha256 \
      -key vpn-intermediate/private/vpn-intermediate.key.pem \
      -out vpn-intermediate/csr/vpn-intermediate.csr.pem

openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in vpn-intermediate/csr/vpn-intermediate.csr.pem \
      -out vpn-intermediate/certs/vpn-intermediate.cert.pem

chmod 444 vpn-intermediate/certs/vpn-intermediate.cert.pem


openssl verify -CAfile certs/ca.cert.pem \
      vpn-intermediate/certs/vpn-intermediate.cert.pem

cat vpn-intermediate/certs/vpn-intermediate.cert.pem \
      certs/ca.cert.pem > vpn-intermediate/certs/ca-chain.cert.pem
chmod 444 vpn-intermediate/certs/ca-chain.cert.pem
