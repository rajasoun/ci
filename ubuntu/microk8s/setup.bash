#!/usr/bin/env bash

## Install Kubernetes
sudo snap install microk8s --classic
sudo iptables -P FORWARD ACCEPT

# Add your user to the Kubernetes(microk8s) group.
sudo usermod -a -G microk8s $USER
sudo snap restart microk8s

# Exit & Log back In for the user group addition to take effect

## enable and use the dns and dashboard addons. We can view the Grafana dashboard for our deployment.
microk8s.enable dns dashboard storage


##If RBAC is not enabled access the dashboard using the default token retrieved with:

token=$(microk8s.kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s.kubectl -n kube-system describe secret $token

## In an RBAC enabled setup (microk8s.enable RBAC) you need to create a user with restricted
## permissions as shown in:
## https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


microk8s.kubectl cluster-info
microk8s.config

## Install kubectl
sudo snap install kubectl --classic
mkdir -p ~/.kube
microk8s.config > ~/.kube/config
sudo snap restart microk8s
