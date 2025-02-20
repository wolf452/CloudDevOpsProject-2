# Terraform AWS Infrastructure🚀

Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision infrastructure in a declarative way, ensuring consistency, automation, and easier collaboration.

This project is a Terraform-based setup for deploying a highly customizable AWS infrastructure. Below is a detailed explanation of each component and module used in this configuration.

## Overview📚

This project provisions a Virtual Private Cloud (VPC), subnets, an internet gateway, security groups, EC2 instances, and sets up logging and monitoring using AWS CloudWatch. It also includes an SNS topic for notifications.

## Prerequisites⭐

- Install Terraform.
- Install AWS CLI and configure it with your credentials (`aws configure`).
- Ensure you have sufficient IAM permissions to create resources in AWS.

## Directory Structure🏗️

- `main.tf`: The root configuration file that integrates all modules.
- `variables.tf`: Defines the input variables for the root module.
- `output.tf`: Specifies the output values from the root module.
- `terraform.tfvars`: Contains the actual values for variables.
- `modules/`: Contains reusable Terraform modules.
![structure](https://github.com/user-attachments/assets/02e40b4f-39f6-4d1b-91e5-c95ff7c7d72c)

## Modules Description

### VPC Module (`modules/vpc`)

├── [**VPC**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/vpc):
<br />
**Purpose**: Creates a Virtual Private Cloud (VPC) in AWS.

**Resources**:
- `aws_vpc`: Provisions the VPC with DNS support and hostnames enabled.

**Inputs**:
- `name`: Name tag for the VPC.
- `cidr`: CIDR block for the VPC.

**Outputs**:
- `vpc_id`: The ID of the created VPC.

![VPC](https://github.com/user-attachments/assets/e73a7fa0-1d96-47c8-bd53-ca8e42778047)
![VPC-VAR](https://github.com/user-attachments/assets/0428ebfb-5697-4976-bfbb-f2c15c02ae9a)

<img width="815" alt="vpcc" src="https://github.com/user-attachments/assets/4786b395-7384-4b80-b1b0-593c46787443" />

### Subnet Module (`modules/subnet`)

├── [**Subnet**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/subnet):
<br />
**Purpose**: Creates public subnets within the VPC.

**Resources**:
- `aws_subnet`: Provisions subnets with specified CIDR blocks and availability zones.

**Inputs**:
- `vpc_id`: ID of the VPC where subnets will be created.
- `subnets`: List of subnet configurations (CIDR, availability zone, and public IP mapping).

**Outputs**:
- `public_subnet_ids`: IDs of the created public subnets.

![SUBNET](https://github.com/user-attachments/assets/f5db557f-9307-49e5-9d7d-8a0535427f2f)
![SUBNET](https://github.com/user-attachments/assets/d9240745-ccf5-43b4-b5be-55f52a1412bb)

<img width="840" alt="subnet;;" src="https://github.com/user-attachments/assets/3cfe7f4e-4511-4653-bbc2-9902fff896f6" />

### Internet Gateway Module (`modules/internet-gateway&aws_route_table`)

├── [**internet-gateway**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/internet-gateway):
<br />
**Purpose**: Sets up an internet gateway and associates it with the VPC's route table for internet access.

**Resources**:
- `aws_internet_gateway`: Creates an internet gateway.
- `aws_route_table`: Configures a route table with a default route to the internet gateway.
- `aws_route_table_association`: Associates the route table with subnets.

**Inputs**:
- `vpc_id`: ID of the VPC.
- `subnets`: List of subnets to associate with the route table.

**Outputs**:
- `internet_gateway_id`: ID of the created internet gateway.
- `route_table_id`: ID of the associated route table.

![first-igw](https://github.com/user-attachments/assets/13657bbf-a38e-4f65-9d82-d16398bd3f8f)
![second-igw](https://github.com/user-attachments/assets/45b4d91d-1384-4353-9aca-985c747da4d2)
![var-igw](https://github.com/user-attachments/assets/1612a3e9-f470-4d52-8c66-5c4c155bddd4)


<img width="817" alt="rt igw" src="https://github.com/user-attachments/assets/669bc3c9-32c6-4629-a3ee-632035778ba7" />

<img width="843" alt="rtt" src="https://github.com/user-attachments/assets/a9c036b2-ac43-40b4-ac37-a35bf04f2733" />

### Security Group Module (`modules/security-group`)

├── [**Security Group**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/security-group):
<br />
**Purpose**: Defines security groups and rules for controlling inbound traffic.

**Resources**:
- `aws_security_group`: Creates a security group in the VPC.
- `aws_security_group_rule`: Configures ingress rules based on user input.

**Inputs**:
- `vpc_id`: ID of the VPC.
- `security_group_rules`: List of ingress rules (protocol, port range, and CIDR blocks).

**Outputs**:
- `security_group_id`: ID of the created security group.

![sg](https://github.com/user-attachments/assets/82d2d205-9ae6-4ae7-9671-4d0b5056e06a)
![sg-var](https://github.com/user-attachments/assets/ac9078b1-730f-4585-88bf-c711edbc85f9)

### EC2 Module (`modules/ec2`)
├── [**EC2**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/ec2):
<br />
**Purpose**: Provisions an EC2 instance with CloudWatch monitoring enabled.

**Resources**:
- `aws_instance`: Creates an EC2 instance with the specified AMI, instance type, and key pair.
- `aws_iam_role` and `aws_iam_instance_profile`: Configures an IAM role for the instance to use CloudWatch.

**Inputs**:
- `ami_id`: AMI ID for the instance.
- `instance_type`: EC2 instance type.
- `subnet_id`: Subnet ID for the instance.
- `security_group_id`: Security group ID for the instance.
- `tags`: Tags to assign to the instance.
- `key_name`: Name of the key pair for SSH access.
- `cloudwatch_config_ssm_key`: SSM key for CloudWatch configuration.

**Outputs**:
- `instance_id`: ID of the created EC2 instance.
- `public_ip`: Public IP address of the instance.
- `public_dns`: Public DNS name of the instance.

![ec2-first](https://github.com/user-attachments/assets/8f26f5ae-3e73-41ad-a537-27f0b60e716f)
![ec2-sec](https://github.com/user-attachments/assets/7e9c25cb-d1ff-4b84-a17e-b32e9e08065d)
![ec2-thi](https://github.com/user-attachments/assets/d38162a9-9667-43f2-89ae-b26224e2654e)
![ec2-var-1](https://github.com/user-attachments/assets/555ec2b7-9355-442c-ac3d-78ca2dcd089e)
![ec2-var-2](https://github.com/user-attachments/assets/76221cf2-bf43-4dfd-94b6-13a65e45781d)


<img width="817" alt="ec2-xx" src="https://github.com/user-attachments/assets/a617ea0d-6e7b-4779-b62a-38abd38d6969" />

<img width="733" alt="ec222" src="https://github.com/user-attachments/assets/bb6d079f-c6e3-4106-a8fd-efb99ffd6a05" />

### CloudWatch Module (`modules/cloudwatch`)

├── [**CloudWatch**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/cloudwatch):
<br />
**Purpose**: Sets up CloudWatch log group and log stream for monitoring.

**Resources**:
- `aws_cloudwatch_log_group`: Creates a CloudWatch log group.
- `aws_cloudwatch_log_stream`: Creates a log stream within the log group.
- `aws_ssm_parameter`: Stores CloudWatch agent configuration in SSM Parameter Store.

**Inputs**:
- `log_group_name`: Name of the log group.
- `log_stream_name`: Name of the log stream.
- `cloudwatch_config_ssm_key`: SSM key for the CloudWatch agent configuration.

![cloud-watch-1](https://github.com/user-attachments/assets/f67c96a5-f783-4611-925d-1ed3ed02fcd0)
![cloud-watch-2](https://github.com/user-attachments/assets/23c58de0-e00f-4af2-bf23-7b2b31625d5f)
![cloud-watch-var](https://github.com/user-attachments/assets/e5abd241-1b55-4eca-9252-51d19f0ebfc3)


### SNS Module (`modules/sns`)

├── [**SNS**](https://github.com/wolf452/CloudDevOpsProject/tree/main/terraform/modules/sns):
<br />
**Purpose**: Sets up an SNS topic for notifications.

**Resources**:
- `aws_sns_topic`: Creates an SNS topic.
- `aws_sns_topic_subscription`: Subscribes an endpoint (e.g., email) to the topic.

**Inputs**:
- `sns_topic_name`: Name of the SNS topic.
- `subscription_protocol`: Protocol for the subscription (e.g., email).
- `subscription_endpoint`: Endpoint for the subscription (e.g., email address).

**Outputs**:
- `sns_topic_arn`: ARN of the created SNS topic.

![sns-a](https://github.com/user-attachments/assets/d97ab675-12d0-4bba-9960-b3d2aca51560)
![sns-b](https://github.com/user-attachments/assets/ca35c78e-6818-4465-b907-28e4b790bf76)
![sns-c](https://github.com/user-attachments/assets/701c272a-6a6f-4fa4-aec6-62f189276afc)



<img width="812" alt="sns" src="https://github.com/user-attachments/assets/ee837ccf-86e2-4918-bfe2-0915f217838e" />

# Main.tf
├── [**main.tf**](https://github.com/wolf452/CloudDevOpsProject/blob/main/terraform/main.tf):
## File Contents
### 1. AWS Provider 
This block defines the AWS provider and sets the region where the resources will be deployed using the region variable.

![1-ma](https://github.com/user-attachments/assets/41f93a5d-ff00-40d4-81d5-7bee7392834e)

### 2. vpc Module
This module creates a VPC using the vpc_name and vpc_cidr variables to define the name and CIDR block of the VPC.

![2-ma](https://github.com/user-attachments/assets/fea76ed0-abd0-4b69-bd6d-c09529d26aa5)


### 3. subnet Module
This module creates subnets within the VPC that was created earlier. It takes the vpc_id from the vpc module output and passes the subnet data from the subnets variable.

![3-ma](https://github.com/user-attachments/assets/b67521d4-96b8-4c0b-a229-a2713e09ac24)


### 4. internet_gateway Module
This module creates an Internet Gateway and attaches it to the public subnets created earlier.

![igw](https://github.com/user-attachments/assets/ffb3283d-1610-48a2-a2d5-e324bc40f6e0)


### 5. security_group Module
This module creates a Security Group using the rules defined in the security_group_rules variable and associates it with the VPC.

![sg-m](https://github.com/user-attachments/assets/e21433ec-33bf-4b78-8b0c-be8dc304f3bb)


### 6. ec2_instance Module
This module creates an EC2 instance with the AMI specified in ami_id, the instance_type, and places it in the public subnet. CloudWatch and SSM configurations are also set up.

![ec2-main](https://github.com/user-attachments/assets/1117e69b-5310-48e3-8bc3-d9952eb37626)


### 7. cloudwatch Module
This module creates a CloudWatch Log Group and sets up a Log Stream to monitor logs for the EC2 instance.

![cloudwatch-main](https://github.com/user-attachments/assets/4ce14441-4989-44fc-ade5-e6c76362922a)


### 8. sns Module
This module creates an SNS Topic and sets up a subscription using the protocol defined in the sns_subscription_protocol variable (such as email, Lambda, or SQS).

![ldf](https://github.com/user-attachments/assets/359920d3-7bf4-498a-9a3f-48e2c6205280)


# output.tf
├── [**output.tf**](https://github.com/wolf452/CloudDevOpsProject/blob/main/terraform/output.tf): 

## file content
These outputs are displayed after running the terraform apply command. They contain the EC2 instance ID, public IP, and public DNS. 

![root-out](https://github.com/user-attachments/assets/e02e1ca2-b2d9-472d-80e0-d91048bebd53)


# backend.tf

├── [**backend.tf**](https://github.com/wolf452/CloudDevOpsProject/blob/main/terraform/backend.tf): 

## file content
### 1. Backend Configuration
This block configures the backend to store the Terraform state in an S3 bucket, ensuring that the state is stored centrally and securely. Encryption is enabled for the data.

![s3-](https://github.com/user-attachments/assets/fa726688-b933-424e-a8e8-2c8c2a4eaf3d)


### 2. DynamoDB Configuration for State Locking
This resource creates a DynamoDB table for state locking to prevent concurrent changes to the state.

![dynamo](https://github.com/user-attachments/assets/6e052516-0e83-4a16-9969-aeecf58b98b0)


# Terraform Variables
## File Contents

### 1. AWS Region
This variable sets the AWS region where resources will be created. In this case, the region is us-east-1.
### 2. S3 Bucket and DynamoDB Table for Terraform State
These variables define the S3 bucket name and DynamoDB table for storing the Terraform state and enabling state locking.
### 3. VPC Configuration
These variables define the name and CIDR block for the Virtual Private Cloud (VPC) to be created.
### 4. Subnets
This variable defines two subnets within the VPC. Each subnet is assigned a CIDR block and availability zone. Public IP addresses will be mapped to instances on launch.
![image](https://github.com/user-attachments/assets/d12c4e80-6b13-437d-83ee-2e556914d18f)


### 5. Security Group Rules
This variable defines two security group rules:
SSH (port 22) access from anywhere (0.0.0.0/0).
HTTP (port 80) access from anywhere (0.0.0.0/0).

![defintion2](https://github.com/user-attachments/assets/fa37b369-03f5-4820-aa23-bf1a816d790e)


### 6. EC2 Instance Configuration
These variables define the AMI ID, instance type, key pair, and instance name for the EC2 instance to be created. The instance will be launched using the specified AMI (ami-0e2c8caa4b6378d8c).

![defition-3](https://github.com/user-attachments/assets/49642e52-e442-4e97-948e-fb25f280dbf8)


### 7. CloudWatch Configuration
These variables define the CloudWatch Log Group, Log Stream, and the SSM key used for the CloudWatch agent configuration.
### 8. SNS Topic and Subscription
These variables define the SNS Topic name and the subscription settings. The subscription protocol is set to email, and the email endpoint is ahmed.software200@gmail.com.

![defition4](https://github.com/user-attachments/assets/397c4af7-89da-4280-9522-c6e24bd69420)




## Usage

1. Clone this repository.
2. Modify `terraform.tfvars` with your specific configurations.
3. Initialize the Terraform project:

   ```bash
   terraform init
   ```
![terraform-init](https://github.com/user-attachments/assets/4d0d835a-491a-4da9-8dba-c0b872329e25)

4. Validate the configuration:

   ```bash
   terraform validate
   ```
![terraform-val](https://github.com/user-attachments/assets/a11842d8-0b32-4640-b549-95fd9238c6b9)

5. Apply the changes:

   ```bash
   terraform apply
   ```
![terraform-apply](https://github.com/user-attachments/assets/97e22160-d36a-4288-815f-9fd0596dce98)

6. Destroy resources when no longer needed:

   ```bash
   terraform destroy
   ```

## Notes

- Ensure your AWS credentials are configured correctly before running Terraform commands.
- Monitor resources in the AWS Management Console to verify successful deployment.
