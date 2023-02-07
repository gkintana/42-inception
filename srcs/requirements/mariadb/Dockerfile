FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASS=
ENV MYSQL_DATABASE=
ENV MYSQL_USER=
ENV MYSQL_PASS=

RUN apt-get update && \
    apt-get install --yes mariadb-server

COPY initialize_database.sql /tmp/initialize_database.sql

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/entrypoint.sh"]
