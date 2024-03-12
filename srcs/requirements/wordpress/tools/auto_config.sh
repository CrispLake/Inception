#!/bin/sh

if [ ! -d "/var/www/wordpress" ]
then
sleep 10
wp core download --allow-root

wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306

wp core install --allow-root \
	--title=myTitle \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASS  \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email \
	--url='emajuri.42.fr'


wp user create --allow-root \
	$WP_USER \
	$WP_USER_EMAIL \
	--user_pass=$WP_USER_PASS

fi

path="/run/php"

if [ ! -d "$path" ]; then
	mkdir -p "$path"
fi

/usr/sbin/php-fpm7.4 -F
