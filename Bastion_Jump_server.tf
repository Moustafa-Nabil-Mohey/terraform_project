#################################
# Bastion Host (Jump Server)
#################################
resource "aws_instance" "jumper_instance" {
  ami                         = "ami-08982f1c5bf93d976"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet3.id
  vpc_security_group_ids      = [aws_security_group.jumper-SG.id]
  associate_public_ip_address = true
  key_name                    = "key"

  tags = {
    Name = "jump-server"
  }
}