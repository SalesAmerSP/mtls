# Bash script to create CA, CSR 

Files to edit prior to running 

## ca.cnf

This section of the *ca.cnf* file:

```
[ distinguished_name ]
organizationName = F5 Test
commonName = F5 Test
```

```
# OpenSSL CA configuration file
[ ca ]
default_ca = CA_default

[ CA_default ]
default_days = 3650
database = index.txt
serial = serial.txt
default_md = sha256
copy_extensions = copy
unique_subject = no

# Used to create the CA certificate.
[ req ]
prompt=no
distinguished_name = distinguished_name
x509_extensions = extensions

[ distinguished_name ]
organizationName = F5 Test
commonName = F5 Test

[ extensions ]
keyUsage = critical,digitalSignature,nonRepudiation,keyEncipherment,keyCertSign
basicConstraints = critical,CA:true,pathlen:1

# Common policy for nodes and users.
[ signing_policy ]
organizationName = supplied
commonName = optional

# Used to sign node certificates.
[ signing_node_req ]
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth,clientAuth

# Used to sign client certificates.
[ signing_client_req ]
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = clientAuth
```

## server cnf

Items to set:

- distinguished name

- subjectAltName

```
# OpenSSL node configuration file
[ req ]
prompt=no
distinguished_name = distinguished_name
req_extensions = extensions

[ distinguished_name ]
organizationName = f5

[ extensions ]
subjectAltName = DNS:az.f5demos.vegas,DNS:oss.az.f5demos.vegas
```

## client cnf

Should match the server cnf file

```
# OpenSSL node configuration file
[ req ]
prompt=no
distinguished_name = distinguished_name
req_extensions = extensions

[ distinguished_name ]
organizationName = f5

[ extensions ]
subjectAltName = DNS:az.f5demos.vegas,DNS:client.az.f5demos.vegas
```

## Running scripts

Once configuration files are set, *cnf* files, run **./certs.sh** to create CA, Server and Client cert/key pairs.

To delete cert/key pairs run **./reset.sh**