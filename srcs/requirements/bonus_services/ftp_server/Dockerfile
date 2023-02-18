FROM debian:buster

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"

ARG FTP_USER
ARG FTP_PASS

RUN apt-get update && \
    apt-get install --yes vsftpd

RUN adduser "${FTP_USER}" --disabled-password && \
	# usermod --password $FTP_PASS $FTP_USER && \
	echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
	mkdir -p "/home/${FTP_USER}/ftp/files" && \
	# mkdir /home/$FTP_USER/ftp/ && \
	chown nobody:nogroup "/home/${FTP_USER}/ftp" && \
	chmod a-w "/home/${FTP_USER}/ftp" && \
	# mkdir /home/$FTP_USER/ftp/files && \
	chown "${FTP_USER}:${FTP_USER}" "/home/${FTP_USER}/ftp/files" && \
	mkdir -p /var/run/vsftpd/empty

COPY ./vsftpd.conf /etc/vsftpd.conf

RUN echo "${FTP_USER}" >> /etc/vsftpd.userlist

WORKDIR /var/www/html

# EXPOSE 21
CMD ["vsftpd", "/etc/vsftpd.conf"]

# https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-20-04
