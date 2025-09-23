#################################
# Provider
#################################
provider "aws" {
  region = "us-east-1"
}

#################################
# VPC
#################################
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Moustafa-vpc" // Change the name as needed
  }
}
#you may use this 
# terraform  init
# terraform  plan   
# terraform  apply
# terraform  destroy


#curl http://Private IPv4 addresses ex 1.2.3.4
# to connect to the private instance from jump server use this command
#ssh -i "key directory" ec2-user@Public IPv4 addresses ex 192.168.2.25