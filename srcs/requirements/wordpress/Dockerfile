FROM debian:buster

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install -y wget \
    php7.3 \
    php-fpm \
    php-mysql \
    mariadb-client \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-curl \
    php7.3-zip \
    php7.3-gd

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.0-fr_FR.tar.gz && \
    rm wordpress-6.0-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp --info --allow-root

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY tools/auto_config.sh tools/auto_config.sh
RUN chmod +x tools/auto_config.sh

ENTRYPOINT ["/tools/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.3", "-F"]
