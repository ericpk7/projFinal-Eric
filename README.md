# Configuração de Ambiente de Rede com Docker

Este repositório contém scripts e configurações para criar um ambiente de rede usando Docker, incluindo servidores DHCP, DNS, Web (Apache), NFS e FTP. O ambiente é provisionado em uma máquina virtual usando Vagrant.

## Pré-requisitos
* [Vagrant](https://www.vagrantup.com)
* [VirtualBox](https://www.virtualbox.org)
* [Docker](https://www.docker.com)

## Instalação
Clone este repositório em seu ambiente local:

```bash
git clone https://github.com/ericpk7/projFinal-Eric.git
cd projFinal-Eric
```

Execute o script de provisionamento Vagrant para configurar a máquina virtual:
```bash
vagrant up
```

Entre na máquina virtual:
```bash
vagrant ssh
```

## Testando os Serviços

#### DHCP:

Acesse alguma VM (de preferência a client) e verifique o ip da máquina:

```bash
ip a
```

A máquina deve apresentar a rede enp0s8, e um ip 192.156.56.X

#### DNS (Bind9):

Para o teste do DNS, você pode usar o nslookup no domínio configurado:

```bash
nslookup teste.com
```

#### Web (Apache):

Abra um navegador e acesse

```http://192.168.56.24```

#### NFS:

Certifique-se que o cliente nfs está instalado na máquina: 
```bash
sudo apt-get update
sudo apt-get install nfs-common
```

Crie um diretório onde você deseja montar o compartilhamento e monte o compartilhamento NFS:
```bash
sudo mount 192.168.56.28:/share /mnt/nfs-share
```

Verifique se o conteúdo foi compartilhado
```bash
ls /mnt/nfs-share
```

#### FTP:

Conecte-se ao servidor FTP usando um cliente FTP, usando as credenciais fornecidas nos logs do contêiner.
Utilize algums dos Ips distribuidos pelo DHCP.

```bash
ftp 192.168.56.28
```

## Encerrando o Ambiente
Para encerrar e remover todos os recursos criados, execute:

```bash
vagrant destroy
```

Isso encerrará a máquina virtual e removerá todos os containers Docker associados.


