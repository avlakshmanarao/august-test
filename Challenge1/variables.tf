
variable "profile" {
  description = "AWS credentials profile to use"
  type        = string
  default     = "default"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default = "sonarqube"
}


variable "region" {
  description = "AWS region"
  type        = string
  default = "eu-west-2"
}


variable "public_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type = list
  default = ["10.1.0.0/20", "10.1.16.0/20"]
}


variable "private_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type = list
  default = ["10.1.32.0/20", "10.1.48.0/20"]
}

variable "database_subnets_cidr" {
  description = "subnet cidr details defined for DB"
  type = list
  default = ["10.1.64.0/24", "10.1.66.0/24"]
}

variable "azs" {
  description = "available zones"
  type = list
  default = ["eu-west-2a","eu-west-2b"]
}

variable "vpc_cidr"{
  description = "cidr block assoaciated with vpc"
  type        = string
  default = "10.1.0.0/16"
}

variable "image_id"{
  description = "AMI Image Id"
  type        = string
  default = "ami-3622cf51"
}
