#!/bin/bash

WP_PATH="/var/www/wordpress"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Function to check if MariaDB is running
check_mariadb() {
    nc -zv mariadb 3306 > /dev/null
    return $?
}

# Function to display loading bar
display_loading_bar() {
    local loading_bar=""
    local end_time=$1
    while [ $(date +%s) -lt $end_time ]; do
        if check_mariadb; then
            echo -e "\r${GREEN}MariaDB IS RUNNING${NC}\n"
            return 0
        else
            echo -ne "\rWaiting for MariaDB ${loading_bar}\n"
            loading_bar="${loading_bar}."
            sleep 1
        fi
    done
    echo -e "\n${RED}No response from MariaDB${NC}\n"
    return 1
}

# Main function to orchestrate the script
main() {
    local start_time=$(date +%s)
    local end_time=$((start_time + 20))

    # Check MariaDB
    if ! display_loading_bar $end_time; then
        return 1
    fi

    # Download and install WP-CLI
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Set permissions and ownership for WordPress directory
    cd /var/www/wordpress
    chmod -R 755 /var/www/wordpress/
    chown -R www-data:www-data /var/www/wordpress

    # Check if WordPress core files are installed
    if ! wp core is-installed --allow-root > /dev/null; then
        echo "Installing and setting up WordPress"
        
        find /var/www/wordpress/ -mindepth 1 -delete

        wp core download --allow-root
        wp core config --path="$WP_PATH" --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --allow-root
        wp core install --path="$WP_PATH" --url="$DOMAIN_NAME" --title="jdagoy's Website" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
        wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE" --allow-root

        # Verify permissions
        wp eval 'var_dump(is_writable(WP_CONTENT_DIR));' --allow-root

        # Fix permissions using WP-CLI
        wp eval 'chmod(WP_CONTENT_DIR, 0755);' --allow-root

        wp config set FS_METHOD direct --allow-root
        wp config set WP_DEBUG true --raw --allow-root
        wp config set WP_DEBUG_DISPLAY true --raw --allow-root
        wp config set WP_DEBUG_LOG true --raw --allow-root
        wp config set WP_MEMORY_LIMIT 256M --allow-root
        wp config set WP_CACHE true --raw --allow-root
        wp config set WP_REDIS_HOST redis --allow-root
        wp config set WP_REDIS_PORT 6379 --allow-root
        wp config set WP_REDIS_TIMEOUT 5 --allow-root
        wp config set WP_REDIS_READ_TIMEOUT 5 --allow-root
        wp config set WP_REDIS_DATABASE 0 --allow-root
        wp plugin install redis-cache --activate --allow-root
        wp plugin update --all --allow-root
        wp redis enable --allow-root
        # wp theme install inspiro --activate --path="$WP_PATH" --allow-root
        # chown -R www-data:www-data /var/www/wordpress
        # wp plugin install one-click-demo-import wpzoom-portfolio instagram-widget-by-wpzoom social-icons-widget-by-wpzoom --activate --allow-root
        # cd /var/www/wordpress/
        # wp ocdi import --predefined=0 --allow-root
        cd /
        ./create_post.sh
        # chown -R www-data:www-data /var/www/wordpress
    else
        echo "WordPress already set up; skipping installation\n"
    fi

    # Update PHP-FPM configuration and start PHP-FPM
    sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
    mkdir -p /run/php
    /usr/sbin/php-fpm7.4 -F
}

# Execute the main function
main
