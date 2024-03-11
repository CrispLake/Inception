#!/bin/sh

# Prepare directories and rights
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]
then
	echo "Database already exists"
else
# init database
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

# Enforce root pw, create db, add user, give rights
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;
CREATE USER \`$SQL_USER\`@'%' IDENTIFIED by '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO \`$SQL_USER\`@'%';
GRANT ALL PRIVILEGES ON *.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD' WITH GRANT OPTION;
GRANT SELECT ON mysql.* TO '$SQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

fi

exec mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.cnf
