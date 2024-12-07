FROM phpmyadmin:5.2.1-apache

COPY ./conf/config.inc.php /etc/phpmyadmin/config.inc.php
COPY ./certs/ca-cert.pem /etc/ssl/certs/ca-cert.pem
COPY ./certs/client-cert.pem /etc/ssl/certs/client-cert.pem
COPY ./certs/client-key.pem /etc/ssl/certs/client-key.pem

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80