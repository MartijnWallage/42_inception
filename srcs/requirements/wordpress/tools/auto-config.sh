#!/bin/bash
trap "exit" TERM

sleep 20

WP_PATH="/var/www/wordpress"

cd var/

wp config create --allow-root \
                --dbname=$MYSQL_DATABASE --dbuser=$(<"/run/secrets/db_user") \
                --dbpass=$(<"/run/secrets/db_password") --dbhost=$MYSQL_HOSTNAME:3306 \
                --path=$WP_PATH

echo "wp core install......."
wp core install --allow-root \
            --url=$DOMAIN_NAME \
            --title='inception' \
            --admin_user=$(<"/run/secrets/wp_admin_user") \
            --admin_password=$(<"/run/secrets/wp_admin_password") \
            --admin_email='whocares@gmail.com' \
            --skip-email \
            --path=$WP_PATH

echo "wp user create........"
wp user create --allow-root \
            $(<"/run/secrets/wp_user") whocares@gmail.com --user_pass=$(<"/run/secrets/wp_user_password") \
            --path=$WP_PATH


####### BONUS PART ################

## redis ##

wp config set WP_CACHE true --allow-root --path=$WP_PATH
wp config set WP_REDIS_HOST 'redis' --allow-root --path=$WP_PATH
wp config set WP_REDIS_PORT 6379 --allow-root --path=$WP_PATH
# wp config set WP_REDIS_PASSWORD 'your_redis_password' --path=$WP_PATH # Only if Redis is password protected
# wp config set WP_REDIS_CLIENT phpredis --allow-root --path=$WP_PATH
wp plugin install redis-cache --activate --allow-root --path=$WP_PATH
wp plugin update --all --allow-root --path=$WP_PATH
wp redis enable --allow-root --path=$WP_PATH

###################################


directory="/run/php"

if [ ! -d "$directory" ]; then
    mkdir -p $directory
    echo "Directory $directory created successfully."
else
    echo "Directory $directory already exists."
fi

echo "launch php..."

/usr/sbin/php-fpm7.4 -F

