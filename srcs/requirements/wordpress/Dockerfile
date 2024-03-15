FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y wget \
	php7.4 \
	php-fpm \
	php-mysql \
	mariadb-client

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/auto_config.sh /tmp/auto_config.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["sh", "/tmp/auto_config.sh"]
