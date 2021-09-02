#!/bin/bash


# Get kubectl depending on OS type
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /tmp/kubectlvagrant;;
    Darwin*)    curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl -o /tmp/kubectlvagrant;;
esac

chmod +x /tmp/kubectlvagrant

vagrant ssh kubemaster1 -c "sudo cat /etc/rancher/k3s/k3s.yaml" > /tmp/kubectlvagrantconfig.yml

# Create temp vars to use kubectl with vagrant
export KUBECONFIG=/tmp/kubectlvagrantconfig.yml
alias kubectl="/tmp/kubectlvagrant"
