# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "labarhack/nomad_consul_20190702.0"
SERVER_COUNT= ENV['SERVER_COUNT'] || 1
CLIENT_COUNT= ENV['CLIENT_COUNT'] || 1

Vagrant.configure("2") do |config|

  config.vm.box = BOX_NAME

  # ---------------------------------------------------
  # Server (Brain)
  # ---------------------------------------------------
  (1..SERVER_COUNT).each do |machine_id|
    config.vm.define "server_#{machine_id}" do |server|
      server.vm.hostname = "server-#{machine_id}"
      server.vm.network "private_network", ip: "192.168.50.6#{machine_id}"
      bootstrap = false
      if machine_id == 1
        server.vm.network "forwarded_port", guest: 4646, host: "4646", guest_ip: "192.168.50.6#{machine_id}"
        server.vm.network "forwarded_port", guest: 8500, host: 8500, guest_ip: "192.168.50.6#{machine_id}"
        bootstrap = true
      end
      server.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/server.yml"
          ansible.become = true
          ansible.compatibility_mode = "2.0"
          ansible.verbose = true
          ansible.extra_vars = {
            server_addr: "192.168.50.6#{machine_id}",
            bootstrap: bootstrap,
            server_count: SERVER_COUNT 
          } 
      end
    end
  end
  # ---------------------------------------------------
  # Client (Runner)
  # ---------------------------------------------------
  (1..CLIENT_COUNT).each do |machine_id|
    config.vm.define "client_#{machine_id}" do |client|
      client.vm.hostname = "client-#{machine_id}"
      client.vm.network "private_network", ip: "192.168.50.8#{machine_id}"

      client.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/client.yml"
          ansible.become = true
          ansible.compatibility_mode = "2.0"
          ansible.verbose = true
          ansible.extra_vars = {
            server_addr: "192.168.50.8#{machine_id}",
            server_count: SERVER_COUNT
          } 
      end
    end
  end
end
