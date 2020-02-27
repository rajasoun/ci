#!/usr/bin/env bash

## Install convox
curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
sudo mv /tmp/convox /usr/local/bin/convox
sudo chmod a+x /usr/local/bin/convox

convox rack install local dev

### DNS Setup
sudo mkdir -p /usr/lib/systemd/resolved.conf.d
sudo bash -c "printf '[Resolve]\nDNS=$(kubectl get service/resolver-external -n dev-system -o jsonpath="{.spec.clusterIP}")\nDomains=~convox' > /usr/lib/systemd/resolved.conf.d/convox.conf"
systemctl daemon-reload
systemctl restart systemd-networkd systemd-resolved