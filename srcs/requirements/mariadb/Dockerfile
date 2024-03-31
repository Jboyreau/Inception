# Utilise Debian Buster comme base
FROM debian:buster

# Met à jour les paquets et installe MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copie le fichier de configuration personnalisé
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Copie le script d'initialisation
COPY ./conf/init-db.sql /docker-entrypoint-initdb.d/

# Expose le port 3306 pour permettre la connexion à la base de données
EXPOSE 3306

# Utilise un script d'entrée personnalisé pour s'assurer que MariaDB est initialisé correctement
CMD ["mysqld_safe"]

