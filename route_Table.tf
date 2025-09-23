#################################
# Route Tables
#################################
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public_RT"
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private_RT"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

#################################
# Route Table Associations
#################################
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "subnet3_association" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "subnet4_association" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.public_RT.id
}