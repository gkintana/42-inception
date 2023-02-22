FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes apache2 \
                          git

RUN git clone https://github.com/gkintana/42AD-learning-portfolio.git /tmp/webpage && \
    cp /tmp/webpage/* var/www/html/

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]
