#!/bin/bash

set -e

service mariadb start
sleep 5

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mariadb -uroot -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mariadb -uroot -e "FLUSH PRIVILEGES;"

mysqladmin -uroot shutdown

exec mysqld_safe --bind-address=0.0.0.0
