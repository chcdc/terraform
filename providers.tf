terraform {
    required_version = ">= 1.0.0"
    
    required_providers {
        aws     = "~> 3.44.0"
        local   = "~> 2.1.0"
        null    = "~> 3.1.0"
        tls     = "~> 3.0.0"
    }
}

provider "aws" {
    region                  = var.region
    shared_credentials_file = "~/.aws/credentials"
}
