# CA
openssl genrsa -out ca_certs/ca.key 2048
if [ -f ca_certs/ca.key ]; then
    openssl req -new -x509 -config ca_certs/ca.cnf -key ca_certs/ca.key -out ca_certs/ca.crt -days 3650 -batch
    rm -f index.txt serial.txt
    touch index.txt
    echo '01' > serial.txt
else
    echo "CA key file does not exist"
fi

# Server
openssl genrsa -out server_certs/server.key 2048
if [ -f server_certs/server.key ]; then
    openssl req -new -config server_certs/server.cnf -key server_certs/server.key -out server_certs/server.csr -batch
    openssl ca -config ca_certs/ca.cnf -keyfile ca_certs/ca.key -cert ca_certs/ca.crt -policy signing_policy -extensions signing_node_req -out server_certs/server.crt -outdir server_certs/ -in server_certs/server.csr -batch
else
    echo "Server key file does not exist"
fi

# Client
openssl genrsa -out client_certs/client.key 2048
if [ -f client_certs/client.key ]; then
    openssl req -new -config client_certs/client.cnf -key client_certs/client.key -out client_certs/client.csr -batch
    openssl ca -config ca_certs/ca.cnf -keyfile ca_certs/ca.key -cert ca_certs/ca.crt -policy signing_policy -extensions signing_node_req -out client_certs/client.crt -outdir client_certs/ -in client_certs/client.csr -batch
else
    echo "Client key file does not exist"
fi

rm -f index.txt.* serial.txt.*