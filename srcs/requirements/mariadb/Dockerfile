# Utilise Debian Buster comme base
FROM debian:bullseye

# Met à jour les paquets et installe MariaDB
RUN apt-get update && \
    apt-get install -y apt-utils mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Copie le fichier de configuration personnalisé
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Expose le port 3306 pour permettre la connexion à la base de données
EXPOSE 3306

# À ajouter dans votre Dockerfile MariaDB, si vous optez pour un script d'entrée personnalisé
COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Utilise un script d'entrée personnalisé pour s'assurer que MariaDB est initialisé correctement
CMD ["mysqld_safe"]



