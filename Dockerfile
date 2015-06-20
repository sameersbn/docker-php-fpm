FROM sameersbn/ubuntu:14.04.20150613
MAINTAINER sameer@damagehead.com

ENV PHP_FPM_USER=www-data

RUN apt-get update \
 && apt-get install -y php5-fpm php5-cli php5-pgsql php5-mysql php5-gd \
 && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf \
 && rm -rf /var/lib/apt/lists/* # 20150613

COPY pool.d/ /etc/php5/fpm/pool.d/
CMD ["/usr/sbin/php5-fpm"]

EXPOSE 9000
