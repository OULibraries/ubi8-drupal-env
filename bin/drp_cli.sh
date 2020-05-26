#!/usr/bin/env bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"


if [  -z "$1" ]; then
  cat <<USAGE
drp_cli.sh opens bash in a drp-cli container  
Usage: ./bin/drp_cli.sh \$SITE
\$SITE    local name for Drupal site (eg. example or demo-site).
USAGE
  exit 1;
fi


if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

if [ ! -d "./sites/${SITE}" ]; then
  echo "${SITE} note found in ./sites"
  exit 1;
fi

SITE=$1

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
SLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

HOST_UID=$(id -u)
HOST_GID=$(id -g)

export_docker_vars

docker run --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -it drp-cli bash

