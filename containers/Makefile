

DOCKER = docker
DRP_PATH = /home/lmc/Projects/D8/ubi8-drupal-env/sites/drp-demo
DB_PATH  = /home/lmc/Projects/D8/ubi8-drupal-env/data

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

