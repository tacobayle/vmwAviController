resource "null_resource" "ansible" {
  depends_on = [
    vsphere_virtual_machine.controller]


  # ansible and pip package installation
  provisioner "local-exec" {
    command = "sudo apt install python-pip ; pip install pyvmomi dnspython ansible==${var.ansible.version} avisdk==${var.ansible.avisdkVersion}; pip install --upgrade pip setuptools ; pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git"
  }

  # Avi ansible role installation
  provisioner "local-exec" {
    command = "sudo -u $USER ansible-galaxy install -f avinetworks.avisdk"
  }

}