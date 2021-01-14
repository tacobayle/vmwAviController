#
# Environment Variables
#
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "avi_password" {}
variable "avi_user" {}

#
# Other Variables
#

variable "vcenter" {
  type = map
  default = {
    dc = "sof2-01-vc08"
    cluster = "sof2-01-vc08c01"
    datastore = "sof2-01-vc08c01-vsan"
    resource_pool = "sof2-01-vc08c01/Resources"
  }
}

variable "contentLibrary" {
  default = {
    name = "Avi Content Library"
    description = "Avi Content Library"
    file = "/home/ubuntu/controller-20.1.3-9085.ova" # don't change the file name - it is used to retrieve the Avi version
  }
}

variable "controller" {
  default = {
    cpu = 8
    memory = 24768
    disk = 128
    wait_for_guest_net_timeout = 2
    folder = "NicTfAviControllers"
    networks = ["vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt", "vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt", "vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt"]
    mgmt_ips = ["10.41.134.127", "10.41.134.128", "10.41.134.129"]
    mgmt_masks = ["255.255.252.0", "255.255.252.0", "255.255.252.0"]
    default_gws = ["10.41.132.1", "10.41.132.1", "10.41.132.1"]
    #floatingIp = "10.41.134.130"
    dns =  ["10.23.108.1", "10.23.108.2"]
    ntp = ["95.81.173.155", "188.165.236.162"]
    from_email = "avicontroller@avidemo.fr"
    se_in_provider_context = "true"
    tenant_access_to_provider_se = "true"
    tenant_vrf = "false"
  }
}