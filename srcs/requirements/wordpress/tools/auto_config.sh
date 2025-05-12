#!/bin/bash

# Sleep to wait for the database to be ready
sleep 10

echo "Configuring WordPress..."
# Set up WordPress configuration (only if it doesn't exist)
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost=mariadb \
        --path='/var/www/wordpress' || { echo "wp config create failed"; exit 1; }
else
    echo "wp-config.php already exists, skipping config creation"
fi

# Install WordPress core (only if not installed)
if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --path='/var/www/wordpress' || { echo "wp core install failed"; exit 1; }
else
    echo "WordPress already installed, skipping core install"
fi

# Create WordPress user (only if user doesn't exist)
if wp user list --allow-root --path='/var/www/wordpress' --field=user_login | grep -q "^$WORDPRESS_USER$"; then
    echo "User '$WORDPRESS_USER' already exists, skipping user creation"
else wp user create --allow-root \
        "$WORDPRESS_USER" \
        "$WORDPRESS_EMAIL" \
        --role=author \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --path='/var/www/wordpress' || { echo "wp user create failed"; exit 1; }
fi

# Start PHP-FPM (keep container running)
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.3 -F

