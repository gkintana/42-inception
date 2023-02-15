FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

RUN apt-get update && \
    apt-get install --yes apt-utils wget

# RUN wget https://lxc-webpanel.github.io/tools/install.sh && chmod +x install.sh && ./install.sh
# RUN wget https://lxc-webpanel.github.io/tools/install.sh -O - | bash
# ENTRYPOINT [ "./install.sh" ]
# CMD ["bash"]
# CMD [ "sleep", "infinity" ]

RUN wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && \
    sh /tmp/netdata-kickstart.sh && \
    service netdata start

# CMD [ "service", "netdata", "start" ]
# CMD [ "bash" ]

# docker run -p19999:19999 -it test
