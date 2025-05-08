#!/bin/bash

set -e

service mariadb start
sleep 5

echo "MYSQL_DATABASE: \`${MYSQL_DATABASE}\`"
echo "MYSQL_USER: \`${MYSQL_USER}\`"

mariadb -uroot <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -uroot shutdown

exec mariadbd --bind-address=0.0.0.0
