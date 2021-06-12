output "public_ip_Master" {
  value = aws_spot_instance_request.k8s-master.public_ip
}

output "public_ip_Node" {
  value = aws_spot_instance_request.k8s-Node.public_ip
}