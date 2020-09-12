MASTER_COUNT = 3
NODE_COUNT = 3
IMAGE = "ubuntu/bionic64"

Vagrant.configure("2") do |config|

  (1..MASTER_COUNT).each do |i|
    config.vm.define "kubemaster#{i}" do |kubemasters|
      kubemasters.vm.box = IMAGE
      kubemasters.vm.hostname = "kubemaster#{i}"
      kubemasters.vm.network  :private_network, ip: "10.0.0.#{i+10}"
      kubemasters.vm.provision "file", source: "./.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
      kubemasters.vm.provision "file", source: "./.ssh/id_rsa", destination: "/tmp/id_rsa"
      kubemasters.vm.provision "shell", privileged: true,  path: "scripts/master_install.sh"
    end
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "kubenode#{i}" do |kubenodes|
      kubenodes.vm.box = IMAGE
      kubenodes.vm.hostname = "kubenode#{i}"
      kubenodes.vm.network  :private_network, ip: "10.0.0.#{i+20}"
      kubenodes.vm.provision "file", source: "./.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
      kubenodes.vm.provision "file", source: "./.ssh/id_rsa", destination: "/tmp/id_rsa"
      kubenodes.vm.provision "shell", privileged: true,  path: "scripts/node_install.sh"
    end
  end

  config.vm.define "front_lb" do |traefik|
      traefik.vm.box = IMAGE
      traefik.vm.hostname = "traefik"
      traefik.vm.network  :private_network, ip: "10.0.0.30"   
      traefik.vm.provision "file", source: "./scripts/traefik/dynamic_conf.toml", destination: "/tmp/traefikconf/dynamic_conf.toml"
      traefik.vm.provision "file", source: "./scripts/traefik/static_conf.toml", destination: "/tmp/traefikconf/static_conf.toml"
      traefik.vm.provision "shell", privileged: true,  path: "scripts/lb_install.sh"
      traefik.vm.network "forwarded_port", guest: 6443, host: 6443
  end
end