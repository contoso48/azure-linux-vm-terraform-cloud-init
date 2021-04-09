# azure-linux-vm-vnet-terraform-cloud-init

This is for an Azure Linux VM with Ubuntu (ex: 18.04)

Design goals for custom_data (cloud-init):
- Setup http_proxy settings in environment all-up for general use after cloud-init
- Allow cloud-init to pull apt packages via http_proxy as well, given a restricted corp-group-vnet setup
- Setup docker and docker-compose as an example
- GBG Public Key from docker.com comes from (see binsh script-based example 2):
    curl -fsSL "https://download.docker.com/linux/ubuntu/gpg"

Design goals for main.tf and variables.tf template:
- Deploy VM on exsiting VNET / Subnet
- No public IP address - private IP only

Not included:
- Zones
- Load Balancers
- Other extenstions or monitoring agent configurations
- SSH Key for local user (password-based to keep it simple)

Test- or Validation-Level: Basic
- Further testing in hardened network environment with forced tunnelling and proxy needed

ACTIONS:
- Edit existingvnet.tf with your VNET name, RG, and Subnet-Name
- Edit cloud-init.txt with your real Proxy IP address and settings
- Edit cloud-init.txt apt section if you want packages from another source
- Edit variables.tf to change the prefix name of the VM
