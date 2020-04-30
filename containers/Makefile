

DOCKER = docker

all: drp-cli drp-php drp-nginx

.PHONY: drp-cli
drp-cli:
	${DOCKER} build -t drp-cli ./drp-cli

.PHONY: drp-php
drp-php: 
	${DOCKER} build -t drp-php  ./drp-php

.PHONY: drp-nginx
drp-nginx: 
	${DOCKER} build -t drp-nginx  ./drp-nginx

