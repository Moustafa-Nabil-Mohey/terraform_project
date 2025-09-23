#################################
# Internet Gateway
#################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-gateway"
  }
}

#################################
# NAT Gateway
#################################
resource "aws_eip" "nat_eip" { 
  domain = "vpc"  #→ Ensures the EIP is for a VPC.
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet3.id #→ NAT Gateway must be in a public subnet.
  tags = {
    Name = "nat-gateway"
  }
}