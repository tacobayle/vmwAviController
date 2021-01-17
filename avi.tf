//resource "null_resource" "wait_https_controller" {
//  depends_on = [vsphere_virtual_machine.controller]
//  count            = length(var.controller.mgmt_ips)
//
//  provisioner "local-exec" {
//    command = "until $(curl --output /dev/null --silent --head -k https://${element(var.controller.mgmt_ips, count.index)}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
//  }
//}

//resource "null_resource" "ansible" {
//  depends_on = [null_resource.wait_https_controller]
//  provisioner "local-exec" {
//    command = "ansible-playbook ansible/main.tf --extra-vars "
//  }
//}
//
//resource "avi_useraccount" "update_admin_password" {
//  depends_on = [null_resource.wait_https_controller]
//  username     = var.avi_user
//  old_password = "58NFaGDJm(PJH0G"
//  password     = var.avi_password
//}
//
//data "avi_cluster" "data_cluster" {
//  depends_on = [avi_useraccount.update_admin_password]
//  name = "cluster-0-1"
//}
//
//data "template_file" "nodes" {
//  count = length(var.controller.mgmt_ips)
//  template = file("${path.module}/template/nodes.tmpl")
//  vars = {
//    name     = element(var.controller.mgmt_ips, count.index)
//    addr     = element(var.controller.mgmt_ips, count.index)
//  }
//}
//
//resource "avi_cluster" "res_cluster" {
//  depends_on = [avi_useraccount.update_admin_password]
//  name = "cluster-0-1"
//  nodes {
//    name = var.controller.mgmt_ips.0
//    ip {
//      addr = var.controller.mgmt_ips.0
//      type ="v4"
//    }
//  }
//  nodes {
//    name = var.controller.mgmt_ips.1
//    ip {
//      addr = var.controller.mgmt_ips.1
//      type ="v4"
//    }
//  }
//  nodes {
//    name = var.controller.mgmt_ips.2
//    ip {
//      addr = var.controller.mgmt_ips.2
//      type ="v4"
//    }
//  }
//}
//  #nodes = [join(",", data.template_file.nodes.*.rendered)]
//
//
////resource "avi_cluster" "res_cluster" {
////  name = "cluster-0-1"
////  dynamic nodes {
////    for_each = [for ip in var.controller.mgmt_ips:{
////      ip = ip
////    }]
////    content {
////      name = nodes.value
////      ip {
////        addr = nodes.value
////        type ="v4"
////      }
////    }
////  }
////  #nodes = [join(",", data.template_file.nodes.*.rendered)]
////}