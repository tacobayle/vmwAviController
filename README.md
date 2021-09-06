# vmwAviController

## Goal
Terraform / Ansible | Deploy Avi Controller Cluster and configure it.

## Prerequisites:
- TF installed in the orchestrator VM
- Ansible installed in the orchestrator VM
- Avi Ansible role installed
```
ansible-galaxy install -f avinetworks.avisdk
```
- environment variables:
```
export TF_VAR_vsphere_user=******
export TF_VAR_vsphere_password=******
export TF_VAR_avi_password=******
export TF_VAR_avi_backup_passphrase=******
```

## Environment:

Terraform Plan has/have been tested against:

### terraform

https://learn.hashicorp.com/tutorials/terraform/install-cli

```shell
Terraform v1.0.6
on linux_amd64
+ provider registry.terraform.io/hashicorp/null v3.1.0
+ provider registry.terraform.io/hashicorp/template v2.2.0
+ provider registry.terraform.io/hashicorp/vsphere v2.0.2
```

### Ansible

```shell
sudo apt update
sudo apt install -y python3-pip
pip3 install --upgrade pip
pip3 install ansible==2.10.7
```

```shell
ansible 2.10.13
  config file = None
  configured module search path = ['/home/ubuntu/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ubuntu/.local/lib/python3.8/site-packages/ansible
  executable location = /home/ubuntu/.local/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
```

### Avi Version

```
controller-21.1.1-9045.ova
```

### Avi python SDK

```shell
pip3 install avisdk==21.1.1
```

```shell
ubuntu@nic-jump-sofia:~/vmwAviController$ pip list | grep avi
avisdk                             21.1.1
ubuntu@nic-jump-sofia:~/vmwAviController$
```

### Ansible Avi Role

```shell
ansible-galaxy install -f avinetworks.avisdk
```

```shell
ubuntu@nic-jump-sofia:~/vmwAviController$ ansible-galaxy role list
# /home/ubuntu/.ansible/roles
- avinetworks.avisdk, 21.1.1
ubuntu@nic-jump-sofia:~/vmwAviController$
```

## Input/Parameters:
1. All the variables are stored in variables.tf

## Use the terraform plan to:
- Create a new folder within v-center
- Spin up n Avi Controller in the new folder - the count is defined by the amount of fixed IP defined in var.controller.mgmt_ips
- Wait for the https to be ready
- Bootstrap the Avi controller via Ansible  
- Make the Avi controller cluster config via Ansible - floating IP will be configured if var.controller.floating_ip has been defined
- Configure Avi Passphrase via Ansible
- Configure System config via Ansible

## Run TF Plan:
- Git clone the TF plan

```shell
cd ~ ; git clone https://github.com/tacobayle/vmwAviController ; cd vmwAviController ; terraform init ;
```

- Change the variables.tf according to your environment
  
- Build the plan

```shell
terraform apply -auto-approve
```

- Destroy the plan

```shell
terraform destroy -auto-approve
```