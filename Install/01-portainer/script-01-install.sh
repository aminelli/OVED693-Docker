#!/bin/bash

# https://docs.portainer.io/start/install-ce/server/docker/linux

docker volume create portainer_data
docker run -d -p 8900:8000 -p 9943:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts

# DASHBOARD: https://[IP or DNS or HOSTNAME]:9943)
# Esempio:
# https://132.164.250.156:9943


 