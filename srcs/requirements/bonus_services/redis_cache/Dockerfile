FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes redis

# COPY redis.conf /usr/local/etc/redis/redis.conf

RUN sed -i "s/# maxmemory <bytes>/maxmemory 128M/" /etc/redis/redis.conf && \
    sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lfu/" /etc/redis/redis.conf

CMD [ "redis-server" ]
# CMD [ "redis-server", "/etc/redis/redis.conf" ]
# CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

# CMD [ "redis-server" ]
# CMD ["redis-server", "--logfile stdout"]

# https://www.youtube.com/watch?v=JrrSYypaXk4
