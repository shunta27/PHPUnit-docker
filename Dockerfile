FROM php:7.0-alpine

MAINTAINER ichikawa shunta <shunta27ichikawa@gmail.com>

# Add GIT, CURL and required php7 extensions
RUN apk add --update git \
      curl

# Install composer, phpunit global bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sSL https://phar.phpunit.de/phpunit.phar -o phpunit.phar \
      && chmod +x phpunit.phar \
      && mv phpunit.phar /usr/local/bin/phpunit

# Clean build
RUN apk del curl \
    &&  rm -rf /var/cache/apk/*

# Tune PHP configs
COPY php.ini-production /usr/local/etc/php/conf.d/php.ini

WORKDIR /home/www-data
EXPOSE 80
CMD ["php","-S","0.0.0.0:80"]
