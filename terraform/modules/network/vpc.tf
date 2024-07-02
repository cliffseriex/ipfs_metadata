# Resource: aws_vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "prod-ue1" {
  
  #name = "${vpc_name}"
  # The CIDR block for the VPC.
  cidr_block = "172.20.0.0/26"

  # Makes your instances shared on the host.
  instance_tenancy = "default"

  # Required for EKS. Enable/disable DNS support in the VPC.
  enable_dns_support =   true

  # Required for EKS. Enable/disable DNS hostnames in the VPC.
  enable_dns_hostnames = "true"  #"${enable_dns_hostnames}"

  # Enable/disable ClassicLink for the VPC.
 # enable_classiclink = false

  # Enable/disable ClassicLink DNS Support for the VPC.
#  enable_classiclink_dns_support = false

  # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC.
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource.
  tags = {
    Name      = "prod-ue1"
    terraform = "true"
    env       = "prod"
  }
}



