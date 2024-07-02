provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tf-services-aws"
    key    = "tf-aws-services/ue1/eks/prod/cluster-config/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.55"
    }
  }
  //required_version = ">= 0.13, < 0.15"
  required_version = ">= 1.0"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "tf-services-aws"
    key    = "tf-aws-infra/global/terraform.tfstate"
    region = "us-east-1"
  }
}




data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["ue1-prod"]
  }
}

data "aws_subnet" "private_1" {
  filter {
    name   = "tag:Name"
    values = ["prod-private-a"]
  }
}

data "aws_subnet" "private_2" {
  filter {
    name   = "tag:Name"
    values = ["prod-private-c"]
  }
}


module "rds" {
  source = "../../../modules/db"

  db_subnet_group_name  = "main-subnet-group"
  subnet_ids            = [data.aws_subnet.private_1.id,data.aws_subnet.private_2.id]
  vpc_id                = data.aws_vpc.vpc.id
  cidr_blocks           = ["10.0.0.0/16"]

  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = "12.15"
  instance_class        = "db.t3.micro"
  identifier            = "blockparty-db-instance"
  db_name               = "blockparty"
  db_user               = "blockparty"
  db_password           = "blockparty"
  parameter_group_name  = "default.postgres12"
  skip_final_snapshot   = true
  publicly_accessible   = false
}

output "db_instance_address" {
  value = module.rds.db_instance_address
}

output "db_instance_identifier" {
  value = module.rds.db_instance_identifier
}