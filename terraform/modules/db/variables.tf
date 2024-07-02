variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks"
  type        = list(string)
}

variable "allocated_storage" {
  description = "The amount of storage allocated"
  type        = number
}

variable "storage_type" {
  description = "The type of storage"
  type        = string
}

variable "engine" {
  description = "The type of database engine"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class"
  type        = string
}

variable "identifier" {
  description = "The DB instance identifier"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
}

variable "parameter_group_name" {
  description = "The parameter group name"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the instance is publicly accessible"
  type        = bool
}
