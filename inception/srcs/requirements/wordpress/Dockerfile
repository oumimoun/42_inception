FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

COPY ./wp-config.sh /

RUN chmod +x wp-config.sh

ENTRYPOINT ["/wp-config.sh"]
