FROM php:8.2-fpm
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

# Install required packages, including SQLite
RUN apt-get update && apt-get -y install git unzip curl supervisor libicu-dev libonig-dev libzip-dev \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev libcurl4-openssl-dev sqlite3 libsqlite3-dev \
    --assume-yes --no-install-recommends --quiet build-essential libmagickwand-dev

# Clean up after installation
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update -o Acquire::CompressionTypes::Order::=gz

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_sqlite mysqli mbstring intl zip bcmath curl ctype
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd

# Install Imagick extension
RUN pecl install imagick && docker-php-ext-enable imagick

# Set Composer environment variables and install Composer
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer
RUN composer config -g process-timeout 3600 && composer config -g repos.packagist composer https://packagist.org

# Copy PHP config files
ARG DOCKER_SERVICES_PATH
COPY ${DOCKER_SERVICES_PATH}/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ${DOCKER_SERVICES_PATH}/php/php.ini /usr/local/etc/php/php.ini

# Set the working directory
WORKDIR /var/www
