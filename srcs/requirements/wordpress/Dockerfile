# Utilise Debian Buster comme base
FROM debian:buster

# Met à jour les paquets et installe les dépendances nécessaires, y compris curl et apt-utils
RUN apt-get update && \
    apt-get install -y apt-utils curl php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Télécharge et décompresse WordPress dans le dossier par défaut
RUN curl -o wordpress.tar.gz -SL "https://wordpress.org/latest.tar.gz" && \
    tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm wordpress.tar.gz && \
    chown -R www-data:www-data /var/www/html

# Expose le port 9000 pour PHP-FPM
EXPOSE 9000

CMD ["php-fpm7.3", "-F"]

