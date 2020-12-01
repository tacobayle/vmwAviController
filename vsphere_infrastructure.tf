
data "vsphere_datacenter" "dc" {
  name = var.vcenter.dc
}

data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.vcenter.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = var.vcenter.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vcenter.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "networks" {
  count = length(var.controller.networks)
  name = element(var.controller.networks, count.index)
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "folder" {
  path          = var.controller.folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_tag_category" "ansible_group_avi_controller" {
  name = "ansible_group_avi_controller"
  cardinality = "SINGLE"
  associable_types = [
    "VirtualMachine",
  ]
}