region              = "us-east-1"
s3_bucket_name      = "test-final-bucket-1"
dynamodb_table_name = "ivolvegp-table"
vpc_name            = "ivolve"
vpc_cidr            = "10.0.0.0/16"
subnets = [
  {
    cidr = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
  },
  {
    cidr = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
  }
]

security_group_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
 
  
]

ami_id               = "ami-0e2c8caa4b6378d8c"
key_name             = "DevOps-test"

instance_type        = "t3.xlarge"
ec2_name             = "ivolve"
cloudwatch_log_group = "log-group"
cloudwatch_log_stream = "log-stream"
cloudwatch_config_ssm_key = "cloudwatch-config"
sns_topic_name            = "ivolve-sns-topic"
sns_subscription_protocol = "email"
sns_subscription_endpoint = "ahmed.software200@gmail.com"
