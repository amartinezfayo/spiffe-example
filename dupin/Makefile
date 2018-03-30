SHELL=/bin/bash
SPIRE_REPO ?= spiffe/spire
SPIRE_REF  ?= 68d6dd46a6f1be5c16c83c3748d8a811b0104fbb # branch, tag or commit hash

all: checkout build-artifact build-services

checkout:
	rm -rf build/repos
	mkdir build/repos
	git clone git@github.com:$(SPIRE_REPO).git build/repos/spire
	git -C build/repos/spire checkout $(SPIRE_REF)


build-artifact:
	# rm -rf artifact spire/upstreamca-memory-keys/
	# mkdir artifact spire/upstreamca-memory-keys/
	docker-compose build build
	docker-compose up -d build
	docker-compose exec build find /root/go/src/github.com/spiffe/spire/ -name '*.tgz' -exec cp {} /home/spiffe-nginx/artifact.tgz \;
	# docker-compose exec build cp /root/go/bin/ghostunnel /home/spiffe-nginx/artifact/
	# docker-compose exec build cp /root/go/src/github.com/spiffe/spiffe-example/spiffe-nginx/build/tools/registration/registration /home/spiffe-nginx/artifact/
	# docker-compose exec build cp /root/go/src/github.com/spiffe/spiffe-example/spiffe-nginx/build/tools/registration/registration.json /home/spiffe-nginx/artifact/
	# docker-compose exec build cp /root/go/src/github.com/spiffe/spiffe-example/spiffe-nginx/build/tools/sidecar/sidecar /home/spiffe-nginx/artifact/
	docker-compose stop build
	# cp artifact/artifact.tgz build/
	# cp build/repos/spire/plugin/server/upstreamca-memory/pkg/_test_data/keys/* spire/upstreamca-memory-keys/
	
build-services:
	# rm -f server/nginx
	# tar -xzf nginx.tar.gz -C build/
	
	# docker-compose build blog database spire harness

demo:
	docker-compose up -d build
	sleep 5 # TODO: Find another way of making sure server is up before agents
	make harness
	
	#docker-compose exec build bash -c 'cd /opt/spire && ./spire-server run'
	#docker-compose exec build bash -c 'cd /opt/spire && ./spire-server token generate -spiffeID spiffe://example.org/host '



#	docker-compose up -d blog database harness
#	docker-compose exec blog cp /home/rosemary/artifact/sidecar /sidecar/sidecar
#	docker-compose exec database cp /home/rosemary/artifact/sidecar /sidecar/sidecar
#	docker-compose exec harness cp /home/rosemary/harness/rosemary.yml /root/.tmuxinator/rosemary.yml
#	docker-compose exec harness tmuxinator rosemary
#	docker-compose stop harness

harness: build
	cd harness && make screen
	cd harness && make kill

clean:
	docker-compose down

.PHONY: checkout build-artifact build-services demo clean
