#!/bin/bash

sleep 10
if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "wordpress already configured"
else
	echo "configuring wordpress"
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb --path='/var/www/wordpress'
	wp core install	--allow-root \
						--title=$WORDPRESS_TITLE \
						--admin_user=$WORDPRESS_ADMIN \
						--admin_password=$WORDPRESS_ADMIN_PASSWORD \
						--admin_email=$WORDPRESS_ADMIN_EMAIL \
						--path='/var/www/wordpress'
	wp user create	--allow-root \
						$WORDPRESS_USER \
						$WORDPRESS_EMAIL \
						--role=author \
						--user_pass=$WORDPRESS_USER_PASSWORD \
						--path='/var/www/wordpress'
fi
