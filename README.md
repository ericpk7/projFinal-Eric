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

Verifique se o servidor DHCP está em execução:

```bash
docker logs dhcp-server
```

#### DNS (Bind9):

Verifique o status do container Bind9:

```bash
docker logs bind9-container
```

#### Web (Apache):

Abra um navegador e acesse

```http://192.168.0.10```

#### NFS:

Verifique o status do container NFS:

```bash
docker logs nfs-test-server
```

#### FTP:

Conecte-se ao servidor FTP usando um cliente FTP, usando as credenciais fornecidas nos logs do contêiner.

```bash
ftp 192.168.0.10
```

## Encerrando o Ambiente
Para encerrar e remover todos os recursos criados, execute:

```bash
vagrant destroy
```

Isso encerrará a máquina virtual e removerá todos os containers Docker associados.


