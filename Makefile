up:	directories certificates
	docker compose --file ./srcs/docker-compose.yml --env-file srcs/.env up

directories:
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		for dir in mariadb_volume wordpress_volume; do \
			mkdir -p ./data/$$dir; \
		done; \
		for dir in mariadb phpmyadmin wordpress; do \
			mkdir -p ./srcs/requirements/$$dir/certs; \
		done; \
	fi

certificates:	generate_certificates
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		for dir in mariadb phpmyadmin wordpress; do \
			cp ./ca-cert.pem ./srcs/requirements/$$dir/certs; \
		done; \
		for dir in mariadb; do \
			cp ./server-cert.pem ./srcs/requirements/$$dir/certs; \
			cp ./server-key.pem ./srcs/requirements/$$dir/certs; \
		done; \
		for dir in phpmyadmin wordpress; do \
			cp ./client-cert.pem ./srcs/requirements/$$dir/certs; \
			cp ./client-key.pem ./srcs/requirements/$$dir/certs; \
		done; \
		rm *.pem; \
	fi

generate_certificates:
	@if ! docker volume inspect srcs_mariadb_volume > /dev/null 2>&1 && ! docker volume inspect srcs_wordpress_volume > /dev/null 2>&1; then \
		openssl genrsa 2048 > ca-key.pem; \
		openssl req -new -x509 -nodes -days 365000 -subj "/CN=mariadb-auth" -key ca-key.pem -out ca-cert.pem; \
		openssl req -newkey rsa:2048 -days 365000 -subj "/CN=mariadb" -nodes -keyout server-key.pem -out server-req.pem; \
		openssl rsa -in server-key.pem -out server-key.pem; \
		openssl x509 -req -in server-req.pem -days 365000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem; \
		openssl req -newkey rsa:2048 -days 365000 -subj "/CN=mariadb" -nodes -keyout client-key.pem -out client-req.pem; \
		openssl rsa -in client-key.pem -out client-key.pem; \
		openssl x509 -req -in client-req.pem -days 365000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem; \
	fi

down:
	docker compose --file ./srcs/docker-compose.yml down -v

hosts:
	@sudo sed -i "3s|.*|$$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx)    cloud1.42ad.ae|" /etc/hosts

clean:	down
	docker container rm -f $$(docker container ls -aq) || true
	docker image rm -f $$(docker image ls -q) || true
	docker volume rm $$(docker volume ls -q) || true
	rm -rf ./data
	rm -rf ./srcs/requirements/mariadb/certs
	rm -rf ./srcs/requirements/phpmyadmin/certs
	rm -rf ./srcs/requirements/wordpress/certs

re:	clean up

rm_none:
	docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force

.PHONY: up directories certificates generate_certificates down hosts clean re rm_none
