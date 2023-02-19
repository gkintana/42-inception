up:
	mkdir -p /home/${USER}/data/mariadb_volume
	mkdir -p /home/${USER}/data/wordpress_volume
	docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up

hosts:
	@sudo sed -i "3s|.*|$$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx)    gkintana.42.fr|" /etc/hosts

# clean:
# 	@docker rmi -f 42-nginx || true

fclean:
	docker-compose --file ./srcs/docker-compose.yml down -v
	docker container rm -f $$(docker container ls -aq) || true
	docker image rm -f $$(docker image ls -q) || true
	sudo rm -rf /home/${USER}/data
# fclean:	clean
# @docker rmi debian:buster || true
# docker container prune

rm_none:
	docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force
