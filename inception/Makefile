COMPOSE_FILE=srcs/docker-compose.yml

all: up

up:
	@docker-compose -f $(COMPOSE_FILE) up --build

down:
	@docker-compose -f $(COMPOSE_FILE) down

restart: down up

fclean: down
	@docker rmi -f $(docker images -aq)
	@docker volume prune -f
	@docker system prune -f

re: fclean up
