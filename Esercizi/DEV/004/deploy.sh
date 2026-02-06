#!/bin/bash

echo === CREAZIONE RETE DOCKER ===
docker network create net-web-etlforma

echo === REMOVE OLD BACKUP WORDPRESS UPLOADS ===
# rm -rf ./uploads/*
rm -rf ./uploads
# mkdir uploads

echo === BACKUP CARTELLA UPLOAD CONTAINER CORRENTE ===
docker cp wordpress:/var/www/html/wp-content/uploads ./uploads

echo === Preparazione files WORDPRESS ===
rm -rf ./wordpress
unzip -q wordpress.zip

echo === STOP CONTAINER ===
docker stop wordpress

echo === REMOVE CONTAINER ===
docker rm wordpress

echo === REMOVE IMAGE ===
docker image rm img-site-wordpress:1.0

echo === CREATE IMAGE ===
docker build --no-cache -t img-site-wordpress:1.0 .

echo === CREATE CONTAINER ===
docker run -d --net net-web-etlforma --name wordpress -h wordpress img-site-wordpress:1.0

docker exec -i wordpress chmod -R 777 /var/www/html/wp-content/uploads

echo == START LOGS ===
docker logs -f wordpress



