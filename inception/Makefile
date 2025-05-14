COMPOSE_FILE=srcs/docker-compose.yml

all: up

up:
	@docker-compose -f $(COMPOSE_FILE) up --build

down:
	@docker-compose -f $(COMPOSE_FILE) down

restart: down up

fclean: down
	@docker image prune -a -f
	@docker volume prune -f
	@docker system prune -a -f

re: fclean up
