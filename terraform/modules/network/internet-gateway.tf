# Resource: aws_internet_gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "prod-ue1" {
  # The VPC ID to create in.
  vpc_id = aws_vpc.prod-ue1.id

  # A map of tags to assign to the resource.
  tags = {
    Name        = "prod-ue1-igw"
    Terraform   = "true"
  }
}