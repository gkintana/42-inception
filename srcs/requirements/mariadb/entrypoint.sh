#!/bin/bash

service mysql start

if [ -f /tmp/initialize_database.sql ]; then
mysql -e "$(eval "echo \"$(cat /tmp/initialize_database.sql)\"")"
rm /tmp/initialize_database.sql
fi

# tail -f /dev/null
# mysqld
exec $@
