# Usage for resulting container is 
# podman run --volume "$PWD":/mnt/data:z --workdir /mnt/data  --rm -i -t rh-ubi-composer create-project  drupal/recommended-project mysite


FROM registry.redhat.io/ubi8/ubi

RUN yum --disableplugin=subscription-manager  install -y nginx git

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Add container-friendly nginx config for Drupal
COPY nginx.conf /etc/nginx/nginx.conf
COPY drupal.conf /etc/nginx/conf.d/drupal.conf

COPY ../sites/drupal-demo /var/www/drupal

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
