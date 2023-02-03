CREATE DATABASE test_db;

CREATE USER 'test_user'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON test_db.* to 'test_user'@'localhost';

FLUSH PRIVILEGES;
