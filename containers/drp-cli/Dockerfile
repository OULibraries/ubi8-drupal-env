# Usage for resulting container is 
# podman run --volume "$PWD":/mnt/data:z --workdir /mnt/data  --rm -i -t drp-cli composer  create-project  drupal/recommended-project drupal-site

FROM registry.redhat.io/ubi8/ubi

RUN dnf --disableplugin=subscription-manager module install -y  php:7.3
RUN dnf --disableplugin=subscription-manager install -y php-gd php-pdo php-mysqlnd php-opcache  

RUN dnf --disableplugin=subscription-manager install -y git zip bind-utils


RUN dnf --disableplugin=subscription-manager install -y python3-pip
RUN pip3 install awscli

RUN dnf --disableplugin=subscription-manager install -y sqlite

RUN dnf --disableplugin=subscription-manager install -y http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql57-community-release-el7-10.noarch.rpm
RUN dnf --disableplugin=subscription-manager install  -y mysql



RUN sed -Ei 's/memory_limit = .*/memory_limit = -1/' /etc/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

VOLUME ["/mnt/data"]

WORKDIR /mnt/data

