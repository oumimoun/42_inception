NAME=inception
COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all up down restart logs fclean re

all: up

up:
	@echo "🚀 Starting services..."
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	@echo "🛑 Stopping and removing containers..."
	@$(COMPOSE) -f $(COMPOSE_FILE) down

restart: down up

logs:
	@$(COMPOSE) -f $(COMPOSE_FILE) logs -f --tail=100

fclean: down
	@echo "🧹 Removing volumes..."
	@docker volume prune -f
	@docker system prune -f

re: fclean up