FROM php:7.4-fpm

# timezone / date
RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
  && apt-get install -y \
    cron \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    default-mysql-client \
    libxslt1-dev \
    zip \
    unzip \
    git \
    libzip-dev \
    libjpeg62-turbo \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    vim \
    libxpm4

RUN docker-php-ext-configure gd --with-jpeg=/usr/local/ && \
    docker-php-ext-install -j$(nproc) zip bcmath soap pdo_mysql gd

RUN apt-get install -y git

# composer stuff
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
  && php composer-setup.php --1 --install-dir=/usr/local/bin --filename=composer \
  && rm -f composer-setup.php \
  && chown www-data:www-data /var/www

# Xdebug
RUN pecl install xdebug-2.9.6
COPY ./oxid/files/xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini

# fpm stuff
ENV PHP_MEMORY_LIMIT 2G
ENV PHP_TIMEZONE "Europe/Berlin"
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 4
ENV PHP_PM_MIN_SPARE_SERVERS 2
ENV PHP_PM_MAX_SPARE_SERVERS 6
ENV APP_MAGE_MODE default

COPY conf/www.conf /usr/local/etc/php-fpm.d/
COPY conf/php.ini /usr/local/etc/php/
COPY conf/php-fpm.conf /usr/local/etc/

#COPY bin/* /usr/local/bin/
RUN mkdir -p /root/.ssh
COPY conf/id_rsa /root/.ssh/
COPY conf/known_hosts /root/.ssh/

# composer stuff
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
  && php composer-setup.php --1 --install-dir=/usr/local/bin --filename=composer \
  && rm -f composer-setup.php \
  && chown www-data:www-data /var/www

# prepare entrypoint.d pattern
RUN mkdir /entrypoint.d
COPY ./files/entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d/* /entrypoint.d/
RUN chmod 777 /entrypoint.sh && chmod 777 /entrypoint.d/*

# oxid stuff
COPY ./files/config.inc.php /var/www/config.inc.php

ENTRYPOINT ["/entrypoint.sh"]
