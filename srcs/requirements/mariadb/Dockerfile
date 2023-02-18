FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ARG MYSQL_ROOT_PASS
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASS

RUN apt-get update && \
    apt-get install --yes mariadb-server

RUN sed -i "s/#port/port /" /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start && \
    mysql -e "CREATE DATABASE ${MYSQL_DATABASE}; \
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}'; \
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* to '${MYSQL_USER}'@'%'; \
    FLUSH PRIVILEGES;"

EXPOSE 3306

CMD ["mysqld"]
