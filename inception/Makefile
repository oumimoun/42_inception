COMPOSE_FILE=srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/oumimoun/data/wordpress_data
	@mkdir -p /home/oumimoun/data/mariadb_data
	@docker compose -f $(COMPOSE_FILE) up --build

down:
	@docker compose -f $(COMPOSE_FILE) down -v 
	

restart: down up

fclean: down
	@docker image prune -a -f
	@docker volume prune -f
	@docker system prune -a -f

re: fclean up
