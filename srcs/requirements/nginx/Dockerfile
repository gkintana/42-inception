FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ARG SSL_C
ARG SSL_ST
ARG SSL_O
ARG DOMAIN_NAME

RUN apt-get update && \
    apt-get install --yes nginx \
                          openssl

RUN openssl req -x509 -nodes \
    -days 365 \
    -subj "/C=${SSL_C}/ST=${SSL_ST}/O=${SSL_O}/CN=${DOMAIN_NAME}" \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;

COPY ./conf/default /etc/nginx/sites-enabled/default

CMD ["nginx", "-g" ,"daemon off;"]
