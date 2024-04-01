# Utilise Debian Buster comme base
FROM debian:buster

# Met à jour les paquets et installe les dépendances nécessaires, y compris curl et apt-utils
RUN apt-get update && \
    apt-get install -y apt-utils curl php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Crée le dossier nécessaire pour le socket de PHP-FPM
RUN mkdir -p /run/php
# Crée le répertoire de destination pour WordPress
RUN mkdir -p /var/www/html

# Copie le script d'entrée et le rend exécutable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose le port 9000 pour PHP-FPM
EXPOSE 9000

# Utilise le script d'entrée personnalisé
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm7.3", "-F"]

