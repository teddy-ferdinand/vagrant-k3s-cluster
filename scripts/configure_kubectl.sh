#!/bin/bash

# Get kubectl
curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /tmp/kubectlvagrant
chmod +x /tmp/kubectlvagrant

# Get password from master config file
PASSWORD=$(vagrant ssh kubemaster1 -c "sudo grep password /etc/rancher/k3s/k3s.yaml" | awk -F':' '{print $2}' | sed 's/ //g')

#Create kubectl config
cat << EOF > /tmp/kubectlvagrantconfig.yml
apiVersion: v1
clusters:
- cluster:
    server: https://10.0.0.30:6443
    insecure-skip-tls-verify: true
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    password: ${PASSWORD}
    username: admin
EOF

# Create temp vars to use kubectl with vagrant
export KUBECONFIG=/tmp/kubectlvagrantconfig.yml
alias kubectl="/tmp/kubectlvagrant"