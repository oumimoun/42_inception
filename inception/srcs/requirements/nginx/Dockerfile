FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && apt-get clean

RUN mkdir -p /etc/nginx/ssl

ARG DOMAIN_NAME
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Student/CN=${DOMAIN_NAME}" \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt

RUN mkdir -p /var/www/wordpress

COPY ./nginx.conf /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]
