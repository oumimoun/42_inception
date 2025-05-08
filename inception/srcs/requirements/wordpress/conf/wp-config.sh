#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/wordpress
cd /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress/

wp core download --allow-root

wp config create \
  --dbname="$MYSQL_DATABASE" \
  --dbuser="$MYSQL_USER" \
  --dbpass="$MYSQL_PASSWORD" \
  --dbhost=mariadb:3306 \
  --skip-check \
  --allow-root

wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USERNAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

wp user create \
    "$WP_USER_USERNAME" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --role="$WP_USER_ROLE" \
    --allow-root

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

exec /usr/sbin/php-fpm7.4 -F
