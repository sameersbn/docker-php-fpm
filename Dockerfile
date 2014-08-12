FROM sameersbn/ubuntu:12.04.20140812
MAINTAINER sameer@damagehead.com

RUN apt-get update && \
		apt-get install -y php5-common php5-cli php5-fpm php5-mysql php5-pgsql php5-gd && \
		sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf && \
		apt-get clean # 20140629

ADD pool.d/ /etc/php5/fpm/pool.d/
EXPOSE 9000
VOLUME ["/var/run/php5-fpm"]
CMD ["/usr/sbin/php5-fpm"]
