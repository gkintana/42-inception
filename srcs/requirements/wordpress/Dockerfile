FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes php-fpm \
                          php-mysql \
                          curl \
                          sendmail

# RUN wget http://wordpress.org/latest.tar.gz -P /var/www/html/ && \
#     tar -xzvf /var/www/html/latest.tar.gz --directory /var/www/html/ && \
#     rm /var/www/html/latest.tar.gz && \
#     mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php && \
#     mv /var/www/html/wordpress/* /var/www/html/ && \
#     rm -rf /var/www/html/wordpress/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html/
RUN wp core download --allow-root --path=/var/www/html/

# RUN	sed -i 's/database_name_here/test_db/' /var/www/html/wp-config.php && \
# 	sed -i 's/username_here/test_user/' /var/www/html/wp-config.php && \
# 	sed -i 's/password_here/password123/' /var/www/html/wp-config.php && \
# 	sed -i 's/localhost/mariadb/' /var/www/html/wp-config.php && \
# 	sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.3/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/

COPY entrypoint.sh /tmp
RUN chmod +x /tmp/entrypoint.sh

WORKDIR /var/www/html/

EXPOSE 9000

RUN mkdir /run/php
ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["php-fpm7.3", "-F"]

# docker run -p 9000:9000 -it test
