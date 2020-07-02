#!/usr/bin/env bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"

if [  -z "$1" ]; then
  cat <<USAGE
drp_composer_install.sh  run composer to install dependencies for a site.
Usage: drp_composer_install.sh \$SITE
  \$SITE    local name for Drupal site (eg. example or demo-site).
USAGE
  exit 1;
fi

if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

SITE=$1

HOST_UID=$(id -u)
HOST_GID=$(id -g)

export_docker_vars

echo "Installing dependencies for ${SITE}"

docker run  --env COMPOSER_HOME=/mnt/data/composer --user "${HOST_UID}:${HOST_GID}" \
 --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z  --workdir /mnt/data \
 --rm -i drp-cli bash -s  <<EOF
   cd ./sites/${SITE}
   composer install 
EOF



