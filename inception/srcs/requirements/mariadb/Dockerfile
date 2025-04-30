FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY ./mariadb-conf.sh /usr/local/bin/mariadb-conf.sh

RUN chmod +x /usr/local/bin/mariadb-conf.sh

EXPOSE 3306

CMD ["/usr/local/bin/mariadb-conf.sh"]
