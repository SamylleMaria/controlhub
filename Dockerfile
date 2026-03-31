FROM php:8.2-apache

# Extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Habilita mod_rewrite para o .htaccess funcionar
RUN a2enmod rewrite

# Define o document root para /public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf

RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

# Permissões para uploads
RUN mkdir -p /var/www/html/uploads && \
    chown -R www-data:www-data /var/www/html/uploads && \
    chmod -R 775 /var/www/html/uploads

WORKDIR /var/www/html

EXPOSE 80