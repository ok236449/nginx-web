FROM php:8.3.36-fpm-alpine

# 1. Install runtime dependencies and build toolchain in a single layer
RUN apk add --no-cache \
    nginx bash curl less vim git tzdata mysql-client sqlite sqlite-libs \
    freetype libjpeg-turbo libpng libzip libintl icu libpq libxml2 \
    && apk add --no-cache --virtual .build-deps \
    freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev icu-dev postgresql-dev libxml2-dev sqlite-dev linux-headers \
    autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c \
    \
    # Configure and install core PHP extensions
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        pdo_sqlite \
        mysqli \
        zip \
        bcmath \
        gd \
        intl \
        opcache \
        soap \
        sockets \
        pdo_pgsql \
        pgsql \
    \
    # Install APCu extension via PECL
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    \
    # Strip out heavy build dependencies to minimize image size
    && apk del .build-deps

# 2. Install Composer from the official upstream image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 3. Set up non-root runtime user and working directory
USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container

# 4. Copy entrypoint script with correct ownership and execution permissions
COPY --chown=container:container --chmod=755 ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
