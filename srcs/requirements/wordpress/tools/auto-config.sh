#!/bin/bash

sleep 20

cd var/

wp config create --allow-root \
                --dbname=$MYSQL_DATABASE --dbuser=$(<"/run/secrets/db_user") \
                --dbpass=$(<"/run/secrets/db_password") --dbhost=mariadb:3306 \
                --path='/var/www/wordpress'

echo "wp core install......."
wp core install --allow-root \
            --url=$DOMAIN_NAME \
            --title='inception' \
            --admin_user=$(<"/run/secrets/wp_admin_user") \
            --admin_password=$(<"/run/secrets/wp_admin_password") \
            --admin_email='gadmin.g@gmail.com' \
            --skip-email \
            --path='/var/www/wordpress'

echo "wp user create........"
wp user create --allow-root \
            $(<"/run/secrets/wp_user") guser2.g@gmail.com --user_pass=$(<"/run/secrets/wp_user_password") \
            --path='/var/www/wordpress'

directory="/run/php"

if [ ! -d "$directory" ]; then
    mkdir -p $directory
    echo "Directory $directory created successfully."
else
    echo "Directory $directory already exists."
fi

echo "launch php..."

/usr/sbin/php-fpm7.4 -F
