FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes php \
                          php-mysqli \
                          wget

RUN wget --directory-prefix=/var/www/html/ https://www.adminer.org/latest.php

WORKDIR /var/www/html/

RUN rm index.html && mv latest.php index.php

CMD [ "php", "-S", "0.0.0.0:8080" ]
