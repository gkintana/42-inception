FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASS=
ENV MYSQL_DATABASE=
ENV MYSQL_USER=
ENV MYSQL_PASS=

RUN apt-get update && \
    apt-get install --yes mariadb-server

RUN sed -i "s/#port/port /" /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start && \
mysql -e "CREATE DATABASE wordpress_service; \
CREATE USER 'sql_user'@'%' IDENTIFIED BY '123password123'; \
GRANT ALL PRIVILEGES ON wordpress_service.* to 'sql_user'@'%'; \
FLUSH PRIVILEGES;"

# RUN service mysql start && `mysql < /tmp/initialize_database.sql`

# try in an updated docker-compose ver.
# RUN service mysql start && mysql -e "$(eval echo \"$(cat /tmp/initialize_database.sql)\")"

EXPOSE 3306

CMD ["mysqld"]
