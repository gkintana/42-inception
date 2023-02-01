CREATE DATABASE 42_wordpress_db;

CREATE USER 'test_user'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON 42_wordpress_db.* to 'test_user'@'localhost';

FLUSH PRIVILEGES;
