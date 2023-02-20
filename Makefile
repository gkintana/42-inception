up:
	mkdir -p /home/${USER}/data/mariadb_volume
	mkdir -p /home/${USER}/data/wordpress_volume
	docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up

down:
	docker-compose --file ./srcs/docker-compose.yml down -v

hosts:
	@sudo sed -i "3s|.*|$$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx)    gkintana.42.fr|" /etc/hosts

clean:	down
	docker container rm -f $$(docker container ls -aq) || true
	docker image rm -f $$(docker image ls -q) || true
	docker volume rm $$(docker volume ls -q) || true
	sudo rm -rf /home/${USER}/data

re:	clean up

rm_none:
	docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force

.PHONY: up down hosts clean re rm_none
