#!/bin/bash
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
chmod +x kustomize
sudo mv kustomize /usr/local/bin/