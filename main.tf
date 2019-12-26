provider "aws" {
	region = "ap-south-1"
	profile = "default"
}

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
  project   = "custom"
  ami       = "ami-0123b531fc646552f"
  type      = "t2.micro"
  size      = 15
}


