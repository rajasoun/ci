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

sudo snap install kubectl --classic
###

sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 


curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
sudo mv /tmp/convox /usr/local/bin/convox
sudo chmod a+x /usr/local/bin/convox

mkdir -p ~/.kube
microk8s.config > ~/.kube/config
sudo snap restart microk8s

convox rack install local dev

### DNS Setup
sudo mkdir -p /usr/lib/systemd/resolved.conf.d
sudo bash -c "printf '[Resolve]\nDNS=$(kubectl get service/resolver-external -n dev-system -o jsonpath="{.spec.clusterIP}")\nDomains=~convox' > /usr/lib/systemd/resolved.conf.d/convox.conf"
systemctl daemon-reload
systemctl restart systemd-networkd systemd-resolved