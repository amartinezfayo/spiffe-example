#!/bin/bash

declare -r SPIRE_DIR="/opt/spire"


find /root/go/src/github.com/spiffe/spire/artifacts/ -name '*.tar.gz' -exec cp {} /opt/spiffe-nginx/artifact.tar.gz \;
tar -xzf ./artifact.tar.gz
rm -rf ${SPIRE_DIR}
mv -v spire /opt/spire/
chmod -R 777 ${SPIRE_DIR}
mkdir ${SPIRE_DIR}/.data


tar -xzf nginx.tar.gz
mkdir -p /usr/local/nginx/logs
chmod 777 /usr/local/nginx/logs
mkdir /certs
chmod 777 /certs
chmod 777 /usr/local/nginx
chmod 777 /dev/stdout
useradd -m nginx-blog


rm artifact.tar.gz installNginx.sh nginx.tar.gz vendor.sh
