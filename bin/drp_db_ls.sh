#!/usr/bin/env bash 




if [ !  -z "$1" ]; then
  cat <<USAGE
drp_db_ls.sh list sql exports in ul-drp-data S3 bucket 
Usage: drp_db_ls.sh

Command takes no arguments.  
USAGE
  exit 1;
fi


if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi




if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

SITE=$1

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
SLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

HOST_UID=$(id -u)
HOST_GID=$(id -g)


DRP_ENV="$(dirname ${BASH_SOURCE})/../.env"
export $(cat ${DRP_ENV} | xargs)

aws s3 ls --recursive --human-readable  s3://ul-drp-data/ 

