NAME := inception
PATH_INCEPTION := .

wp_volume=/home/${USER}/data/wordpress
mariadb_volume=/home/${USER}/data/mariadb
redis_volume=/home/${USER}/data/redis
prometheus_volume=/home/${USER}/data/prometheus

${NAME}:
	mkdir -p $(wp_volume)
	mkdir -p $(mariadb_volume)
	mkdir -p $(redis_volume)
	mkdir -p $(prometheus_volume)
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml up --build 

up:
	mkdir -p $(wp_volume)
	mkdir -p $(mariadb_volume)
	mkdir -p $(redis_volume)
	mkdir -p $(prometheus_volume)
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml up -d --build 

down:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml down

stop:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml stop

start:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml start

rm_volume:
	@if docker volume inspect srcs_mariadb >/dev/null 2>&1; then \
	docker volume rm srcs_mariadb; \
		fi
	@if docker volume inspect srcs_wordpress >/dev/null 2>&1; then \
	docker volume rm srcs_wordpress; \
		fi
	@if docker volume inspect srcs_redis_data >/dev/null 2>&1; then \
	docker volume rm srcs_redis_data; \
		fi
	@if docker volume inspect srcs_prometheus_data >/dev/null 2>&1; then \
	docker volume rm srcs_prometheus_data; \
		fi
	
rm_network:
	docker network prune -f

rm_container:
	docker container prune -f

rm_image:
	docker image prune -f

rm_system:
	docker system prune -af

clean: down rm_image rm_container rm_network rm_system

fclean: down rm_image rm_container rm_volume rm_network rm_system 
	sudo rm -rf $(wp_volume)
	sudo rm -rf $(mariadb_volume)
	sudo rm -rf $(redis_volume)
	sudo rm -rf $(prometheus_volume)

re: fclean ${NAME}