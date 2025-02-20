
# Iaac-Ansible Project

This project automates the creation and configuration of an infrastructure using Terraform and Ansible, integrated with Jenkins pipelines. Below is a detailed explanation of each component and its purpose.

![ans](https://github.com/user-attachments/assets/1bc5c5b3-bc8e-418a-bd4d-b9e0b0574686)

## Project Overview

1. **Infrastructure as Code (IaC):** Uses Terraform to define and provision AWS infrastructure.
2. **Configuration Management:** Uses Ansible to configure the provisioned EC2 instances.
3. **CI/CD Pipeline:** Jenkins orchestrates the Terraform and Ansible processes in a streamlined pipeline.

---

## Prerequisites

- **Tools and Platforms:**

  - Jenkins
  - Terraform
  - Ansible
  - AWS Account
  - Git

- **Credentials:**

  - AWS Access Key and Secret Key stored securely in Jenkins.

![cred](https://github.com/user-attachments/assets/51c04a9b-a61d-4873-a605-1f393be165ba)

- **Environment:**

  - Jenkins server set up with the necessary plugins for Terraform and Ansible.
  - A Git repository containing the Terraform and Ansible configurations.

---

## Pipeline Explanation

### Jenkinsfile

```groovy
@Library('shared-library') _

pipeline {
    agent any

    environment {
        TERRAFORM_DIR = 'terraform'
        BACKEND_DIR = 'terraform'
        ANSIBLE_DIR = 'ansible'
        INVENTORY_FILE = 'inventory'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/wolf452/CloudDevOpsProject.git'
            }
        }

        stage('Terraform Init') {
            steps {
                terraformInit()
            }
        }

        stage('Terraform Plan') {
            steps {
                terraformPlan()
            }
        }

        stage('Terraform Apply') {
            steps {
                terraformApply()
            }
        }

        stage('Delay Before Ansible Playbook') {
            steps {
                delayBeforeAnsible()
            }
        }

        stage('Run Ansible') {
            steps {
                runAnsible()
            }
        }
    }
}
```

### Pipeline Stages

1. **Checkout:** Clones the Git repository containing the Terraform and Ansible code.
2. **Terraform Init:** Initializes Terraform with the backend and provider configurations.
3. **Terraform Plan:** Creates a plan for the desired infrastructure changes.
4. **Terraform Apply:** Applies the Terraform plan to provision AWS resources, including EC2 instances.
5. **Delay Before Ansible Playbook:** Ensures provisioned resources are ready before proceeding.
6. **Run Ansible:** Executes the Ansible playbook to configure the provisioned EC2 instances.

---

## Terraform

### Directory Structure

```
terraform/
|-- main.tf
|-- variables.tf
|-- outputs.tf
|-- backend.tf
```

### Key Features

- **AWS VPC**
- **Subnets**
- **Security Groups**
- **EC2 Instances**
- **Ansible Inventory Generation:** Terraform creates an `inventory` file with the IPs and users for Ansible.

### Commands

```sh
terraform init
terraform plan
terraform apply -auto-approve
```
![1-out](https://github.com/user-attachments/assets/b9eaff24-8d47-4a49-9a1b-8a3dcbe32f33)
![init-terr-out](https://github.com/user-attachments/assets/ccff2531-d718-4915-8f8c-5068c3cefd74)
![plan-terr-2](https://github.com/user-attachments/assets/3628441f-c520-4a9c-866f-bc514ba20fb6)
![apply-terr-3](https://github.com/user-attachments/assets/78066505-7660-47fb-940c-2c3e0596e8e3)

---

## Ansible

### Directory Structure

```
ansible/
|-- playbook.yml
|-- roles/
    |-- git/
    |-- docker/
    |-- java/
    |-- jenkins/
    |-- sonarqube/
    |-- kubernetes/
```

### Playbook Breakdown

1. **Install Git:** Installs Git on the EC2 instance.
2. **Install Docker:** Sets up Docker and adds the user to the Docker group.
3. **Install Java:** Installs OpenJDK 17.
4. **Install Jenkins:** Configures Jenkins and starts its service.
5. **Install SonarQube:** Configures SonarQube along with PostgreSQL as its backend.
6. **Install Kubernetes Tools:** Installs `kubectl` and `kind`.

### Running the Playbook

The playbook is executed by Jenkins with the following command:

```sh
ansible-playbook playbook.yml -i inventory --private-key /path/to/key -u ansible-user
```
![ansible-1](https://github.com/user-attachments/assets/bcd32798-8236-4f1f-8470-4d7a7329390f)

---

## Sample Output

### Terraform Output

```
Terraform has been successfully initialized!
Terraform Plan:
  - Create EC2 instances
  - Configure Security Groups
  - Generate Ansible inventory

Terraform Apply:
  - Resources created successfully
```

### Ansible Output

```
TASK [Gathering Facts] *********************************************************
ok: [18.204.194.253]
...
TASK [sonarqube : Start Sonar] *************************************************
changed: [18.204.194.253]

PLAY RECAP *********************************************************************
18.204.194.253             : ok=48   changed=31   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---
![ansible-1](https://github.com/user-attachments/assets/3be22327-389b-46e0-b532-c9f3a92d3993)
![ansible-2](https://github.com/user-attachments/assets/8c72c697-811c-48a8-8404-766234a1b1c0)
![ansible-3](https://github.com/user-attachments/assets/adc8bb55-b04c-46ae-92e5-6d7bb0973634)
![ansible-4](https://github.com/user-attachments/assets/3e03a204-e8f1-4387-91c8-2ce6eb9bce49)

## Conclusion

This project demonstrates the integration of Terraform and Ansible through Jenkins pipelines to provision and configure infrastructure. It ensures a streamlined and automated approach to infrastructure management.

Feel free to reach out for additional support or enhancements!
