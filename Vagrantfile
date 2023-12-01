# Vagrantfile

Vagrant.configure("2") do |config|

  # DHCP
  config.vm.define "dhcp_server" do |dhcp|
    dhcp.vm.box = "ubuntu/focal64"
    dhcp.vm.network "private_network", type: "dhcp"
  
    dhcp.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y isc-dhcp-server
      echo "INTERFACESv4=\"enp0s8\"" | sudo tee /etc/default/isc-dhcp-server
      sudo systemctl restart isc-dhcp-server
    SHELL
  
    dhcp.vm.provision "docker" do |d|
      d.run "dhcp_server",
        image: "networkboot/dhcpd",
        ports: ['67:67/udp'],
        auto_assign_name: false,
        command: "-d",
        options: ['--volume', '/vagrant/dhcpd.conf:/etc/dhcp/dhcpd.conf']
    end
  end
  
  # DNS
  config.vm.define "dns_server" do |dns|
    dns.vm.box = "ubuntu/focal64"
    dns.vm.network "private_network", type: "dhcp"
    dns.vm.provision "docker" do |d|
      d.run "dns_server",
        image: "ubuntu/bind9:latest",
        ports: ['53:53/tcp', '53:53/udp'],
        auto_assign_name: false,
        command: "-g",
        options: ['--volume', '/vagrant/named.conf:/etc/bind/named.conf', '--volume', '/vagrant/db.teste.com:/etc/bind/db.teste.com']
    end
  end

  # APACHE
  config.vm.define "web_server" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.network "private_network", type: "dhcp"
    web.vm.provider "docker" do |d|
      d.build_dir = "/vm_apache/"
      d.build_args = [ "-t", "apacheimage" ]
      d.create_args = [ "-i", "-t" ]
      d.has_ssh = false
      d.ports = [ "8080:80" ]
      d.name = "apache_server"
    end
  end

  # FTP
  config.vm.define "ftp_server" do |ftp|
    ftp.vm.box = "ubuntu/focal64"
    ftp.vm.network "private_network", type: "dhcp"
    ftp.vm.provision "docker" do |d|
      d.run "ftp_server",
        image: "webdevops/vsftp:latest",
        ports: ['20-21:20-21', '21100-21110:21100-21110'],
        auto_assign_name: false
    end
  end

  # NFS
  config.vm.define "nfs_server" do |nfs|
    nfs.vm.box = "ubuntu/focal64"
    nfs.vm.network "private_network", type: "dhcp"

    nfs.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y nfs-common
  SHELL

    nfs.vm.provision "docker" do |d|
      d.run "nfs_server",
        image: "itsthenetwork/nfs-server-alpine",
        ports: ['2049:2049'],
        auto_assign_name: false,
        options: ['--volume', '/share:/nfsshare']
    end
  end

  # TEstes
  config.vm.define "client" do |client|
    client.vm.box = "ubuntu/focal64"
    client.vm.network "private_network", type: "dhcp"
    client.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y nfs-common
    SHELL
  end
end
