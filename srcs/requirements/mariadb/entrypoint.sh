#!/bin/bash

service mysql start

mysql -e "$(eval "echo \"$(cat /tmp/initialize_database.sql)\"")"
rm /tmp/initialize_database.sql

tail -f /dev/null
# mysqld
