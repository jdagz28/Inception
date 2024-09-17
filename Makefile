# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jdagoy <jdagoy@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/29 01:19:02 by jdagoy            #+#    #+#              #
#    Updated: 2024/09/17 12:30:51 by jdagoy           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


SRCS_DIR    := ./srcs/
WP_DIR      := /home/jdagoy/data/wordpress/
DB_DIR      := /home/jdagoy/data/mariadb/
WEB_DIR		:= /home/jdagoy/data/homepage/
PROM_DIR	:= /home/jdagoy/data/prometheus/

COMPOSE_FILE := $(SRCS_DIR)docker-compose.yml

all: up

up:
	sudo mkdir -p $(WP_DIR)
	sudo mkdir -p $(DB_DIR)
	sudo mkdir -p $(WEB_DIR)
	sudo mkdir -p $(PROM_DIR)
	@docker compose -f $(COMPOSE_FILE) --profile mandatory up -d

down:
	@docker compose -f $(COMPOSE_FILE) --profile mandatory down

start: up
	@docker compose -f $(COMPOSE_FILE) --profile mandatory start

stop:
	@docker compose -f $(COMPOSE_FILE) --profile mandatory stop

build:
	@docker compose -f $(COMPOSE_FILE) --profile mandatory build

accessnginx:
	@docker exec -it nginx zsh

accessmariadb:
	@docker exec -it mariadb zsh

accesswordpress:
	@docker exec -it wordpress zsh

bonus-up:
	sudo mkdir -p $(WP_DIR)
	sudo mkdir -p $(DB_DIR)
	sudo mkdir -p $(WEB_DIR)
	sudo mkdir -p $(PROM_DIR)
	sudo chown -R $(USER):$(USER) /home/jdagoy/data/mariadb/
	sudo chmod -R 755 /home/jdagoy/data/mariadb/
	@docker compose -f $(COMPOSE_FILE) --profile bonus up -d

bonus-down:
	@docker compose -f $(COMPOSE_FILE) --profile bonus down

bonus-start:
	@docker compose -f $(COMPOSE_FILE) --profile bonus start

bonus-stop:
	@docker compose -f $(COMPOSE_FILE) --profile bonus stop

bonus-build:
	@docker compose -f $(COMPOSE_FILE) --profile bonus build

accessredis:
	@docker exec -it redis zsh

accessftp:
	@docker exec -it ftp zsh

accessadminer:
	@docker exec -it adminer zsh

accesswebsite:
	@docker exec -it website zsh

accessprometheus:
	@docker exec -it prometheus zsh

accessgrafana:
	@docker exec -it grafana zsh

stop-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container stop $$(docker container ls -aq); \
	fi

remove-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container rm $$(docker container ls -aq); \
	fi

remove-images:
	@if [ -n "$$(docker images -aq)" ]; then \
		docker rmi -f $$(docker images -aq); \
	fi

remove-networks:
	@docker network ls --format '{{.Name}}' | \
		grep -vE '^(bridge|host|none|system)' | \
		xargs -r docker network rm

clean: down stop-containers remove-containers remove-images remove-networks
	@sudo rm -rf $(WP_DIR)
	@sudo rm -rf $(DB_DIR)
	@sudo rm -rf $(WEB_DIR)
	@sudo rm -rf $(PROM_DIR)

prune: clean
	@docker system prune -a --volumes

re: cleanhome all

.PHONY: all up down start stop build accessnginx accessmariadb accesswordpress clean prune re bonus-up bonus-down bonus-start bonus-stop bonus-build
