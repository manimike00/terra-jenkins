provider "aws" {
	region = "ap-south-1"
	profile = "default"
}

data "aws_region" "current" {}

terraform {
  backend "s3" {
    bucket          = "terraform-statefiles-geospoc"
    key             = "sample/ec2.state"
    region          = "ap-south-1"
    dynamodb_table  = "terraform-lockstatus-geospoc"
  }
}


module "ec2-instance" {
  source = "./module"
  name      = "demo"
  env       = "dev"
  key       = "test"
  project   = "custom"
  ami       = "ami-0123b531fc646552f"
  type      = "t2.micro"
  size      = 15
}


