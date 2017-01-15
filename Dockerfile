FROM sameersbn/ubuntu:14.04.20170110
MAINTAINER sameer@damagehead.com

ENV PHP_FPM_USER=www-data

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
 && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y php5-fpm php5-cli php5-pgsql php5-mysql php5-gd \
 && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf \
 && rm -rf /var/lib/apt/lists/*

COPY pool.d/ /etc/php5/fpm/pool.d/
CMD ["/usr/sbin/php5-fpm"]

EXPOSE 9000
