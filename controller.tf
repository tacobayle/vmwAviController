
resource "vsphere_virtual_machine" "controller" {
  count            = length(var.controller.mgmt_ips)
  name             = "controller-${var.controller.version}-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.networks[count.index].id
  }

  num_cpus = var.controller.cpu
  memory = var.controller.memory
  wait_for_guest_net_timeout = var.controller.wait_for_guest_net_timeout
  guest_id = "guestid-${var.controller.version}-${count.index}"

  disk {
    size             = var.controller.disk
    label            = "controller-${var.controller.version}-${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.aviController[0].id
  }

  vapp {
    properties = {
      "mgmt-ip"     = element(var.controller.mgmt_ips, count.index)
      "mgmt-mask"   = element(var.controller.mgmt_masks, count.index)
      "default-gw"  = element(var.controller.default_gws, count.index)
   }
 }
}
