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

COPY index.html /usr/share/nginx/html
COPY default /etc/nginx/sites-enabled/
COPY nginx.conf /etc/nginx/

# RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g" ,"daemon off;" ]

# docker run -p 443:443 test
# docker exec -it <cont_name> /bin/bash

# remove docker images with <none> tags
# docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force
