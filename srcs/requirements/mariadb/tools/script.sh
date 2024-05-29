#!/bin/bash

echo "start mariadb"
service mariadb start;
sleep 2

echo "create database"
mariadb -u root -p$(<"/run/secrets/db_root_password")  -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
sleep 2

echo "create user"
mariadb -u root -p$(<"/run/secrets/db_root_password")  -e "CREATE USER IF NOT EXISTS \`$(<"/run/secrets/db_user")\`@'localhost' IDENTIFIED BY '$(<"/run/secrets/db_password")';"

echo "grant privileges"
mariadb -u root -p$(<"/run/secrets/db_root_password")  -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`$(<"/run/secrets/db_user")\`@'%' IDENTIFIED BY '$(<"/run/secrets/db_password")';"

echo "add password for root"
mariadb -u root -p$(<"/run/secrets/db_root_password")  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(<"/run/secrets/db_root_password")';"
sleep 1

echo "reset privileges"
mariadb -u root -p$(<"/run/secrets/db_root_password") -e "FLUSH PRIVILEGES;"
sleep 1

echo "restart mysql"
mysqladmin -u root -p$(<"/run/secrets/db_root_password") shutdown
sleep 2

echo "exec mariadb"
exec mariadbd-safe