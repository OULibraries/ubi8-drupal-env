#!/usr/bin/env bash 

if [  -z "$1" ]; then
  cat <<USAGE
drp_create_site.sh builds a Drupal project folder.
Usage: drp_create_site.sh \$SITE
\$SITE    local name for Drupal site (eg. example or demo-site).
USAGE
  exit 1;
fi

if [ ! -d "./sites" ]; then
  echo "No sites directory. Are you in the right place?"
  exit 1;
fi

SITE=$1

if [ -d "./sites/${SITE}" ]; then
  echo "There's already a something at ./sites/${SITE}."
  exit 1;
fi


## 
echo "Let's build a site!"
echo "building ${SITE}" 

mkdir -p "./sites/${SITE}"


HOST_UID=$(id -u)
HOST_GID=$(id -g)

docker run --env COMPOSER_HOME=/tmp/composer --user ${HOST_UID}:${HOST_GID} --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli bash -c \
"composer create-project drupal/recommended-project ./sites/${SITE} \
&& composer require --working-dir ./sites/${SITE} drush/drush:~10  drupal/console:~1 \
  --prefer-dist \
  --optimize-autoloader"

read -r -d '' INCLUDELOCAL <<- EOF
if (file_exists(\$app_root . '/' . \$site_path . '/settings.local.php')) {
  include \$app_root . '/' . \$site_path . '/settings.local.php';
}
EOF

cp "./sites/${SITE}/web/sites/default/default.settings.php" "./sites/${SITE}/web/sites/default/settings.php"
echo  "${INCLUDELOCAL}" >> "./sites/${SITE}/web/sites/default/settings.php"

echo
echo "Don't forget to add this site to git!"

