#!/bin/bash

declare -r SPIRE_DIR="/opt/spire"

# Search builded artifact and copy into installation folder
find /root/go/src/github.com/spiffe/spire/artifacts/ -name '*.tar.gz' -exec cp {} /opt/spiffe-nginx/artifact.tar.gz \;

# Uncompress and move spire into spire folder
tar -xzf ./artifact.tar.gz
rm -rf ${SPIRE_DIR}
mv -v spire /opt/spire/
chmod -R 777 ${SPIRE_DIR}
mkdir ${SPIRE_DIR}/.data

# Clean installation files
rm artifact.tar.gz install_spire.sh