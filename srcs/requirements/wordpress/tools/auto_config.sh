#!/bin/sh

sleep 10
wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --title=myTitle \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASS  \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email

wp user create $WP_USER \
	$WP_USER_EMAIL \
	--user_pass=$WP_USER_PASS

path="/run/php"

if [! -d "$path" ]; then
	mkdir -p "$path"
fi

/usr/sbin/php-fpm7.4 -F
