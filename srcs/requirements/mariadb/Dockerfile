FROM debian:12.8

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ARG MYSQL_ROOT_PASS
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASS

COPY ./certs/ca-cert.pem /etc/ssl/certs/ca-cert.pem
COPY ./certs/server-cert.pem /etc/ssl/certs/server-cert.pem
COPY ./certs/server-key.pem /etc/ssl/certs/server-key.pem

RUN apt-get update && \
	apt-get install --yes mariadb-server

RUN sed -i "s|#port|port |" /etc/mysql/mariadb.conf.d/50-server.cnf && \
	sed -i "s|127.0.0.1|0.0.0.0|" /etc/mysql/mariadb.conf.d/50-server.cnf && \
	sed -i "s|#ssl-ca = /etc/mysql/cacert.pem|ssl-ca = /etc/ssl/certs/ca-cert.pem|" /etc/mysql/mariadb.conf.d/50-server.cnf && \
	sed -i "s|#ssl-cert = /etc/mysql/server-cert.pem|ssl-cert = /etc/ssl/certs/server-cert.pem|" /etc/mysql/mariadb.conf.d/50-server.cnf && \
	sed -i "s|#ssl-key = /etc/mysql/server-key.pem|ssl-key = /etc/ssl/certs/server-key.pem|" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start && \
	mariadb -u root -e "CREATE DATABASE ${MYSQL_DATABASE}; \
	CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}'; \
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* to '${MYSQL_USER}'@'%'; \
	FLUSH PRIVILEGES; \
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"

EXPOSE 3306

CMD ["mysqld", "-u", "root"]