FROM ubuntu:bionic-20190612 AS add-apt-repositories

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
 && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list

FROM ubuntu:bionic-20190612

LABEL maintainer="sameer@damagehead.com"

ENV PHP_VERSION=7.2 \
    PHP_FPM_USER=www-data

COPY --from=add-apt-repositories /etc/apt/trusted.gpg /etc/apt/trusted.gpg

COPY --from=add-apt-repositories /etc/apt/sources.list /etc/apt/sources.list

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-gd \
      php${PHP_VERSION}-pgsql php${PHP_VERSION}-mysql \
 && mkdir -p /run/php/ \
 && sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf \
 && rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/php-fpm7.2", "-F"]

EXPOSE 9000
