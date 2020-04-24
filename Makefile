ENV ?= development

all: build stop run

build:
	docker build -t docker-oracle-linux .

stop:
	docker stop docker-oracle-linux || true && docker rm docker-oracle-linux || true

run:
	docker run -dit -v ${HOME}/dev/SPMat-App:/go/src/spmat-app --name docker-oracle-linux --rm docker-oracle-linux