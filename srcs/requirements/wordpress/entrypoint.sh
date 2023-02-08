#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
	wp core download --allow-root --path=/var/www/html/
	mv wp-config-sample.php wp-config.php

	sed -i 's/database_name_here/wordpress_service/' /var/www/html/wp-config.php && \
	sed -i 's/username_here/sql_user/' /var/www/html/wp-config.php && \
	sed -i 's/password_here/123password123/' /var/www/html/wp-config.php && \
	sed -i 's/localhost/mariadb/' /var/www/html/wp-config.php && \
	sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.3/fpm/pool.d/www.conf

	echo "Installing WordPress"
	wp core install --allow-root --url=test.com --title="TEST" --admin_user=wpcli --admin_password=wpcli --admin_email=info@wp-cli.org
fi

if [ ! -d /run/php/ ]; then
	mkdir /run/php/
fi

exec $@
