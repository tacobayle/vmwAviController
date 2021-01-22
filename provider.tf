provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vcenter.server
  allow_unverified_ssl = true
}