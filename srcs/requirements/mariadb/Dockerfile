FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ENV MYSQL_ROOT_PASS=
ENV MYSQL_DATABASE=
ENV MYSQL_USER=
ENV MYSQL_PASS=

RUN apt-get update && \
    apt-get install --yes mariadb-server

# COPY initialize_database.sql /tmp/initialize_database.sql
# COPY entrypoint.sh /tmp/entrypoint.sh
# RUN chmod +x /tmp/entrypoint.sh

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
# RUN chown mysql:mysql /var/lib/mysql

# RUN service mysql start && mysql -e "$(eval "echo \"$(cat /tmp/initialize_database.sql)\"")

RUN service mysql start && \
mysql -e "CREATE DATABASE wordpress_service; \
CREATE USER 'sql_user'@'%' IDENTIFIED BY '123password123'; \
GRANT ALL PRIVILEGES ON wordpress_service.* to 'sql_user'@'%'; \
FLUSH PRIVILEGES;"

EXPOSE 3306

# ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["mysqld"]
