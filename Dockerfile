FROM sameersbn/ubuntu:14.04.20150323
MAINTAINER sameer@damagehead.com

RUN apt-get update \
 && apt-get install -y php5-common php5-cli php5-fpm \
      php5-mysql php5-pgsql php5-gd php5-intl php5-ldap \
      php-mail php-net-smtp php-apc php-xml-parser \
 && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf \
 && sed 's/^output_buffering/; output_buffering/' -i /etc/php5/fpm/php.ini \
 && rm -rf /var/lib/apt/lists/* # 20150323

COPY pool.d/ /etc/php5/fpm/pool.d/
EXPOSE 9000
VOLUME ["/var/run/php5-fpm"]
CMD ["/usr/sbin/php5-fpm"]
