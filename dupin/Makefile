SHELL=/bin/bash
SPIRE_REPO ?= spiffe/spire
SPIRE_REF  ?= 68d6dd46a6f1be5c16c83c3748d8a811b0104fbb # branch, tag or commit hash
DOCKER_IMAGE = spiffe-nginx

all: build-artifact

build-artifact:
	docker-compose build $(DOCKER_IMAGE)
	docker-compose up -d $(DOCKER_IMAGE)
	docker-compose exec $(DOCKER_IMAGE) find /root/go/src/github.com/spiffe/spire/ -name '*.tgz' -exec cp {} /home/spiffe-nginx/artifact.tgz \;
	docker-compose stop $(DOCKER_IMAGE)

demo:
	docker-compose up -d $(DOCKER_IMAGE)
	sleep 5 # TODO: Find another way of making sure server is up before agents
	make harness
	
harness: $(DOCKER_IMAGE)
	cd harness && make screen
	cd harness && make kill

clean:
	docker-compose down

.PHONY: checkout build-artifact build-services demo clean
