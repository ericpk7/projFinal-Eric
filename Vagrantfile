Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.define "server" do |server|
    server.vm.network "private_network", type: "dhcp"

    server.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y docker.io
      usermod -aG docker vagrant
    SHELL

    server.vm.provision "file", source: "./docker_setup_script.sh", destination: "/home/vagrant/docker_setup_script.sh"
    server.vm.provision "shell", inline: "chmod +x /home/vagrant/docker_setup_script.sh"
    server.vm.provision "shell", inline: "/home/vagrant/docker_setup_script.sh"
  end

  config.vm.define "client" do |client|
    client.vm.network "private_network", type: "dhcp"

    client.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y dnsutils nfs-common
    SHELL
  end
end
