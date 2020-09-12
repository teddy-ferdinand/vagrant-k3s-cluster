#!/bin/bash
# Download and deploy Traefik as a front load balancer
curl https://github.com/containous/traefik/releases/download/v2.2.11/traefik_v2.2.11_linux_amd64.tar.gz -o /tmp/traefik.tar.gz -L
cd /tmp/
tar xvfz ./traefik.tar.gz
nohup ./traefik --configFile=/tmp/traefikconf/static_conf.toml &> /dev/null&
