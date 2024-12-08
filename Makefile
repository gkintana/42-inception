VOLUMES = /home/${USER}/data
VOLUME_MARIADB = ${VOLUMES}/mariadb
VOLUME_WORDPRESS = ${VOLUMES}/wordpress
CERTS_MARIADB = ./srcs/requirements/mariadb/certs
CERTS_WORDPRESS = ./srcs/requirements/wordpress/certs
CERTS_PHPMYADMIN = ./srcs/requirements/phpmyadmin/certs

up:	setup directories certificates
	docker compose --file ./srcs/docker-compose.yml --env-file srcs/.env up --detach

setup:
	@if [ "${USER}" != "$$(stat -c %U .)" ]; then \
		sudo chown -R ${USER}:${USER} .; \
	fi
	@if ! grep -q "DOMAIN_NAME=" ./srcs/.env; then \
		sed -i "1s|^|DOMAIN_NAME=$$(curl -s ifconfig.me)\n\n|" ./srcs/.env; \
	fi

directories:
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		mkdir -p $(VOLUME_MARIADB) $(VOLUME_WORDPRESS) $(CERTS_MARIADB) $(CERTS_WORDPRESS) $(CERTS_PHPMYADMIN); \
	fi

certificates:	generate_certificates
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		for dir in $(CERTS_MARIADB) $(CERTS_WORDPRESS) $(CERTS_PHPMYADMIN); do \
			cp ./ca-cert.pem $$dir; \
		done; \
		for dir in $(CERTS_MARIADB); do \
			cp ./server-cert.pem $$dir; \
			cp ./server-key.pem $$dir; \
		done; \
		for dir in $(CERTS_WORDPRESS) $(CERTS_PHPMYADMIN); do \
			cp ./client-cert.pem $$dir; \
			cp ./client-key.pem $$dir; \
		done; \
		rm *.pem; \
	fi

generate_certificates:
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		openssl genrsa 2048 > ca-key.pem; \
		openssl req -new -x509 -nodes -days 365 -subj "/CN=mariadb-auth" -key ca-key.pem -out ca-cert.pem; \
		openssl req -newkey rsa:2048 -subj "/CN=mariadb" -nodes -keyout server-key.pem -out server-req.pem; \
		openssl rsa -in server-key.pem -out server-key.pem; \
		openssl x509 -req -in server-req.pem -days 365 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem; \
		openssl req -newkey rsa:2048 -subj "/CN=mariadb" -nodes -keyout client-key.pem -out client-req.pem; \
		openssl rsa -in client-key.pem -out client-key.pem; \
		openssl x509 -req -in client-req.pem -days 365 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem; \
		chmod 644 *.pem; \
	fi

down:
	docker compose --file ./srcs/docker-compose.yml down -v

clean:	down
	docker container rm -f $$(docker container ls -aq) || true
	docker image rm -f $$(docker image ls -q) || true
	docker volume rm $$(docker volume ls -q) || true
	sudo rm -rf ${VOLUMES}
	rm -rf $(CERTS_MARIADB) $(CERTS_WORDPRESS) $(CERTS_PHPMYADMIN)

re:	clean up

rm_none:
	docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force

.PHONY: up setup directories certificates generate_certificates down hosts clean re rm_none
