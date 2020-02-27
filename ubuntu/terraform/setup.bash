#!/usr/bin/env bash

## Install Terraform
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 
