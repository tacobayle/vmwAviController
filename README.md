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
```
Terraform v0.14.8
+ provider registry.terraform.io/hashicorp/null v3.1.0
+ provider registry.terraform.io/hashicorp/vsphere v2.0.2
```

### Ansible
```
ansible [core 2.11.3]
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/ubuntu/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ubuntu/.local/lib/python2.7/site-packages/ansible
  ansible collection location = /home/ubuntu/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/ubuntu/.local/bin/ansible
  python version = 2.7.17 (default, Feb 27 2021, 15:10:58) [GCC 7.5.0]
  jinja version = 2.11.2
  libyaml = False
```

### Avi Version
```
controller-21.1.1-9045.ova
```

### Avi python SDK
```shell
ubuntu@nic-jump-sofia:~/vmwAviController$ pip list | grep avi
avisdk                             21.1.1
ubuntu@nic-jump-sofia:~/vmwAviController$
```

### Ansible Avi Role
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
- Make the Avi controller cluster config - Ansible - floating IP will be configured if var.controller.floating_ip has been defined
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