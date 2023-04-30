openssl ca \
    -config root-ca.config \
    -in $1.csr \
    -out $1.crt \
    -extensions sub_ca_ext

rm $1.csr
