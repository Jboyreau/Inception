#!/bin/bash
set -e

# Vérifie si WordPress est déjà installé
if [ ! -f "/var/www/html/wp-settings.php" ]; then
    echo "WordPress non trouvé dans /var/www/html, installation..."
    # Télécharge et extrait WordPress
    curl -o wordpress.tar.gz -SL "https://wordpress.org/latest.tar.gz" 
    tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1
    rm wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
fi

# Continue avec la commande originale
exec "$@"

