#!/bin/bash

# Start the MariaDB service
service mysql start

# Wait until the database is up and running
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Create the database and user if they do not exist
mysql -e "CREATE DATABASE IF NOT EXISTS test_db;"
mysql -e "CREATE USER IF NOT EXISTS 'test_user'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON test_db.* TO 'test_user'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Keep the MariaDB service running
# tail -f /dev/null
mysqld
