#!/usr/bin/env bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"

if [  -z "$1" ]; then
  cat <<USAGE
drp_db_import imports a sql database 
Usage: drp_db_import \$SITE \$DRP_IMPORT
\$SITE    local name for Drupal site (eg. example or demo-site).
\$DRP_EXPORT    path to sql import in the ul-drp-data S3 bucket  
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
DRP_EXPORT=$2

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
SLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

HOST_UID=$(id -u)
HOST_GID=$(id -g)

export_docker_vars

aws s3 cp "s3://ul-drp-data/${DRP_EXPORT}"  ./data/temp.sql


docker run  --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -i drp-cli ./sites/${SITE}/vendor/bin/drush -y sql-create 

cat ./data/temp.sql | docker run  --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -i drp-cli ./sites/${SITE}/vendor/bin/drush sql-cli 

rm -v ./data/temp.sql

