include .env

DOCKER = docker

.EXPORT_ALL_VARIABLES:
HOST_UID=$(shell id -u)
HOST_GID=$(shell id -g)

all: drp-cli drp-php drp-nginx

.PHONY: drp-cli
drp-cli:
	${DOCKER} build -t drp-cli ./containers/drp-cli

.PHONY: drp-php
drp-php: 
	${DOCKER} build -t drp-php  ./containers/drp-php

.PHONY: drp-nginx
drp-nginx: 
	${DOCKER} build -t drp-nginx  ./containers/drp-nginx

.PHONY: build
build: all

.PHONY: site
site:
	-@bin/drp_create_site.sh $(SITE)
	@bin/drp_init_local.sh $(SITE)

.PHONY: run
start:
	@docker-compose up -d

.PHONY: stop
stop:
	@docker-compose down
