FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

COPY ./wp_config.php /

RUN chmod +x wp_config.php

EXPOSE 9000

ENTRYPOINT ["php", "/wp_config.php"]
