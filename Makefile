DOCKER_NAME = "metavige/nginx-openresty"
DIR="${PWD}"

build:
	docker build -t ${DOCKER_NAME} .

push:
	docker push ${DOCKER_NAME}

tagpush:
	docker tag -f ${DOCKER_NAME} "${DOCKER_NAME}:v${VER}" && docker push ${DOCKER_NAME}

cleanbuild:
	docker build --rm -t ${DOCKER_NAME} .

use:
	docker run -it --rm ${DOCKER_NAME} /bin/bash

start:
	docker run -d -P ${DOCKER_NAME}

build-rootfs:
	docker build -t nginx.rootfs -f Dockerfile.rootfs  .

rootfs:
	docker run --rm -v ${DIR}:/data nginx.rootfs
