FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes apache2

COPY ./website/* /var/www/html/

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]
