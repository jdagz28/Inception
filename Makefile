# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jdagoy <jdagoy@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/29 01:19:02 by jdagoy            #+#    #+#              #
#    Updated: 2024/06/18 11:52:28 by jdagoy           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS_DIR    := ./srcs/
WP_DIR      := /home/jdagoy/data/wordpress/
DB_DIR      := /home/jdagoy/data/mariadb/

COMPOSE_FILE := $(SRCS_DIR)docker-compose.yml

all: home #up

home:
	sudo mkdir -p $(WP_DIR)
	sudo mkdir -p $(DB_DIR)
	sudo chown -R $(USER):$(USER) /home/jdagoy/data/mariadb/
	sudo chmod -R 755 /home/jdagoy/data/mariadb/
	@docker compose -f $(COMPOSE_FILE) up -d

up:
	@mkdir -p $(WP_DIR)
	@mkdir -p $(DB_DIR)
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

start: up
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

build:
	@docker compose -f $(COMPOSE_FILE) build

accessnginx:
	@docker exec -it nginx zsh

accessmariadb:
	@docker exec -it mariadb zsh

accesswordpress:
	@docker exec -it wordpress zsh

# Helper function to check if there are containers to stop
stop-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container stop $$(docker container ls -aq); \
	fi

# Helper function to check if there are containers to remove
remove-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container rm $$(docker container ls -aq); \
	fi

# Helper function to check if there are images to remove
remove-images:
	@if [ -n "$$(docker images -aq)" ]; then \
		docker rmi -f $$(docker images -aq); \
	fi

# Helper function to check if there are networks to remove
remove-networks:
	@docker network ls --format '{{.Name}}' | \
		grep -vE '^(bridge|host|none|system)' | \
		xargs -r docker network rm

cleanhome: down stop-containers remove-containers remove-images remove-networks
	@sudo rm -rf $(WP_DIR)
	@sudo rm -rf $(DB_DIR)

clean: down stop-containers remove-containers remove-images remove-networks
	@rm -rf $(WP_DIR)
	@rm -rf $(DB_DIR)

prune: clean
	@docker system prune -a --volumes

re: cleanhome all

.PHONY: all up down start stop build accessnginx accessmariadb accesswordpress clean cleanhome prune home re
