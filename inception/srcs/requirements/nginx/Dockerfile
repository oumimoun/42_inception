FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes \
    -out /etc/nginx/certs/fullchain.pem \
    -keyout /etc/nginx/certs/privkey.pem \
    -subj "/C=MO/L=KH/O=42/OU=1337/CN=oumimoun.42.fr/UID=oumimoun"

COPY ./conf/wp_nginx.conf /etc/nginx/sites-enabled

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
