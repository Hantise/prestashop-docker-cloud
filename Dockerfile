FROM php:5.6-apache

RUN apt-get update \
	&& apt-get install -y libmcrypt-dev \
		libjpeg62-turbo-dev \
		libpcre3-dev \
		libpng12-dev \
		libfreetype6-dev \
		libxml2-dev \
		libicu-dev \
		mysql-client \
		wget \
		unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install iconv intl mcrypt pdo pdo_mysql mbstring soap gd zip

RUN docker-php-source extract \
	&& if [ -d "/usr/src/php/ext/mysql" ]; then docker-php-ext-install mysql; fi \
	&& if [ -d "/usr/src/php/ext/opcache" ]; then docker-php-ext-install opcache; fi \
	&& docker-php-source delete

RUN apt-get update \
	&& apt-get install -y git

RUN apt-get update \
	&& apt-get install -y vim

RUN apt-get update \
	&& apt-get install -y zip

ENV PS_VERSION 1.7.1.2

# Get PrestaShop

ADD /web/ /var/www/html/
RUN chown www-data:www-data -R /var/www/html/

# Apache configuration
RUN a2enmod rewrite
RUN chown www-data:www-data -R /var/www/html/

# PHP configuration
COPY config_files/php.ini /usr/local/etc/php/

COPY config_files/docker_run.sh /tmp/
RUN service apache2 restart
CMD ["/tmp/docker_run.sh"]
