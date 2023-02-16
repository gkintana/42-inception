FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes wget

RUN wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 && \
    chmod +x cadvisor-v0.47.0-linux-amd64

EXPOSE 4242

CMD [ "./cadvisor-v0.47.0-linux-amd64", "-port", "4242" ]

# https://github.com/google/cadvisor
# https://github.com/google/cadvisor/releases
