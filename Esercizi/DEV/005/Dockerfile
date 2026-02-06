# Usa l'immagine ufficiale PHP con Apache
FROM php:8.2-apache

# Informazioni sul maintainer
LABEL maintainer="your-email@example.com"
LABEL description="Applicazione web PHP containerizzata"

# Installa estensioni PHP utili
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Abilita mod_rewrite di Apache (utile per URL rewriting)
RUN a2enmod rewrite

# Copia i file dell'applicazione nella directory di Apache
COPY . /var/www/html/

# Imposta i permessi corretti
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Esponi la porta 80
EXPOSE 80

# Apache viene avviato automaticamente dall'immagine base
# Il comando di default è già configurato per avviare Apache
