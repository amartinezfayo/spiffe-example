#!/bin/bash

declare -r NGINX_DIR="/usr/local/nginx"
declare -r NGINX_LOGS_DIR="${NGINX_DIR}/logs"

# Uncompress nginx
mkdir /opt/spiffe-nginx
tar -xzf nginx.tar.gz -C /opt/spiffe-nginx

# Create log folder 
mkdir -p ${NGINX_LOGS_DIR}
touch ${NGINX_LOGS_DIR}/access.log  ${NGINX_LOGS_DIR}/error.log
chmod 777 -R ${NGINX_LOGS_DIR}
chmod 777 ${NGINX_DIR}

# Create certs forlder
mkdir /certs
chmod 777 /certs

# Create blog user
useradd -m nginx-blog

# There is a bug in docker where /dev/stdout return permission error
echo 'chmod 777 /dev/stdout' >> ~/.bashrc

# Clean installation files
rm install_nginx.sh nginx.tar.gz vendor.sh