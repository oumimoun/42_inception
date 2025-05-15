FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes \
    -out /etc/nginx/certs/fullchain.pem \
    -keyout /etc/nginx/certs/privkey.pem \
    -subj "/CN=oumimoun.42.fr"

COPY ./conf/wp_nginx.conf /etc/nginx/sites-available

RUN ln /etc/nginx/sites-available/wp_nginx.conf /etc/nginx/sites-enabled/wp_nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
