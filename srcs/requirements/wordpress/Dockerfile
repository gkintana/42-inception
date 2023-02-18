FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes php-fpm \
                          php-mysql \
                          curl \
                          sendmail

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html/

COPY entrypoint.sh /tmp
RUN chmod +x /tmp/entrypoint.sh

WORKDIR /var/www/html/

RUN wp core download --allow-root

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["php-fpm7.3", "-F"]
