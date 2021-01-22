resource "null_resource" "wait_https_controller" {
  depends_on = [vsphere_virtual_machine.controller]
  count            = length(var.controller.mgmt_ips)

  provisioner "local-exec" {
    command = "until $(curl --output /dev/null --silent --head -k https://${element(var.controller.mgmt_ips, count.index)}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.wait_https_controller]

  provisioner "local-exec" {
    command = "ansible-playbook ansible/main.yml --extra-vars '{\"avi_backup_passphrase\": ${jsonencode(var.avi_backup_passphrase)}, \"controller\": ${jsonencode(var.controller)}, \"avi_user\": ${jsonencode(var.avi_user)}, \"avi_password\": ${jsonencode(var.avi_password)}, \"avi_version\": ${split("-", basename(var.contentLibrary.file))[1]}}'"
  }
}