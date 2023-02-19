#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
	mv wp-config-sample.php wp-config.php

	sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.3/fpm/pool.d/www.conf

	sed -i "s/database_name_here/$WP_DBNAME/" /var/www/html/wp-config.php && \
	sed -i "s/username_here/$WP_DBUSER/" /var/www/html/wp-config.php && \
	sed -i "s/password_here/$WP_DBPASS/" /var/www/html/wp-config.php && \
	sed -i "s/localhost/$WP_DBHOST/" /var/www/html/wp-config.php

	echo "Installing WordPress"
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root

	echo "Adding Wordpress User"
	wp user create $WP_USER_NAME $WP_USER_EMAIL --user_pass=$WP_USER_PASS --allow-root

	echo "Setting Theme to $WP_THEME"
	wp theme install $WP_THEME --activate --allow-root

	# BONUS
	wp config set WP_CACHE true --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp config set WP_REDIS_HOST redis_cache --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root
	wp config set WP_REDIS_DATABASE 0 --allow-root

	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root
fi

if [ ! -d /run/php/ ]; then
	mkdir /run/php/
fi

chown -R www-data:www-data /var/www/html/ && \
chmod -R 755 /var/www/html/

exec $@
