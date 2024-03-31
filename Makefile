# Définition des commandes pour simplifier la gestion des conteneurs/docker-compose
all: down build up

build:
	docker-compose -f srcs/docker-compose.yml build # Construit les images Docker selon le docker-compose.yml

up:
	docker-compose -f srcs/docker-compose.yml up -d # Démarre les conteneurs en arrière-plan

down:
	docker-compose -f srcs/docker-compose.yml down # Arrête et supprime les conteneurs

re: down up # Reconstruit l'environnement complet

.PHONY: all build up down re
