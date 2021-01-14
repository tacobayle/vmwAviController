resource "null_resource" "ansible" {
  depends_on = [vsphere_virtual_machine.controller]

  provisioner "local-exec" {
    command = "printf '{\"controller\": ${jsonencode(var.controller)}}' > controller.json"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i /opt/ansible/inventory/inventory.vmware.yml ansible/main.yml --extra-vars @controller.json --extra-vars 'avi_password=${var.avi_password} avi_user=${var.avi_user}'"
  }
}