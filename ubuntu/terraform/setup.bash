#!/usr/bin/env bash

## Install Terraform
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 


curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
sudo mv /tmp/convox /usr/local/bin/convox
sudo chmod a+x /usr/local/bin/convox


convox rack install local dev

### DNS Setup
sudo mkdir -p /usr/lib/systemd/resolved.conf.d
sudo bash -c "printf '[Resolve]\nDNS=$(kubectl get service/resolver-external -n dev-system -o jsonpath="{.spec.clusterIP}")\nDomains=~convox' > /usr/lib/systemd/resolved.conf.d/convox.conf"
systemctl daemon-reload
systemctl restart systemd-networkd systemd-resolved