#!/bin/bash

# Enable Addons
microk8s enable community
microk8s enable dashboard
microk8s enable dns 
microk8s enable rbac
microk8s enable ingress
microk8s enable hostpath-storage
microk8s enable registry
microk8s enable metallb
microk8s enable cert-manager
microk8s enable istio