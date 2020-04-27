#!/usr/bin/env bash 
## Bootstrap and empty Drupal site


if [  -z "$1" ]; then
  cat <<USAGE
drp_create_site.sh builds a Drupal site.
Usage: drp_init.sh \$SITEPATH
\$SITEPATH    local name for Drupal site (eg. example or demo-site).
USAGE
  exit 1;
fi


if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"

  exit 1;

fi




## Grab the base for SITEPATH and MASTERPATH to use as slugs
SITE=$1

## Sanitize the DB slug by excluding everything that MySQL doesn't like from $SITE
DBSLUG=$(echo -n  "${SITE}" | tr -C '_A-Za-z0-9' '_')


## 
echo "Let's build a site!"
echo "building ${SITE}" 

mkdir -p "./sites/${SITE}"


docker run --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli composer create-project drupal/recommended-project ./sites/${SITE}
docker run --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli composer require --working-dir ./sites/${SITE} drush/drush

sudo chown -R $(whoami) ./sites/${SITE} 


read -r -d '' INCLUDELOCAL <<- EOF
if (file_exists(\$app_root . '/' . \$site_path . '/settings.local.php')) {
  include \$app_root . '/' . \$site_path . '/settings.local.php';
}
EOF


cp ./sites/${SITE}/web/sites/default/default.settings.php ./sites/${SITE}/web/sites/default/settings.php
echo  ${INCLUDELOCAL} >> ./sites/${SITE}/web/sites/default/settings.php

echo
echo "Don't forget to add this site to git!"

