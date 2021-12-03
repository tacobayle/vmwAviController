# Outputs for Terraform

output "controllers_ip" {
  value = vsphere_virtual_machine.controller.*.default_ip_address
}