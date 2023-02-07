FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASS="InceptionProject@42"
ENV MYSQL_DATABASE="wordpress_service_database"
ENV MYSQL_USER="gkintana"
ENV MYSQL_PASS="password123"

RUN apt-get update && \
    apt-get install --yes mariadb-server

COPY initialize_database.sql /tmp/initialize_database.sql

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD ["mariadb"]
