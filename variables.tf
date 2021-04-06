#
# Environment Variables
#
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "avi_password" {}
variable "avi_backup_passphrase" {}
#
# Other Variables
#
variable "vcenter" {
  type = map
  default = {
    server = "sof2-01-vc08.oc.vmware.com"
    dc = "sof2-01-vc08"
    cluster = "sof2-01-vc08c01"
    datastore = "sof2-01-vc08c01-vsan"
    resource_pool = "sof2-01-vc08c01/Resources"
  }
}

variable "contentLibrary" {
  default = {
    name = "Avi Content Library"
    description = "Avi Content Library Build by TF"
    file = "/home/ubuntu/controller-20.1.4-9087.ova" # don't change the file name - it is used to retrieve the Avi version automatically
  }
}

variable "controller" {
  default = {
    cpu = 8
    memory = 24768
    disk = 128
    wait_for_guest_net_timeout = 4
    folder = "NicWorkshop"
    mgmt_ips = ["10.41.134.127", "10.41.134.128", "10.41.134.129"]
    networks = ["vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt", "vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt", "vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt"]
    mgmt_masks = ["255.255.252.0", "255.255.252.0", "255.255.252.0"]
    default_gws = ["10.41.132.1", "10.41.132.1", "10.41.132.1"]
    floating_ip = "10.41.134.130"
    dns = ["10.23.108.1", "10.23.108.2"]
    ntp = ["95.81.173.155", "188.165.236.162"]
    from_email = "avicontroller@avidemo.fr"
    se_in_provider_context = "true"
    tenant_access_to_provider_se = "true"
    tenant_vrf = "false"
  }
}