FROM sameersbn/ubuntu:14.04.20150613
MAINTAINER sameer@damagehead.com

RUN apt-get update \
 && apt-get install -y php5-common php5-cli php5-fpm \
      php5-mysql php5-pgsql php5-gd php5-intl php5-ldap \
      php5-curl php5-mcrypt php5-gmp php5-imagick php5-apcu \
      php-mail php-net-smtp php-xml-parser php-net-ftp \
 && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf \
 && rm -rf /var/lib/apt/lists/* # 20150613

COPY pool.d/ /etc/php5/fpm/pool.d/
VOLUME ["/var/run/php5-fpm"]
CMD ["/usr/sbin/php5-fpm"]
