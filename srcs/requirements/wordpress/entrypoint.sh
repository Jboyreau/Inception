#!/bin/bash
set -e

# Attendez que MariaDB soit prête
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    echo 'En attente de MariaDB...'
    sleep 1
done

# Vérifie si WordPress est déjà installé en vérifiant wp-settings.php et avec wp-cli
if [ ! -f "/var/www/html/wp-settings.php" ]; then
    echo "WordPress non trouvé dans /var/www/html, téléchargement de WordPress..."
    # Télécharge et extrait WordPress
    curl -o wordpress.tar.gz -SL "https://wordpress.org/latest.tar.gz" 
    tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1
    rm wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
fi

if ! wp core is-installed --allow-root --path='/var/www/html'; then
    echo "Configuration de WordPress..."
    # Créez un fichier wp-config.php avec les détails de la base de données
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root \
        --path='/var/www/html'

    # Installe WordPress avec les informations d'admin spécifiées dans les variables d'environnement
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Exemple de WordPress" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root \
        --path='/var/www/html'
    # Configurations supplémentaires (thèmes, plugins, etc.) peuvent être ajoutées ici
fi

# Continue avec la commande originale
exec "$@"

