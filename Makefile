# Parent Makefile focusing on Docker

DOCKER_COMPOSE			= docker-compose
DOCKER_CMD				= docker
DOCKER_CONTAINER_LIST 	= $(shell docker ps -a -q)
DOCKER_IMAGES_LIST		= $(shell docker images -a -q)
LOCAL_SSH_KEY_PATH		= /Users/n.barrera/.ssh/
DOCKER_BUILD			= docker build
DEV_PATH 				= dev

##
###------------#
###    Help    #
###------------#
##

.DEFAULT_GOAL := 	help

help:				## DEFAULT_GOAL : Display help messages
					@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: 			help

##
###-------------------------------------#
###  BBG eshop Oxid6 commands (Docker)  #
###-------------------------------------#
##
build:				## Build Docker images
					@echo '\033[1;42m/!\ In case of a build error, relaunch the builder. All the Docker stack is functional, take a look on your own configuration.\033[0m';
					$(DOCKER_COMPOSE) build
					$(DOCKER_COMPOSE) up -d

logs:				## Show logs
					$(DOCKER_COMPOSE) logs -f

restart:			stop ## Restart the containers
					$(DOCKER_COMPOSE) up -d

stop:				## Stop all containers
					$(DOCKER_COMPOSE) stop

kill:				## Kill Docker containers
					docker-compose kill
					docker-compose down --volumes --remove-orphans

clean:				kill ## Alias coupling kill and remove all generated files from Oxid6

clear:				## Remove all generated files, db, containers, and images
					$(DOCKER_COMPOSE) down -v
					$(MAKE) kill
					$(MAKE) rmi

rmi:				## Remove all images
					@if [ -n "$(DOCKER_CONTAINER_LIST)" ]; \
					 then \
					   	  echo "Removing docker containers"; \
  						  docker rm "$(DOCKER_CONTAINER_LIST)"; \
                     fi

showIp:				## Show all the Ips
					ifeq ($(DOCKER_CONTAINER_LIST),)
						echo 'Empty....'; \
					fi
