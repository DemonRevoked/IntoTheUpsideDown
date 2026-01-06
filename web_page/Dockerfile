FROM php:7.4-apache

# Install mysqli
RUN docker-php-ext-install mysqli

# Copy the application source code
COPY src/ /var/www/html/

EXPOSE 80
