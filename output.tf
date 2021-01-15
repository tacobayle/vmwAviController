# Outputs for Terraform

output "test" {
  value = [join(",", data.template_file.nodes.*)]
}
