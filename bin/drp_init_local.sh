#!/usr/bin/env bash 
## Bootstrap and empty Drupal site


if [  -z "$1" ]; then
  cat <<USAGE
drp_init_local.sh  initializes a local drupal site.
Usage: drp_init_local.sh \$SITEPATH
\$SITEPATH    local name for Drupal site (eg. example or demo-site).
USAGE
  exit 1;
fi


if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

SITE=$1

if [ ! -d "./sites/${SITE}" ]; then
  echo "${SITE} note found in ./sites"
  exit 1;
fi


if [ -f "./sites/${SITE}/web/sites/default/settings.local.php" ]; then
  echo "settings.local.php for site already exists. Remove manually before re-initializing site."
  exit 1;
fi

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
SLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')

DRP_ENV="$(dirname ${BASH_SOURCE})/../.env"
export $(cat ${DRP_ENV} | xargs)



echo "Generating settings.local.php for site ${SITE}."
read -r -d '' SETTINGSPHP <<- EOF
<?php
\$databases['default']['default'] = array (
   'database' => 'drp_${SLUG}',
   'username' => 'root',
   'password' => '${MYSQL_ROOT_PASSWORD}',
   'prefix' => '',
   'host' => 'drp-mysql',
   'port' => '3306',
   'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
   'driver' => 'mysql',
 );
EOF

## TODO file private path, maybe need to do something with s3fs



echo "${SETTINGSPHP}" > "./sites/${SITE}/web/sites/default/settings.local.php"
chmod 444  "./sites/${SITE}/web/sites/default/settings.local.php"

HOST_UID=$(id -u)
HOST_GID=$(id -g)

docker run --user "${HOST_UID}":"${HOST_GID}" --network ubi8-drupal-env_default --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli bash -c \
" ./sites/${SITE}/vendor/bin/drush sql-create \
&& ./sites/${SITE}/vendor/bin/drush site-install --site-name=${SITE}"
