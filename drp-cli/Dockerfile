# Usage for resulting container is 
# podman run --volume "$PWD":/mnt/data:z --workdir /mnt/data  --rm -i -t drp-cli composer  create-project  drupal/recommended-project drupal-site

FROM registry.redhat.io/ubi8/ubi

RUN dnf --disableplugin=subscription-manager module install -y  php 
RUN dnf --disableplugin=subscription-manager install -y php-gd php-pdo  git zip

RUN sed -Ei 's/memory_limit = .*/memory_limit = 1024M/' /etc/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

VOLUME ["/mnt/data"]

WORKDIR /mnt/data

