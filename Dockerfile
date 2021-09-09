FROM php:7.4-fpm

ENV PHP_EXTENSIONS \
    pdo_mysql

ENV PECL_EXTENSIONS \
    xdebug 

RUN apt-get update && \
    apt-get install -y && \
    apt-get install zip -y && \
    apt-get install apt-transport-https -y && \
    apt-get install git -y

RUN docker-php-ext-install ${PHP_EXTENSIONS} && \
    pecl install ${PECL_EXTENSIONS} && \
    docker-php-ext-enable ${PECL_EXTENSIONS}

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /opt/app

COPY composer.json composer.lock .

RUN composer install

COPY . /opt/app/

RUN chown -R www-data:www-data var