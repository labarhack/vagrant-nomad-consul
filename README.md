# Vagrant Nomad cluster
[![Open Source Helpers](https://www.codetriage.com/labarhack/vagrant-nomad-consul/badges/users.svg)](https://www.codetriage.com/labarhack/vagrant-nomad-consul)

Start nomad cluster with single consul server (auto join).

## Prerequisites

* VirtualBox Version 6.0
* Vagrant 2.2.5
* Ansible 2.8.1

## Setup

```
export NOMAD_SERVER_COUNT=1
export NOMAD_CLIENT_COUNT=1
```
## Build vagrant box

See [README](packer/README.md) to build box with packer.
```
export BOX_NAME='labarhack/nomad_consul_20190702.0'
```

## Start vagrant

```
vagrant up
vagrant status
Current machine states:

consul_server_1           running (virtualbox)
nomad_server_1            running (virtualbox)
nomad_client_1            running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

## UI

* Consul: http://localhost:8500
* Nomad: http://localhost:4646

## Test

``` 
export NOMAD_ADDR=http://localhost:4646
export CONSUL_HTTP_ADDR=http://localhost:8500

nomad node status
ID        DC   Name            Class   Drain  Eligibility  Status
0022caa5  dc1  nomad-client-1  <none>  false  eligible     ready

nomad server members
Name                   Address        Port  Status  Leader  Protocol  Build  Datacenter  Region
nomad-server-1.global  192.168.50.61  4648  alive   true    2         0.9.3  dc1         global

consul members
Node             Address             Status  Type    Build  Protocol  DC   Segment
consul-server-1  192.168.50.50:8301  alive   server  1.5.2  2         dc1  <all>

nomad job run nomad/echo-server.nomad
==> Monitoring evaluation "803d2976"
    Evaluation triggered by job "echo-server"
    Allocation "1514d3b8" created: node "087dc8b3", group "sample"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "803d2976" finished with status "complete"

nomad job status
ID           Type     Priority  Status   Submit Date
echo-server  service  50        running  2019-07-08T15:25:43+02:00
```
