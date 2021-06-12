variable "region" {
     default = "us-east-1"
}

variable "master_machine_name"{
    default = "master"
}

variable "NodeHostname"{
    default = "node"
}

variable "key_name" {
    type = string
}

variable "tags" {
    default = "master"
}

variable "spotpriceMaster" {
    default    = "0.0139"
}

variable "spotpriceNode" {
    default    = "0.0035"
}

variable "instancetypeMaster" {
    default     = "t2.medium"
}

variable "instancetypeNode" {
    default     = "t2.micro"
}


variable "ami" {
    #Ubuntu 20.04
    default = "ami-09e67e426f25ce0d7" 
}

## Network
variable "availabilityZone" {
     default = "us-east-1d"
}

variable "dnsSupport" {
    default = true
}

variable "dnsHostNames" {
    default = true
}

variable "vpcCIDRblock" {
    description = "CIDR Block of VPC"
    default = "10.0.0.0/16"
    type = string
}

variable "publicsCIDRblock" {
    default = "10.0.1.0/24"
}

variable "privatesCIDRblock" {
    default = "10.0.2.0/24"
}

variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}

variable "localdestCIDRblock" {
    default = "10.0.0.0/16"
}

variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "mapPublicIP" {
    default = true
}

variable "ipAddress" {
    type = list
    default = [ "0.0.0.0/0" ]
}



