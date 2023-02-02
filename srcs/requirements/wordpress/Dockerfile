FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes php-fpm \
                          php-mysql \
                          wget

RUN wget http://wordpress.org/latest.tar.gz -P /var/www/html/ && \
    tar -xzvf /var/www/html/latest.tar.gz --directory /var/www/html/ && \
    rm /var/www/html/latest.tar.gz && \
    mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php && \
    mv /var/www/html/wordpress/* /var/www/html/ && \
    rm -rf /var/www/html/wordpress/ && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/

EXPOSE 9000

WORKDIR /var/www/html/
CMD ["php", "-S", "0.0.0.0:9000"]

# docker run -p 9000:9000 -it test
