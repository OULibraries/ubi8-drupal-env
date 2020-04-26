

DOCKER = podman
DRP_SITE = /home/lmc/Projects/D8/drp-demo

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

.PHONY: run
run:
	${DOCKER} run --name drp-nginx --volume ${DRP_SITE}:/var/www/drupal:rw --network host drp-nginx &
	${DOCKER} run --name drp-php --volume ${DRP_SITE}:/var/www/drupal:rw --network host drp-php &
