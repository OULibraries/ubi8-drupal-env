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

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
DBSLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

docker run --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli ./sites/${SITE}/vendor/bin/drush cache-rebuild

