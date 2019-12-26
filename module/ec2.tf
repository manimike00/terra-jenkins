resource "aws_security_group" "allow_tls" {
  name        = "${var.env}-${var.name}-security_group"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
	  from_port = 80
	  protocol = "tcp"
	  to_port = 80
	  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
	Name = "${var.name}-security_group"
	Project = var.project
  }
}


resource "aws_instance" "terraform_ec2" {
  	ami 				= var.ami
  	instance_type 		= var.type
  	key_name  			= var.key
	security_groups		= [aws_security_group.allow_tls.name]
  	root_block_device {
      		volume_type				= "standard"
      		volume_size				= var.size
      		delete_on_termination 	= true
  		}
  	volume_tags   = {
    			Name    = "${var.env}-${var.name}"
    			Project = var.project
  		}
  	tags = {
		Name = "${var.env}-${var.name}"
		Project = var.project
	}
}
