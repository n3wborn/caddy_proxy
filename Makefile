DC := docker compose
DE := docker container exec
CONTAINER_NAME := docker-reverse-proxy
NETWORK_NAME := reverse_proxy
CADDY_CONTAINER_ID = $$(docker ps | grep caddy | cut -d' ' -f1)

.PHONY: network
network:
	docker network create $(NETWORK_NAME)

.PHONY: build-no-cache
build-no-cache:
	$(DC) build --no-cache

.PHONY: up
up:
	$(DC) up

.PHONY: up-force-recreate
up-force-recreate:
	$(DC) up --force-recreate --remove-orphans

.PHONY: fmt
fmt:
	$(DE) $(CONTAINER_NAME) caddy fmt --overwrite /etc/caddy/Caddyfile

.PHONY: reload
reload:
	$(DE) -w /etc/caddy $(CADDY_CONTAINER_ID) caddy reload

.PHONY: kill
kill:
	$(DC) kill

.PHONY: down
down:
	$(DC) down

.PHONY: rm_network
rm_network:
	docker network rm $(CONTAINER_NAME)

# create and up everything
.PHONY: install
install: network build up

# Destroy everything and restart from start
.PHONY: recreate-all
recreate-all: down rm_network network build-no-cache up-force-recreate

