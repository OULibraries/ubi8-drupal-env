#!/usr/bin/env bash 
## Bootstrap and empty Drupal site


if [  -z "$1" ]; then
  cat <<USAGE
drp_sql_export.sh exports a sql database 
Usage: drp_sql_export.sh \$SITEPATH
\$SITEPATH    local name for Drupal site (eg. example or demo-site).
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
DBSLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

HOST_UID=$(id -u)
HOST_GID=$(id -g)


DRP_ENV="$(dirname ${BASH_SOURCE})/../.env"
export $(cat ${DRP_ENV} | xargs)



DRP_DB_DUMP="s3://ul-drp-data/lmc/demo-site.1589575766.sql"

aws s3 cp "s3://ul-drp-data/${DRP_EXPORT}"  ./data/temp.sql




docker run  --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -i drp-cli ./sites/${SITE}/vendor/bin/drush -y sql-create --db-url="mysq://root:${MYSQL_ROOT_PASSWORD}@drp-mysql:3306/drp_${DBSLUG}" 

cat ./data/temp.sql | docker run  --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data --rm -i drp-cli ./sites/${SITE}/vendor/bin/drush sql-cli 

rm ./data/temp.sql

