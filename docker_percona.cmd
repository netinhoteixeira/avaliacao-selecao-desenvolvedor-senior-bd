@echo off
SET DOCKER_IMAGE=percona:8.0.23-14
SET DOCKER_CONTAINER=avaliacao-mysql
SET DATABASE=avaliacao
SET CURRENT_DIR=%CD%

mkdir c:\Users\%USERNAME%\docker\%DOCKER_CONTAINER%\data
mkdir c:\Users\%USERNAME%\docker\%DOCKER_CONTAINER%\log
mkdir c:\Users\%USERNAME%\docker\%DOCKER_CONTAINER%\init.db

copy /y %CD%\init.db\*.sql c:\Users\%USERNAME%\docker\%DOCKER_CONTAINER%\init.db

docker run --name %DOCKER_CONTAINER% -p 3306:3306 --mount type=bind,src=/c/Users/%USERNAME%/docker/%DOCKER_CONTAINER%/data,dst=/var/lib/mysql --mount type=bind,src=/c/Users/%USERNAME%/docker/%DOCKER_CONTAINER%/log,dst=/var/log/mysql --mount type=bind,src=/c/Users/%USERNAME%/docker/%DOCKER_CONTAINER%/init.db,dst=/docker-entrypoint-initdb.d -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=%DATABASE% -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -d %DOCKER_IMAGE% --socket=/tmp/mysql.sock --innodb_use_native_aio=0 --log-bin --binlog-format=MIXED --max-connect-errors=1000 --max_connections=155 --bind-address=0.0.0.0 --default-authentication-plugin=mysql_native_password

pause
