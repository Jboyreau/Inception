# Définition des commandes pour simplifier la gestion des conteneurs/docker-compose
all: down build up

build:
	docker-compose -f srcs/docker-compose.yml build # Construit les images Docker selon le docker-compose.yml

up: permissions
	docker-compose -f srcs/docker-compose.yml up -d # Démarre les conteneurs en arrière-plan

down:
	docker-compose -f srcs/docker-compose.yml down # Arrête et supprime les conteneurs

permissions:
	mkdir -p srcs/data
	chmod 777 srcs/data # Change les permissions du dossier data

re: down up # Reconstruit l'environnement complet

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes
	docker system prune -a -f --volumes
	rm -rf ../data/*

rebuild: clean
	docker-compose -f srcs/docker-compose.yml up -d

.PHONY: all build up down re permissions rebuild

