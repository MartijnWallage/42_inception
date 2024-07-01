NAME := inception
PATH_INCEPTION := .

wp_volume=/home/${USER}/data/wordpress
mariadb_volume=/home/${USER}/data/mariadb
prometheus_volume=/home/${USER}/data/prometheus
grafana_volume=/home/${USER}/data/grafana
redis_volume=/home/${USER}/data/redis

all: ${NAME}

${NAME}:
	mkdir -p $(wp_volume)
	mkdir -p $(mariadb_volume)
	mkdir -p $(prometheus_volume)
	mkdir -p $(grafana_volume)
	mkdir -p $(redis_volume)
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml up --build 

up:
	mkdir -p $(wp_volume)
	mkdir -p $(mariadb_volume)
	mkdir -p $(prometheus_volume)
	mkdir -p $(grafana_volume)
	mkdir -p $(redis_volume)
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml up -d --build 

down:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml down

stop:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml stop

start:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml start

restart: down up

logs:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml logs

ps:
	docker compose -f $(PATH_INCEPTION)/srcs/docker-compose.yml ps

rm_network:
	docker network prune -f

rm_container:
	docker container prune -f

rm_image:
	docker image prune -f

rm_volume:
	docker volume prune -af

rm_system:
	docker system prune -af

clean: down rm_image rm_container rm_network rm_system

fclean: down rm_image rm_container rm_network rm_volume rm_system

re: fclean ${NAME}

.PHONY: inception

inception:
	@trap 'echo "Stopping..."; docker-compose down' SIGINT;

.PHONY: all up down restart logs ps build clean fclean re