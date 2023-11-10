output "public_ip" {
  value = aws_instance.containerlab_host.public_ip
}

output "containerlab_fqdn" {
  value = "${aws_route53_record.containerlab_fqdn.name}.${data.aws_route53_zone.selected.name}"
}
