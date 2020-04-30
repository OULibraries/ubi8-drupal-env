#!/bin/bash

# Run php-fpm as with user and group from host if defined 
[ ! -z "${HOST_UID}" ] && sed -i "s/^user = .*/user = ${HOST_UID} /"   /etc/php-fpm.d/www.conf
[ ! -z "${HOST_GID}" ] && sed -i "s/^group = .*/user = ${HOST_GID} /"   /etc/php-fpm.d/www.conf

exec "$@"
