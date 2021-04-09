# azure-linux-vm-vnet-terraform-cloud-init

This is for an Azure Linux VM with Ubuntu (ex: 18.04)

Design goals:
- Setup http_proxy settings in environment all-up for general use after cloud-init
- Allow cloud-init to pull apt packages via http_proxy as well, given a restricted corp-group-vnet setup
- Setup docker and docker-compose as an example

