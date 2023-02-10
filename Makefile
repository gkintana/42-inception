list:
	@docker image ls

up:
	docker-compose --file ./srcs/docker-compose.yml up

build_nginx:
	docker build -t 42-nginx ./srcs/requirements/nginx

run_nginx:
	@docker rm 42-nginx || true
	@printf "\033[A"
	docker run --name 42-nginx -p 443:443 -p 80:80 42-nginx

exec_nginx:
	@docker exec -it 42-nginx /bin/bash

clean:
	@docker rmi -f 42-nginx || true

fclean:
	docker-compose --file ./srcs/docker-compose.yml down -v
	docker container rm -f $$(docker container ls -aq) || true
	docker image rm -f $$(docker image ls -q) || true
# fclean:	clean
# @docker rmi debian:buster || true
# docker container prune

rm_none:
	docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force
