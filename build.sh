#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

cd ${MY_FILES}
if [ ! -f "${MY_FILES}/base.pem" ]; then
    openssl genrsa -out base.key 2048
    openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=${DOMAIN}" -out base.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=${DOMAIN}" -out device.csr
    openssl x509 -req -in device.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out device.crt
fi
cp -r base.pem /ngrok/assets/client/tls/ngrokroot.crt

cd /ngrok
make release-server
GOOS=linux GOARCH=386 make release-client
GOOS=linux GOARCH=amd64 make release-client
GOOS=windows GOARCH=386 make release-client
GOOS=windows GOARCH=amd64 make release-client
GOOS=darwin GOARCH=386 make release-client
GOOS=darwin GOARCH=amd64 make release-client
GOOS=linux GOARCH=arm make release-client

cp -r /ngrok/bin ${MY_FILES}/bin

echo "build ok !"
