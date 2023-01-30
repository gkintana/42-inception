FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASSWORD=password \
    MYSQL_DATABASE=dbname \
    MYSQL_USER=username \
    MYSQL_PASSWORD=password

RUN apt-get update && \
    apt-get install --yes mariadb-server

RUN service mysql start

# EXPOSE 3306

# CMD ["mysqld"]
