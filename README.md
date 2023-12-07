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

Entre na máquina virtual cliente para realizar os testes:
```bash
vagrant ssh client
```

## Testando os Serviços

#### DHCP:

Agora na VM Client, verifique o ip da máquina:

```bash
ip a
```

A máquina deve apresentar a rede enp0s8, e um ip 192.156.56.X

#### DNS:

Para o teste do DNS, você pode usar o cat para verificar o arquivo de configuração do DNS:

```bash
cat /etc/resolv.conf
```

#### Web (Apache):

Abra um navegador e acesse o ip da VM1:

```http://192.168.56.44```

#### NFS:

Crie um diretório onde você deseja montar o compartilhamento:
```bash
sudo mkdir /mnt/nfs
```

Agora monte o diretório com:
```bash
sudo mount -t nfs 192.168.56.44:/nfsshare /mnt/nfs
```

Verifique se o conteúdo foi compartilhado
```bash
ls /mnt/nfs
```

#### FTP:

Conecte-se ao servidor FTP usando um cliente FTP, usando as credenciais fornecidas nos logs do contêiner.

```bash
ftp 192.168.56.44 21
```

## Encerrando o Ambiente
Para encerrar e remover todos os recursos criados, execute:

```bash
vagrant destroy
```

Isso encerrará a máquina virtual e removerá todos os containers Docker associados.


