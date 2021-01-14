provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

provider "avi" {
  avi_username   = var.avi_user
  avi_password   = var.avi_password
  avi_controller = var.controller.mgmt_ips[0]
  avi_tenant     = "admin"
  avi_version    = split("-", basename(var.contentLibrary.files[0]))[1]
}