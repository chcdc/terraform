variable "region" {
     default = "us-east-1"
}

variable "master_machine_name"{
    default = "master"
}

variable "NodeHostname"{
    type    = string
    default = "node"
}

variable "key_name" {
    type = string
}

variable "tags" {
    type    = string
    default = "master"
}

variable "spotpriceMaster" {
    type        = number
}

variable "spotpriceNode" {
    type        = number
}

variable "instancetypeMaster" {
    default     = "t2.medium"
}

variable "instancetypeNode" {
    default     = "t2.micro"
}

## VPN
variable "instancetypeVPN" {
    default     = "t2.micro"
}

variable "nameVPN"{
    default = "VPNAccess"
}

variable "spotpriceMicro" {
    default    = "0.0035"
}

variable "ami" {
    #Ubuntu 20.04
    type        = string
    default = "ami-09e67e426f25ce0d7" 
}

## Network
variable "availabilityZone" {
    type        = string
}

variable "dnsSupport" {
    type    = bool
    default = true
}

variable "dnsHostNames" {
    type    = bool
    default = true
}

variable "vpcCIDRblock" {
    description = "CIDR Block of VPC"
    default = "10.0.0.0/16"
    type = string
}

variable "publicsCIDRblock" {
    type = string
    default = "10.0.1.0/24"
}

variable "privatesCIDRblock" {
    type = string
    default = "10.0.2.0/24"
}

variable "publicdestCIDRblock" {
    type = string
    default = "0.0.0.0/0"
}

variable "localdestCIDRblock" {
    type = string
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
    type = bool
    default = true
}

variable "ipAddress" {
    type = list
    default = [ "0.0.0.0/0" ]
}



