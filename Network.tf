resource "aws_vpc" "k8s-vpc" {
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = var.vpcCIDRblock
    enable_dns_hostnames             = var.dnsHostNames
    enable_dns_support               = var.dnsSupport
    tags                             = {
        "Name" = "k8s-vpc"
    }
    tags_all                         = {
        "Name" = "k8s-vpc"
    }
}


resource "aws_subnet" "k8s-subnet" {
    availability_zone               = var.availabilityZone
    cidr_block                      = var.privatesCIDRblock
    tags                            = {
        "Name" = "k8s-subnet"
    }
    tags_all                        = {
        "Name" = "k8s-subnet"
    }
    vpc_id                          = aws_vpc.k8s-vpc.id
}


resource "aws_network_acl" "Public_NACL" {
    vpc_id = aws_vpc.k8s-vpc.id
    subnet_ids = [ aws_subnet.k8s-subnet.id ]
    ingress {
        action          = "allow"
        cidr_block      = var.publicdestCIDRblock
        from_port       = 0
        icmp_code       = 0
        icmp_type       = 0
        ipv6_cidr_block = ""
        protocol        = "-1"
        rule_no         = 100
        to_port         = 0        
    }

    egress {
        action          = "allow"
        cidr_block      = var.publicdestCIDRblock
        from_port       = 0
        icmp_code       = 0
        icmp_type       = 0
        ipv6_cidr_block = ""
        protocol        = "-1"
        rule_no         = 100
        to_port         = 0
    }
  
tags = {
    Name = "Public NACL"
}
}

resource "aws_internet_gateway" "IGW_K8S" {
  vpc_id = aws_vpc.k8s-vpc.id
}

resource "aws_route_table" "Public_RT" {
    tags = {
        Name = "Public Route table"
    }
    vpc_id = aws_vpc.k8s-vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.Public_RT.id
  destination_cidr_block = var.publicdestCIDRblock
  gateway_id             = aws_internet_gateway.IGW_K8S.id
}
resource "aws_route_table_association" "Public_association" {
  subnet_id      = aws_subnet.k8s-subnet.id
  route_table_id = aws_route_table.Public_RT.id
}


resource "aws_security_group" "allow_k8s" {
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 443
            ipv6_cidr_blocks = [
                "::/0",
            ]
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 80
            ipv6_cidr_blocks = [
                "::/0",
            ]
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                var.privatesCIDRblock,
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = -1
            security_groups  = []
            self             = false
            to_port          = 0
        },        
    ]
    name        = "Security Group K8S"
    tags        = {
        "Name" = "Security Group K8S"
    }
    tags_all    = {
        "Name" = "Security Group K8S"
    }
    vpc_id      =  aws_vpc.k8s-vpc.id 

}
