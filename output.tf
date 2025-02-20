output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "ec2_public_ips" {
  value = module.ec2_instance.public_ip
}

output "ec2_public_dns" {
  value = module.ec2_instance.public_dns
}
