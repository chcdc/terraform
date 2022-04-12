resource "aws_spot_instance_request" "vpn-access" {
  availability_zone               = var.availabilityZone
  ami                             = var.ami
  instance_type                   = var.instancetypeVPN
  associate_public_ip_address     = true
  instance_interruption_behaviour = "terminate"
  key_name                        = var.key_name
  user_data                       = <<-EOF
                                        #!/bin/bash
                                        sudo hostnamectl set-hostname ${var.nameVPN}
                                    EOF
  security_groups = [
    aws_security_group.allow_k8s.id,
  ]
  source_dest_check = true
  spot_price        = var.spotpriceMicro
  spot_type         = "one-time"
  subnet_id         = aws_subnet.k8s-subnet.id
  tags = {
    "Name" = var.nameVPN
  }
  tags_all = {
    "Name" = var.nameVPN
  }
  vpc_security_group_ids = [
    aws_security_group.allow_k8s.id,
  ]

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    tags = {
      "Name" = var.nameVPN
    }
    volume_size = 10
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${aws_spot_instance_request.vpn-access.spot_instance_id} --tags Key=Name,Value=${var.nameVPN} --region ${var.region}"
  }
  provisioner "local-exec" {
    command = "sleep 20 && export ANSIBLE_CONFIG=${path.module}/ansible/ansible.cfg && ansible-playbook --private-key=${path.module}/.secrets/${var.key_name}.pem ${path.module}/ansible/vpn.yml"
  }
  wait_for_fulfillment = true
}
