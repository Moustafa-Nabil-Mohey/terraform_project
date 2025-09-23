
#################################
# Launch Template + Auto Scaling Group
#################################
resource "aws_launch_template" "app_template" {
  image_id      = "ami-08982f1c5bf93d976"
  instance_type = "t3.micro"
  key_name      = "key"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [aws_security_group.HTTP-SG.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3
    echo "Hello, World from Moustafa Nabil , $(hostname -f)" > /home/ec2-user/index.html
    cd /home/ec2-user
    python3 -m http.server 80 &
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG_Instance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

/*
#################################
# Launch Template + Auto Scaling Group + ALB
#################################
resource "aws_launch_template" "app_template" {
  image_id      = "ami-08982f1c5bf93d976"
  instance_type = "t3.micro"
  key_name      = "key"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [aws_security_group.HTTP-SG.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3
    echo "Hello, World from Moustafa Nabil , $(hostname -f)" > /home/ec2-user/index.html
    cd /home/ec2-user
    python3 -m http.server 80 &
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG_Instance"
    }
  }
}

resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.HTTP-SG.id]
  subnets            = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]

  tags = {
    Name = "App-ALB"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "App-TG"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_autoscaling_group" "app" {
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  # ربط الـ ASG بالـ Target Group
  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

#################################
# Outputs
#################################
output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_alb.dns_name
}

*/
