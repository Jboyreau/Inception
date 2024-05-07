#!/bin/bash
set -e

if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initialisation de la base de données..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    mysqld_safe --nowatch &

    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Utilisation de la nouvelle syntaxe pour définir le mot de passe
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`jboyreau\`@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`jboyreau\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM ''@'localhost';"  # Révoquer les privilèges pour les utilisateurs sans mot de passe
    mysql -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM ''@'%';"  # Révoquer les privilèges pour les utilisateurs sans mot de passe    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

exec "$@"


