FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/mariadb-conf.sh /

RUN chmod +x /mariadb-conf.sh

# EXPOSE 3306

ENTRYPOINT ["/mariadb-conf.sh"]
