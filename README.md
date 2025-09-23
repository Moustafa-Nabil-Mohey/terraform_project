⚠️ Note on AWS ALB:

This project includes Terraform code for an Application Load Balancer (ALB) ,2 AZ , 4 subnets , IAM role , IGW ,NGW and Security group  .  
However, due to current issues with AWS ALB configuration in my account, the ALB section is commented out in `autoscaling_group.tf`.  

The rest of the infrastructure — VPC, Subnets, NAT, Security Groups, Bastion Host, S3, IAM roles, Launch Templates, and Auto Scaling Group — is fully deployable and operational.  

If the ALB works in your account, you can safely delete the existing `autoscaling_group` resource and uncomment the ALB-related code to enable it.
