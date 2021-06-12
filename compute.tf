resource "aws_spot_instance_request" "k8s-master" {
    availability_zone               = "${var.availabilityZone}"
    ami                             = "${var.ami}"
    instance_type                   = "${var.instancetypeMaster}"
    associate_public_ip_address     = true
    block_duration_minutes          = 0
    get_password_data               = false
    instance_interruption_behaviour = "terminate"
    key_name                        = "${var.key_name}"
    user_data                       = <<-EOF
                                        #!/bin/bash
                                        sudo hostnamectl set-hostname ${var.master_machine_name}
                                    EOF
    security_groups                 = [
        aws_security_group.allow_k8s.id,
    ]
    source_dest_check               = true
    spot_price                      = "${var.spotpriceMaster}"
    spot_type                       = "one-time"
    subnet_id                       = aws_subnet.k8s-subnet.id
    tags                            = {
        "Name" = "k8s-master"
    }
    tags_all                        = {
        "Name" = "k8s-master"
    }
    vpc_security_group_ids          = [
        aws_security_group.allow_k8s.id,
    ]

    root_block_device {
        delete_on_termination = true
        encrypted             = false
        iops                  = 100
        tags                  = {
            "Name" = "k8s-master"
        }
        volume_size           = 10
    }

    provisioner "local-exec" {
      command = "sleep 30"
    }
    provisioner "local-exec" {
        command = "aws ec2 create-tags --resources ${aws_spot_instance_request.k8s-master.spot_instance_id} --tags Key=Name,Value=${var.master_machine_name} --region ${var.region}"
    }
    provisioner "local-exec" {
        command = "sleep 20 && export ANSIBLE_CONFIG=${path.module}/ansible/ansible.cfg && ansible-playbook --private-key=${path.module}/secrets/${var.key_name}.pem --extra-vars 'node_ip=${aws_spot_instance_request.k8s-master.public_ip} hostname=${var.master_machine_name} ' ${path.module}/ansible/master.yml"
    }
    wait_for_fulfillment            = true
}


resource "aws_spot_instance_request" "k8s-Node" {
    availability_zone               = "${var.availabilityZone}"
    ami                             = "${var.ami}"
    instance_type                   = "${var.instancetypeNode}"
    associate_public_ip_address     = true
    block_duration_minutes          = 0
    get_password_data               = false
    instance_interruption_behaviour = "terminate"
    key_name                        = "${var.key_name}"
    security_groups                 = [
        aws_security_group.allow_k8s.id,
    ]
    source_dest_check               = true
    spot_price                      = "${var.spotpriceNode}"
    spot_type                       = "one-time"
    subnet_id                       = aws_subnet.k8s-subnet.id
    tags                            = {
        "Name" = "k8s-Node"
    }
    tags_all                        = {
        "Name" = "k8s-Node"
    }
    user_data                       = <<-EOF
                                        #!/bin/bash
                                        sudo hostnamectl set-hostname ${var.NodeHostname}
                                    EOF
    vpc_security_group_ids          = [
        aws_security_group.allow_k8s.id,
    ]

    root_block_device {
        delete_on_termination = true
        encrypted             = false
        iops                  = 100
        tags                  = {
            "Name" = "k8s-Node"
        }
        volume_size           = 10
    }

    provisioner "local-exec" {
      command = "sleep 30"
    }
    provisioner "local-exec" {
        command = "aws ec2 create-tags --resources ${aws_spot_instance_request.k8s-Node.spot_instance_id} --tags Key=Name,Value=${var.NodeHostname} --region ${var.region}"
    }    
    wait_for_fulfillment            = true

    provisioner "local-exec" {
        command = "sleep 20 && export ANSIBLE_CONFIG=${path.module}/ansible/ansible.cfg && ansible-playbook --private-key=${path.module}/secrets/${var.key_name}.pem --extra-vars 'node_ip=${aws_spot_instance_request.k8s-Node.public_ip} hostname=${var.NodeHostname} ' ${path.module}/ansible/node.yml"
    }

    depends_on = [aws_spot_instance_request.k8s-master]
}

resource "aws_ec2_tag" "k8s-Master" {
  resource_id = aws_spot_instance_request.k8s-master.id 
  key         = "Name"
  value       = "k8s-master"
}


