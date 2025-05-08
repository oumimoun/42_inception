FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

RUN --mount=type=secret,id=db_ps cat ../../../secret/db_password.txt

COPY ./mariadb-conf.sh /mariadb-conf.sh

RUN chmod +x /mariadb-conf.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb-conf.sh"]
