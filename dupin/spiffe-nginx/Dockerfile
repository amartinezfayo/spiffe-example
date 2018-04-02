FROM ubuntu:xenial

LABEL Description="Spiffe nginx integration"
LABEL vendor="SPIFFE"
LABEL version="0.5.0"

ARG DEBUG
ARG SPIRE_GOOPTS

ENV DEBUG        "$DEBUG"
ENV SPIRE_GOOPTS "$SPIRE_GOOPTS"

RUN apt-get update && apt-get -y install \
    curl unzip git build-essential autoconf automake dh-autoreconf libtool pkg-config g++

ENV GOPATH=/root/go

# Build Spire
COPY repos/spire /root/go/src/github.com/spiffe/spire
WORKDIR /root/go/src/github.com/spiffe/spire/
RUN ./build.sh setup
RUN ./build.sh vendor
RUN ./build.sh binaries
RUN ./build.sh artifact

# Copy nginx local configurations
COPY configurations /usr/local/nginx/

# Build spiffe nginx
COPY nginx /opt/spiffe-nginx
WORKDIR /opt/spiffe-nginx
RUN ./vendor.sh
RUN ./install_nginx.sh

# Install spire
RUN ./install_spire.sh

