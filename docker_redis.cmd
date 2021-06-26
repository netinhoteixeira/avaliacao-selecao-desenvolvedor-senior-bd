@echo off
SET DOCKER_IMAGE=redis:6.2.4
set DOCKER_INSTANCE=avaliacao-redis

mkdir c:\Users\%USERNAME%\docker\%DOCKER_INSTANCE%\data

docker run --name %DOCKER_INSTANCE% -p 6379:6379 --mount type=bind,src=/c/Users/%USERNAME%/docker/%DOCKER_INSTANCE%/data,dst=/data -d %DOCKER_IMAGE% --appendonly yes

pause
