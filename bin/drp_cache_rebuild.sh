#!/usr/bin/env bash 


if [  -z "$1" ]; then
  cat <<USAGE
drp_cache_rebuild.sh runs a cache rebuild on your Drupal site 
Usage: ./bin/drp_cache_rebuild.sh \$SITE
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

docker run --user ${HOST_UID}:${HOST_GID} --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli ./sites/${SITE}/vendor/bin/drush cache-rebuild

