FROM php:5.6-cli-alpine as build-56-cli

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6"

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# Install some extra stuff
RUN set -ex; \
    apk update; \
    apk add libxml2-dev \
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
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl channel-update pecl.php.net && \
    pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml && \
    apk del pcre-dev ${PHPIZE_DEPS} && \
    rm /tmp/yaml-1.3.0.tgz

# A test build to play with while getting it all working
FROM php:5.6-cli-alpine as build-56-cli-test

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6"

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# Install some extra stuff
RUN set -ex; \
    apk update; \
    apk add libxml2-dev \
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
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl channel-update pecl.php.net && \
    pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml && \
    apk del pcre-dev ${PHPIZE_DEPS} && \
    rm /tmp/yaml-1.3.0.tgz
