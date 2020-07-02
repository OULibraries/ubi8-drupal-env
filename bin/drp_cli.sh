#!/usr/bin/env bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"


if [ ! $# -eq 0 ]; then
  cat <<USAGE
drp_cli.sh opens bash in a drp-cli container  
Usage: ./bin/drp_cli.sh
USAGE
  exit 1;
fi


if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi


HOST_UID=$(id -u)
HOST_GID=$(id -g)

export_docker_vars


cat <<HELP
Hello!

This container supports running a variety of CLI tools including:
* composer - run normally 
* php      - run normally 
* drush    - run from sites/$SITE/vendor/bin/drush for your drupal site

HELP

docker run  --env COMPOSER_HOME=/mnt/data/composer --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -it drp-cli bash

