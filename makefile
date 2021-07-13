.DEFAULT_GOAL := debug
DIR := ${CURDIR}
DOCKER_TAG := 1.0
DOCKER_REPO := docker/libgemini
CONTAINER_NAME := libgemini
CXX_PATH := /usr/bin/g++
C_PATH := /usr/bin/gcc

.PHONY: debug
debug:
	@$(MAKE) compile \
		BUILD_TYPE=Debug \
		--no-print-directory

.PHONY: release
release:
	@$(MAKE) compile \
		BUILD_TYPE=Release \
		--no-print-directory

.PHONY: compile
compile:
	mkdir -p ${BUILD_TYPE}; \
	cd ${BUILD_TYPE}; \
	cmake \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		-DCMAKE_CXX_COMPILER=${CXX_PATH} \
		-DCMAKE_C_COMPILER=${C_PATH} \
		..; \
	cmake --build .

.PHONY: liblift
liblift:
	cd vendor/liblifthttp; \
	mkdir Release; \
	cd Release; \
	cmake -DCMAKE_BUILD_TYPE=Release ..; \
	cmake --build .

.PHONY: run
run:
	cd bin; \
	./LibGeminiProject

.PHONY: clean
clean:
	rm -rf Debug; \
	rm -rf Release; \
	rm -rf bin/LibGeminiProject

.PHONY: clean-all
clean-all:
	@$(MAKE) clean; \
	rm -rf vendor/liblifthttp/Debug; \
	rm -rf vendor/liblifthttp/Release; \
	rm -rf build


.PHONY: docker-up
docker-up:
	# start up the container
	docker-compose up

.PHONY: docker-down
docker-down:
	# stop container
	docker-compose down -v --remove-orphans

.PHONY: bash
bash:
	# bind mount a volume to container and bash on in.
	docker run --name ${CONTAINER_NAME} --rm -it -d --mount type=bind,source="${DIR}",target=/libgemini ${DOCKER_REPO}:${DOCKER_TAG} /bin/bash;
	docker exec -it -e COLUMNS=`tput cols` -e LINES=`tput lines` ${CONTAINER_NAME} bash

define help-text
	Some Useful commands

  make help
    Prints help message and useful commands

-- Building --

  make
    Compiles project and dependencies.

  make release
    builds with release build flags

  make debug
    builds with debug build flags

  make liblift
    builds liblifthttp, should be run once on project checkout

  make clean
    cleans up build artifacts and executibles for this project
  make clean-vendor
    cleans up projects in vendor/..

-- Docker --

  make docker-up
    Spins up the docker container

  make docker-down
    Unwinds the docker container

  make bash
    Gets you into the docker container
endef

.PHONY: help
help:
	@: $(info $(help-text))