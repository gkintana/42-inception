FROM phpmyadmin:latest

ENV PMA_HOST=mariadb
ENV PMA_PORT=3306

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80