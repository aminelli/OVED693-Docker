#!/bin/bash
# https://hub.docker.com/_/mysql


docker network create net-corso
docker volume create vol-mysql-data
docker run -d --name mysql-first --hostname mysql-first --network net-corso -p 3306:3306 -v vol-mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=CorsiDocker2026 mysql


# docker run 
#     -d 
#     --name mysql-first 
#     --hostname mysql-first 
#     --network net-corso 
#     -p 3406:3306
#     -v vol-mysql-data:/var/lib/mysql
#     -e MYSQL_ROOT_PASSWORD=CorsiDocker2026 
#     mysql
