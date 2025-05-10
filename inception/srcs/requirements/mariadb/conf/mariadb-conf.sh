#!/bin/bash

service mariadb start
sleep 5

echo "MARIADB_DATABASE: \`${MARIADB_DATABASE}\`"
echo "MARIADB_USER: \`${MARIADB_USER}\`"

mariadb -uroot <<EOF
CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -uroot shutdown

exec mariadbd --bind-address=0.0.0.0
