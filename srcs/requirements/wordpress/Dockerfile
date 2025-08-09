FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install -y wget \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-curl \
    php7.4-zip \
    php7.4-gd

RUN mkdir -p /var/www/wordpress && \
    wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /tmp && \
    mv /tmp/wordpress/* /var/www/wordpress/ && \
    rm -rf /tmp/wordpress* && \
    chown -R www-data:www-data /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp --info --allow-root

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY tools/auto_config.sh tools/auto_config.sh
RUN chmod +x tools/auto_config.sh

ENTRYPOINT ["/tools/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
