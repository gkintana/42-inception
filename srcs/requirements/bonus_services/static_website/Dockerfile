FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes apache2

# COPY index.html /var/www/html/

CMD ["apache2ctl", "-D", "FOREGROUND"]

# https://ubuntu.com/tutorials/install-and-configure-apache#1-overview
