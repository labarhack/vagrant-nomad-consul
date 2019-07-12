# Build Nomad/Consul Box

## Prerequisites

* VirtualBox Version 6.0
* Vagrant 2.2.5
* Packer 1.4.1
* Ansible 2.8.1

## Quick start

```
export NOMAD_VERSION=0.9.3
export CONSUL_VERSION=1.5.2
export BOX_VERSION=`date +%Y%m%d.0`
export BOX_NAME="labarhack/nomad_consul_${BOX_VERSION}"
packer build -var-file=bionic64.json ubuntu.json
vagrant box add output-vagrant/package.box --name $BOX_NAME
```
