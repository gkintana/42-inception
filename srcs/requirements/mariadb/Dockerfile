FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASSWORD=password \
    MYSQL_DATABASE=dbname \
    MYSQL_USER=username \
    MYSQL_PASSWORD=password

RUN apt-get update && \
    apt-get install --yes mariadb-server

# EXPOSE 3306

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mariadb"]
