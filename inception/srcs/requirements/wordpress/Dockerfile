FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php-fpm php-mysql mariadb-client

COPY ./conf/wp-config.sh /

RUN chmod +x wp-config.sh

ENTRYPOINT ["./wp-config.sh"]
