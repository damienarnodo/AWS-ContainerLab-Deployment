output "public_ip" {
  value = aws_instance.containerlab_host.public_ip
}

output "containerlab_fqdn" {
  value = var.AWS_R53_ENABLED && length(aws_route53_record.containerlab_fqdn) > 0 ? "${aws_route53_record.containerlab_fqdn[0].name}.${data.aws_route53_zone.selected.name}" : ""
}
