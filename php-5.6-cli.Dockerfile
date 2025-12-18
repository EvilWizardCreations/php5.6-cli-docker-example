FROM php:5.6-cli-alpine as build-php-56-cli

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6" \
    evilwizardcreations.image.name="Legacy PHP 5.6 CLI"

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# copy the 5.6 specific php.ini override configuration
COPY ./build-assets/php/56.local.ini /usr/local/etc/php.ini

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# Install some extra stuff
RUN set -ex; \
    apk update; \
    apk add libxslt \ 
      libxslt-dev \
      libxml2-dev \
      libzip-dev \
      yaml \
      yaml-dev \
      zip \
      unzip \
      git \
      gettext \
      gettext-dev \
      mariadb-dev \
      vim \
      pcre-dev ${PHPIZE_DEPS} \
      autoconf

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip xml xsl
RUN pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml && \
    apk del pcre-dev ${PHPIZE_DEPS} && \
    rm /tmp/yaml-1.3.0.tgz

# A test build to play with while getting it all working
FROM php:5.6-cli-alpine as build-php-56-cli-test

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6" \
    evilwizardcreations.image.name="Legacy PHP 5.6 CLI"

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# copy the 5.6 specific php.ini override configuration
COPY ./build-assets/php/56.local.ini /usr/local/etc/php.ini

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# Install some extra stuff
RUN set -ex; \
    apk update; \
    apk add libxslt \ 
      libxslt-dev \
      libxml2-dev \
      libzip-dev \
      yaml \
      yaml-dev \
      zip \
      unzip \
      git \
      gettext \
      gettext-dev \
      mariadb-dev \
      vim \
      pcre-dev ${PHPIZE_DEPS} \
      autoconf

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip xml xsl
RUN pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml && \
    apk del pcre-dev ${PHPIZE_DEPS} && \
    rm /tmp/yaml-1.3.0.tgz
