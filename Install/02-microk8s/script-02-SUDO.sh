#!/bin/bash

# DA LANCIARE A MANO uno ad uno
sudo usermod -a -G microk8s $USER
mkdir -p $HOME/.kube
sudo chmod 0700 $HOME/.kube
sudo chown -R $USER ~/.kube