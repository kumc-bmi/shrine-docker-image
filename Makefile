.PHONY: build

TAG:=$(shell git rev-parse HEAD | colrm 8)

build:
	docker build --tag shrine:$(TAG) .
