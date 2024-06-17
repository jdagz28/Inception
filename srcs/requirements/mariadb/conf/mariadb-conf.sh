#!/bin/bash

chsh -s $(which zsh)
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
echo "alias zshi='sh /install.sh'" >> ~/.zshrc


# Start MariaDB service
service mariadb start

# Create database if it does not exist
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"

# Create user if it does not exist
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

# Restart MariaDB with the new configuration
mysqladmin -u root -p"$MYSQL_PASSWORD" shutdown 

# Start MariaDB in a safe mode with specific configurations
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql' 

