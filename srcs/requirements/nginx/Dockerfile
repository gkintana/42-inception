FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes nginx \
                          openssl

RUN openssl req -x509 -nodes \
    -days 365 \
    -subj "/C=AE/ST=Abu Dhabi/O=42 Network/CN=gkintana.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;

COPY ./conf/default /etc/nginx/sites-enabled/default

CMD ["nginx", "-g" ,"daemon off;"]
