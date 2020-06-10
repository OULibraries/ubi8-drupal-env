# Usage for resulting container is 
# podman run --volume "$PWD":/mnt/data:z --workdir /mnt/data  --rm -i -t rh-ubi-composer create-project  drupal/recommended-project mysite


FROM registry.redhat.io/ubi8/ubi

RUN dnf --disableplugin=subscription-manager module install -y  php:7.3
RUN yum --disableplugin=subscription-manager install -y php-gd php-pdo php-mysqlnd php-opcache git

COPY www.conf /etc/php-fpm.d/www.conf

RUN ln -sf /dev/stdout /var/log/php-fpm/access.log  \
 && ln -sf /dev/stderr /var/log/php-fpm/error.log


RUN mkdir /run/php-fpm \
 && chgrp -R 0 /run/php-fpm \
 && chmod -R g=u /run/php-fpm

# Override stop signal to stop process gracefully
# https://github.com/php/php-src/blob/17baa87faddc2550def3ae7314236826bc1b1398/sapi/fpm/php-fpm.8.in#L163
STOPSIGNAL SIGQUIT

EXPOSE 9000


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm", "-F", "-R"]
