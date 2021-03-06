FROM php:7.4.1-apache

ARG APPUID
ARG APPUGID

# core Debian packages which includes of create PHP environment
RUN apt-get update;                 \
    apt-get install                 \
            -y                      \
            --no-install-recommends \
        autoconf                    \
        git                         \
        libfreetype6-dev            \
        libgd-dev                   \
        libicu-dev                  \
        libjpeg62-turbo-dev         \
        libzip-dev                  \
        locales                     \
        unzip                       \
        wget                        \
        zlib1g-dev                  \
    ;                               \
    rm -rf /var/lib/apt/lists/*;    \
    rm -rf /var/cache/apt;          \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

## core PHP extensions
RUN docker-php-ext-enable opcache;               \
    docker-php-ext-install                       \
        bcmath                                   \
        intl                                     \
        pdo_mysql                                \
        zip                                      \
    ;                                            \
    docker-php-ext-install -j$(nproc) gd;        \
    docker-php-ext-configure gd                  \
                --with-external-gd               \
                --with-freetype                  \
                --with-webp                      \
                --with-xpm                       \
    ;                                            \
    docker-php-ext-configure intl --enable-intl; \
    pecl install apcu;                           \
    docker-php-ext-enable apcu

# xdebug
# we do not enable by default the extension because this is done in php-ini-overrides.ini when needed
RUN pecl install xdebug-2.9.0

RUN if getent passwd www-data; then         \
        userdel -f www-data;                \
        if getent group www-data ; then     \
            groupdel www-data;              \
        fi;                                 \
        groupadd -g ${APPUGID} www-data;    \
        useradd -r -l -u ${APPUID} -g www-data www-data; \
    fi;                                     \
    rm -rf /home/www-data


# composer
ENV COMPOSER_HOME /var/www/composer

RUN curl -sS https://getcomposer.org/installer |                \
       php -- --install-dir=/usr/local/bin --filename=composer  \
    && composer global require hirak/prestissimo                \
    && composer global require maglnet/composer-require-checker \
    && chown -R www-data:www-data $COMPOSER_HOME

# setup apache
ENV APACHE_DOCUMENT_ROOT /app/public
RUN a2enmod rewrite     \
    && a2enmod headers  \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /app

