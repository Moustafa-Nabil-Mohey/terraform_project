#################################
# Subnets
#################################
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false # Private Subnet
  tags = {
    Name = "priv_subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false # Private Subnet
  tags = {
    Name = "priv_subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true # Public Subnet
  tags = {
    Name = "pub_subnet-1"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true # Public Subnet
  tags = {
    Name = "pub_subnet-2"
  }
}
