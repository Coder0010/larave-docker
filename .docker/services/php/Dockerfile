FROM php:8.1-fpm-bullseye
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# environment variable
ENV TZ=UTC \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer

# install composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# clean after installation
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update -o Acquire::CompressionTypes::Order::=gz

# install needed packages for php
RUN apt-get update && apt-get -y install git unzip locales libicu-dev libonig-dev libzip-dev

# clean after installation
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update -o Acquire::CompressionTypes::Order::=gz

# set lang and locale
RUN locale-gen en_US.UTF-8 && \
    localedef -f UTF-8 -i en_US en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN mkdir /var/run/php-fpm

# install needed extensions at php
RUN docker-php-ext-install pdo pdo_mysql mysqli mbstring intl zip bcmath

RUN composer config -g process-timeout 3600 && composer config -g repos.packagist composer https://packagist.org

ARG DOCKER_SERVICES_PATH
COPY ${DOCKER_SERVICES_PATH}/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ${DOCKER_SERVICES_PATH}/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www
