FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ARG HTML_DIR="/var/www/html/"
ARG WP_DIR="${HTML_DIR}/wordpress"
ARG TAR_FILE="latest.tar.gz"

RUN apt-get update && \
    apt-get install --yes php-fpm \
                          wget

RUN wget http://wordpress.org/${TAR_FILE} -P ${HTML_DIR} && \
    tar -xzvf ${HTML_DIR}/${TAR_FILE} --directory ${HTML_DIR} && \
    rm ${HTML_DIR}/${TAR_FILE} && \
    mv ${WP_DIR}/wp-config-sample.php ${WP_DIR}/wp-config.php && \
    mv ${WP_DIR}/* ${HTML_DIR}/ && \
    rm -rf ${WP_DIR}/ && \
    chown -R www-data:www-data ${HTML_DIR}/ && \
    chmod -R 755 ${HTML_DIR}/
