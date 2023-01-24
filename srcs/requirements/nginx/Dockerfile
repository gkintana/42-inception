FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes nginx
# RUN export PATH=/usr/sbin/:$PATH

COPY index.html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g" ,"daemon off;" ]

# docker run -p 443:443 test
# docker exec -it <cont_name> /bin/bash

# remove docker images with <none> tags
# docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force
