# CloudDevOpsProject-2


## Overview
The CloudDevOpsProject is a comprehensive DevOps project that demonstrates skills in containerization, infrastructure provisioning, configuration management, and CI/CD pipelines. This project covers end-to-end tasks, from setting up a GitHub repository to deploying applications on OpenShift.

Additionally, it incorporates monitoring and observability using Prometheus for metrics collection and Grafana for data visualization. These tools provide real-time insights into application performance, resource usage, and system health, ensuring a reliable and scalable deployment.

---
![image](https://github.com/user-attachments/assets/25f2c383-9501-40d7-a783-2449774ce340)




## Containerization with Docker

### Task
- Develop a `Dockerfile` for building the application image.
- Source code: [FinalProjectCode](https://github.com/wolf452/CloudDevOpsProject/tree/main/FinalProjectCode-main).


---

## Infrastructure Provisioning with Terraform

### Task
- Deliver Terraform scripts to provision AWS resources:
  - VPC, Subnet, Security Groups.
  - EC2 instance for application deployment.
- Use Terraform Modules.


---

## AWS Integration

### Task
- Provide instructions to integrate AWS services:
  - Use S3 Terraform Backend for state management.
  - Integrate CloudWatch for monitoring.



## Configuration Management with Ansible

### Task

- Develop Ansible playbooks for EC2 instance configuration:
- Install required packages (Git, Docker, Java).
- Install packages for Jenkins and SonarQube.
- Install and configure Prometheus for monitoring.
- Install and configure Grafana for data visualization.
- Set up necessary environment variables.
- Use Ansible roles for modular and reusable automation.


---

## Continuous Integration with Jenkins

### Task
- Configure Jenkins pipeline in `Jenkinsfile` with the following stages:
  1. Git Checkout.
  2. Unit Test.
  3. Build JAR.
  4. SonarQube Test.
  5. Build Docker Image.
  6. Push Docker Image to Registry.
  7. Deploy on OpenShift.
- Utilize Shared Jenkins Library and Jenkins slave.


---

## Instructions for Execution

1. Clone the repository:
   ```bash
   git clone (https://github.com/wolf452/CloudDevOpsProject.git)
   ```

2. Build and run the Docker container:
   ```bash
   docker build -t application-image .
   docker run -d -p 8080:8080 application-image
   ```

3. Provision infrastructure with Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Configure EC2 instances with Ansible:
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```

5. Run the Jenkins pipeline for continuous integration and deployment.

---

# Done !!

