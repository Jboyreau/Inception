#!/bin/bash
set -e

# Attendez que MariaDB soit prête
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    echo 'En attente de MariaDB...'
    sleep 1
done

# Télécharge et prépare WordPress si non installé
if [ ! -f "/var/www/html/wp-settings.php" ]; then
    echo "WordPress non trouvé dans /var/www/html, téléchargement et extraction..."
    curl -o wordpress.tar.gz -SL "https://wordpress.org/latest.tar.gz"
    tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1
    rm wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
fi

# Configure WordPress si wp-config.php n'existe pas
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Configuration de WordPress..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root \
        --path='/var/www/html'
fi

# Installe WordPress si pas déjà installé
if ! wp core is-installed --allow-root --path='/var/www/html'; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Exemple WordPress" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root \
        --path='/var/www/html'
fi

# Continue avec la commande originale
exec "$@"

