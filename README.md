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
export TF_VAR_vsphere_server=******
export TF_VAR_vsphere_password=******
export TF_VAR_avi_password=******
export TF_VAR_avi_user=admin
```

## Environment:

Terraform Plan has/have been tested against:

### terraform

```
Terraform v0.13.5
+ provider registry.terraform.io/hashicorp/null v3.0.0
+ provider registry.terraform.io/hashicorp/vsphere v1.24.3
```

### Ansible

```
ansible 2.9.12
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/ubuntu/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ubuntu/.local/lib/python2.7/site-packages/ansible
  executable location = /home/ubuntu/.local/bin/ansible
  python version = 2.7.17 (default, Sep 30 2020, 13:38:04) [GCC 7.5.0]
```

### Ansible Avi Role
```
- avinetworks.avisdk, 20.1.2-beta
```

## Input/Parameters:
1. All the variables are stored in variables.tf

## Use the terraform plan to:
- Create a new folder within v-center
- Spin up n Avi Controller in the new folder - the count is defined by the amount of fixed IP defined in var.controller.mgmt_ips
- Wait for the https to be ready
- Bootstrap the Avi controller - Ansible  
- Make the Avi controller cluster config - Ansible - floating IP will be configured if var.controller.floating_ip has been defined
- Configure Avi Passphrase - Ansible
- Configure System config - Ansible

## Run TF Plan:
```
cd ~ ; git clone https://github.com/tacobayle/vmwAviController ; cd aviVmw ; terraform init ;
```
Change the variables.tf according to your environment
```
terraform apply -auto-approve
```