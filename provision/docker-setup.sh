sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant
sudo systemctl restart docker

sudo docker network create --driver bridge rede-docker

# Servidor DHCP
docker run -d --name docker-dhcpd \
           --network rede-docker \
           -v "$(pwd)/data:/data" \
           -e PUID=1111 \
           -e PGID=1112 \
           -p 67:67/udp \
           --restart unless-stopped \
           wastrachan/docker-dhcpd:latest



# Servidor DNS (Bind9) OK
docker run -d --name bind9-container -e TZ=UTC -p 30053:53 --network rede-docker ubuntu/bind9:9.18-22.04_beta

# Servidor WEB (Apache) OK
sudo docker run -d --name apache-server -p 80:80 --network rede-docker httpd:latest

# Servidor NFS
docker run -v /$(pwd)nfs-share:/nfsshare \
           -v $(pwd)/nfs-share/exports.txt:/etc/exports:ro \
           --name nfs-server \
           --cap-add SYS_ADMIN \
           -p 2049:2049 \
           erichough/nfs-server


# Servidor FTP (vsftpd) OK
docker run --name ftp-server --rm --network rede-docker fauria/vsftpd
