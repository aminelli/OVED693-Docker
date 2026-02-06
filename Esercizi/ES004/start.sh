#!/bin/bash
# https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-ver16&preserve-view=true&tabs=cli&pivots=cs1-bash#pullandrun2022


docker network create net-corso
docker volume create vol-sqlserver-data

docker pull mcr.microsoft.com/mssql/server:2022-latest

docker run -d --name sqlsrv --hostname sqlsrv --network net-corso -p 1433:1433 -v vol-sqlserver-data:/var/opt/mssql -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=CorsiDocker2026" mcr.microsoft.com/mssql/server:2022-latest


# docker run 
#     -d 
#     --name sqlsrv
#     --hostname sqlsrv 
#     --network net-corso 
#     -p 1433:1433 
#     -v vol-sqlserver-data:/var/opt/mssql 
#     -e "ACCEPT_EULA=Y"
#     -e "MSSQL_SA_PASSWORD=CorsiDocker2026"
#     mcr.microsoft.com/mssql/server:2022-latest



