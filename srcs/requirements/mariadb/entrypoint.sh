#!/bin/bash
set -e

# Initialisation de la base de données si le répertoire /var/lib/mysql est vide
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initialisation de la base de données..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    # Démarrage temporaire de MariaDB
    mysqld_safe --nowatch

    # Attente de démarrage de MariaDB
    until mysqladmin ping >/dev/null 2>&1; do
        echo "En attente de démarrage de MariaDB..."
        sleep 1
    done

    # Exécution des scripts d'initialisation
    if [ -d /docker-entrypoint-initdb.d ]; then
        echo "Exécution des scripts d'initialisation..."
        for script in /docker-entrypoint-initdb.d/*.sql; do
            echo "Exécution de $script"
            mysql < "$script"
        done
    fi

    # Arrêt de MariaDB après initialisation
    mysqladmin shutdown
fi

# Démarrage normal de MariaDB
exec "$@"

