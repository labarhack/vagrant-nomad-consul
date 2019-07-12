# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "labarhack/nomad_consul_20190702.0"
NOMAD_SERVER_COUNT= ENV['NOMAD_SERVER_COUNT'] || 1
NOMAD_CLIENT_COUNT= ENV['NOMAD_CLIENT_COUNT'] || 1
$consul_addr = "192.168.50.50"

Vagrant.configure("2") do |config|

  config.vm.box = BOX_NAME

  # ---------------------------------------------------
  # Consul Server
  # ---------------------------------------------------
  config.vm.define "consul_server_1" do |consul_server_1|
    consul_server_1.vm.hostname = "consul-server-1"
    consul_server_1.vm.network "private_network", ip: $consul_addr
    consul_server_1.vm.network "forwarded_port", guest: 8500, host: 8500, guest_ip: $consul_addr
    consul_server_1.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/consul_server.yml"
        ansible.become = true
        ansible.compatibility_mode = "2.0"
        ansible.verbose = true
        ansible.extra_vars = {
          consul_addr: $consul_addr
        } 
    end
  end

  # ---------------------------------------------------
  # Nomad Server (Brain)
  # ---------------------------------------------------
  (1..NOMAD_SERVER_COUNT).each do |machine_id|
    config.vm.define "nomad_server_#{machine_id}" do |nomad_server|
      nomad_server.vm.hostname = "nomad-server-#{machine_id}"
      nomad_server.vm.network "private_network", ip: "192.168.50.6#{machine_id}"
      if machine_id == 1
        nomad_server.vm.network "forwarded_port", guest: 4646, host: "4646", guest_ip: "192.168.50.6#{machine_id}"
      end
      nomad_server.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/nomad_server.yml"
          ansible.become = true
          ansible.compatibility_mode = "2.0"
          ansible.verbose = true
          ansible.extra_vars = {
            nomad_addr: "192.168.50.6#{machine_id}",
            consul_addr: $consul_addr 
          } 
      end
    end
  end
  # ---------------------------------------------------
  # Nomad Client (Runner)
  # ---------------------------------------------------
  (1..NOMAD_CLIENT_COUNT).each do |machine_id|
    config.vm.define "nomad_client_#{machine_id}" do |nomad_client|
      nomad_client.vm.hostname = "nomad-client-#{machine_id}"
      nomad_client.vm.network "private_network", ip: "192.168.50.8#{machine_id}"

      nomad_client.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/nomad_client.yml"
          ansible.become = true
          ansible.compatibility_mode = "2.0"
          ansible.verbose = true
          ansible.extra_vars = {
            nomad_addr: "192.168.50.8#{machine_id}",
            consul_addr: $consul_addr 
          } 
      end
    end
  end
end
