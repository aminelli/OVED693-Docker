FROM wordpress:6.7.1-php8.2-apache

RUN apt-get update && apt-get install -y nano git unzip htop

RUN a2enmod ssl


COPY ./wordpress /var/www/html/

# UPLOADS MERGE DEV + PROD
COPY ./uploads ./wp-content/uploads

 
# RUN rm -rf /var/www/html/*
# COPY ./wordpress.zip /var/www/wordpress.zip
# RUN unzip /var/www/wordpress.zip
# RUN mv /var/www/wordpress/* /var/www/html/
# RUN rm /var/www/html/wordpress.zip

COPY ./keystore /keystore

COPY ./conf/wp-config.php /var/www/html/wp-config.php

COPY ./conf/.htaccess /var/www/html/.htaccess

COPY ./conf/000-default.conf  /etc/apache2/sites-enabled/000-default.conf

RUN chown -R www-data:www-data /var/www/html/wp-content; 
RUN chmod -R 1777 /var/www/html/wp-content
RUN chmod -R 777 /var/www/html/wp-content/uploads

EXPOSE 80 443


