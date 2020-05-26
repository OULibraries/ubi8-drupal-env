#!/usr/bin/env bash 
## Bootstrap and empty Drupal site

if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

SITE=$1

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
DBSLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

HOST_UID=$(id -u)
HOST_GID=$(id -g)


DRP_ENV="$(dirname ${BASH_SOURCE})/../.env"
export $(cat ${DRP_ENV} | xargs)

aws s3 ls --recursive --human-readable  s3://ul-drp-data/ 

