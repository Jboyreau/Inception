# Utilise Debian Buster comme base
FROM debian:buster

# Installe NGINX
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure NGINX pour utiliser TLSv1.2 ou TLSv1.3 uniquement
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=NY/L=New York/O=Example Company/CN=example.com"

# Supprime la configuration par défaut et ajoute la vôtre
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Expose le port 443 pour HTTPS
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
