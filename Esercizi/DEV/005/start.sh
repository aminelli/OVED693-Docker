#!/bin/bash

# docker run -d --name dotnet-app -p 8080:8080 -e ASPNETCORE_ENVIRONMENT=Development dotnet-app-test:latest

docker run -d --name php-app -p 8080:80  php-app-test:latest