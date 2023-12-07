# DHCP
docker run -d --name dhcp-server --network=host networkboot/dhcpd:vanilla -i ens33

# DNS
docker run -d --name dns-server --network=host andyshinn/dnsmasq

# Apache
docker run -d --name apache-server -p 80:80 -v /html:/usr/local/apache2/htdocs httpd

# FTP (vsftpd)
docker run -d --name ftp-server -p 21:21 -v /ftp:/home/vsftpd --restart always fauria/vsftpd

# NFS
docker run -d --privileged --name nfs-server -p 2049:2049 -v /nfs:/nfsshare -e SHARED_DIRECTORY=/nfsshare itsthenetwork/nfs-server-alpine:latest
