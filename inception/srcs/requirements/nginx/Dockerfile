FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/certs

RUN openssl req -x509 -nodes -out /etc/nginx/certs/fullchain.pem \
    -keyout /etc/nginx/certs/privkey.pem \
    -subj "/C=MO/L=KH/O=42/CN=oumimoun.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
