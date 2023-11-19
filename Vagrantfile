Vagrant.configure("2") do |config|
  config.vm.define "vm1" do |vm1|
    vm1.vm.hostname = "vm1"
    vm1.vm.box = "ubuntu/focal64"
    vm1.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    vm1.vm.network "private_network", ip: "192.168.0.10"
    vm1.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "192.168.0.10"
    config.vm.synced_folder "./share", "/home/vagrant/share", type: "rsync"

    vm1.vm.provision "shell", path: "provision/docker-setup.sh"
  end
end
