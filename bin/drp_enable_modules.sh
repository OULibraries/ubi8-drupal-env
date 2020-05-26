#!/usr/bin/env bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"

if [  -z "$1" ]; then
  cat <<USAGE
 drp_enable_modules.sh  enables our core set of drupal modules.
Usage: drp_enable_modules.sh \$SITE
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

docker run  --user "${HOST_UID}:${HOST_GID}" --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -i drp-cli bash -s  <<EOF
 ./sites/${SITE}/vendor/bin/drush en -y admin_toolbar
 ./sites/${SITE}/vendor/bin/drush en -y bootstrap
 ./sites/${SITE}/vendor/bin/drush en -y config_filter
 ./sites/${SITE}/vendor/bin/drush en -y config_split
 ./sites/${SITE}/vendor/bin/drush en -y datetime_range
 ./sites/${SITE}/vendor/bin/drush en -y devel
 ./sites/${SITE}/vendor/bin/drush en -y entity_browser
 ./sites/${SITE}/vendor/bin/drush en -y layout_builder
 ./sites/${SITE}/vendor/bin/drush en -y layout_discovery
 ./sites/${SITE}/vendor/bin/drush en -y media
 ./sites/${SITE}/vendor/bin/drush en -y media_library
 ./sites/${SITE}/vendor/bin/drush en -y responsive_image
 ./sites/${SITE}/vendor/bin/drush en -y s3fs
 ./sites/${SITE}/vendor/bin/drush en -y s3fs_cors
 ./sites/${SITE}/vendor/bin/drush en -y stage_file_proxy
 ./sites/${SITE}/vendor/bin/drush en -y telephone
 ./sites/${SITE}/vendor/bin/drush en -y twig_tweak
EOF
