resource "null_resource" "ansible" {
  depends_on = [
    vsphere_virtual_machine.controller]

  provisioner "local-exec" {
    command = "ansible-playbook -i /opt/ansible/inventory/inventory.vmware.yml ansible/main.yml"
  }
}