 # Ansible Playbook for Setting Up Kubernetes, Docker, Jenkins, SonarQube, and Dependencies

This project contains an **Ansible Playbook** to install and configure the following tools on **Ubuntu EC2 Instances**:
- **Kubernetes** (kubectl, kind)
- **Docker**
- **Jenkins**
- **SonarQube**
- **Java OpenJDK 17**
- **PostgreSQL** (for SonarQube)
- **Other dependencies** such as package updates and permission setups
## Ansible Structure

```.
├── ahmed.pem
├── inventory
├── playbook.yml
└── roles
    ├── common
    │   └── tasks
    │       └── main.yml
    ├── dependance
    │   └── tasks
    │       └── main.yaml
    ├── docker
    │   └── tasks
    │       └── main.yml
    ├── git
    │   └── tasks
    │       └── main.yml
    ├── java
    │   └── tasks
    │       └── main.yml
    ├── jenkins
    │   └── tasks
    │       └── main.yml
    ├── Kubernetes
    │   └── tasks
    │       └── main.yaml
    └── sonarqube
        ├── handlers
        │   └── main.yml
        ├── tasks
        │   └── main.yaml
        └── vars
            └── main.yml
```



## Requirements

- **Ansible** version 2.x or higher
- **Ubuntu EC2 Servers** (slave nodes) with SSH access
- **Root privileges** on the target servers
- The following tools should be available:
  - **Git**
  - **Docker**
  - **Kubernetes** (kubectl, kind)
  - **Java OpenJDK 17**
  - **Jenkins**
  - **SonarQube**

## Setup Steps

### 1. Clone the Repository

Clone this repository to your local machine or the server where **Ansible** is installed:

```bash
git clone <repository_link>
cd <repository_folder>
```
![clone](https://github.com/user-attachments/assets/4464b4f5-d8c7-44da-bba7-4f5f4602a78b)

### 2. Configure the Inventory File
In the inventory file, define the target EC2 nodes under the [slave] group like this:
```bash
[slave]
your_ec2_instance_ip ansible_ssh_user=ubuntu ansible_private-key=./ivolve.pem
```
![inventory](https://github.com/user-attachments/assets/1ceea175-5339-4b6e-b2e4-b322c270cc94)

### 3. Configure the playbook.yaml File
To configure your playbook.yml file, you'll need to structure it in such a way that it pulls in the relevant roles and defines the host group for deployment. Based on the list of roles you provided and the host group slave, here is an example configuration for your playbook.yml file:

![playbooke](https://github.com/user-attachments/assets/d3b217e7-5721-4ce9-a8e3-b991b3811dd5)

### 4. Configure roles 
 - vim roles/common: 
    - Package Updates: Updates system packages to ensure the system is running with the latest available versions.
    - Install Essential Packages: Installs tools like curl and wget to ensure the necessary utilities are available

![common](https://github.com/user-attachments/assets/663ec500-c2bb-46cf-b255-b88e0052f903)

- vim roles/dependance:
   - Sets up configuration directories for Jenkins.
   - Changes permissions for the Docker socket file.
   - Copies the kube configuration for Jenkins.

![dependence](https://github.com/user-attachments/assets/56f378af-eae8-4bda-bd92-927a9a8acc32)


- vim roles/docker:
   - Install Docker:
       - This role involves installing Docker from the official Docker repository.
       - Docker is a platform that enables building, shipping, and running applications in containers
       - Installing Docker ensures the server is prepared to manage containerized applications.
![docker](https://github.com/user-attachments/assets/ef51cb0b-0091-46af-a74a-41f26ba76080)


- vim roles/git:
   - Install Git:
       - Git is a distributed version control system crucial for developers to clone repositories, track code changes, and collaborate effectively.
       - This role ensures Git is installed on the target server for seamless version control.

![git](https://github.com/user-attachments/assets/2cbfe7ec-4142-4c6e-a55b-92943652be27)


- vim roles/jenkins:
   - Install Jenkins:
      - Jenkins, an open-source automation server, facilitates continuous integration and continuous delivery (CI/CD).
      - This role installs Jenkins on the server, enabling automated building, testing, and deployment of applications.

  -  Configure Jenkins to Run Automatically on Boot: 
         - To ensure uninterrupted service, Jenkins is configured to start automatically whenever the server restarts by enabling its service at boot.

![jenkins](https://github.com/user-attachments/assets/3520dcd7-3f9d-45c6-a3a8-ff126b64cd26)


- vim roles/Kubernetes:
   -   Install Kubernetes CLI Tools:
       - kubectl: A command-line tool to interact with Kubernetes clusters, essential for deploying, managing, and troubleshooting applications. 
       - kind (Kubernetes in Docker): A tool for running Kubernetes clusters locally using Docker, ideal for testing and development without a full cloud setup.
         - this role ensures the necessary Kubernetes CLI tools are installed, equipping the server to interact effectively with Kubernetes clusters.

![k8s](https://github.com/user-attachments/assets/86159a54-ea0b-492d-9007-ca83afc63da4)




- vim roles/ sonarqube
        - Installs PostgreSQL and configures it to work with SonarQube.
        - Installs SonarQube and configures it to use PostgreSQL as the database.
        - Sets up SonarQube as a systemd service to start automatically.
![son1](https://github.com/user-attachments/assets/e6d8cc8b-75d1-4bc9-b1cc-809b7ad1b8c9)

![son2](https://github.com/user-attachments/assets/50a039da-dd09-47d3-b533-a1ed2430f68a)

![so3](https://github.com/user-attachments/assets/c3cae790-3eda-48bd-9359-829ed93dc0cd)

- vim roles/java
    - Installs OpenJDK 17 to run Java-based applications.
![java](https://github.com/user-attachments/assets/becd0ce9-e589-47d1-89f6-e26bc84abbf1)

- vim roles/Dependencies
  - Create the 'jenkins' Directory
      - Purpose: Creates a directory named jenkins in /home/ubuntu, to be used as a workspace or configuration directory for a Jenkins slave.
    -  Details:
     - Ownership is set to the ubuntu user and group.
     - Permissions are set to 0755:
     - Owner: Full access (read, write, execute).
     - Group/Others: Read and execute access only.  

  - Change Permissions for /var/run/docker.sock
  - Create a Kind Cluster:
      - Purpose: Creates a Kubernetes cluster using Kind (Kubernetes IN Docker) to provide a lightweight, local Kubernetes environment for deploying applications.

  - Copy Kubernetes Config File
    - Purpose:
       - Copies the Kubernetes configuration file (config) from its default location (~/.kube/config) to the jenkins directory to enable the Jenkins slave to interact with the Kubernetes cluster.

![dependance](https://github.com/user-attachments/assets/32ffcdf0-93da-4280-9430-b77c5920f08f)

### 4. Update Variable Settings
In the ansible/roles/sonarqube/vars/main.yml file, modify the following variables to match your setup:

- postgres_root_user: The root PostgreSQL username
- postgres_root_pass: The root PostgreSQL password
- psql_sonar_username: PostgreSQL username for the SonarQube database
- psql_sonar_password: PostgreSQL password for the SonarQube database
- sonarqube_version: The version of SonarQube you want to install
- sonar_web_port: The port SonarQube will run on (default is 9000)

![image](https://github.com/user-attachments/assets/725b419c-6283-49bc-988c-51365418b5d1)

### 5. Run the Playbook
Run the Ansible playbook to install and configure the systems:

```bash
ansible-playbook -i inventory playbook
```
![1-install](https://github.com/user-attachments/assets/15e55770-0272-46ce-b329-1269aac23f6f)

![2-install](https://github.com/user-attachments/assets/c3570cfc-d28f-4d27-85af-ed53d6fb79f2)

![3-install](https://github.com/user-attachments/assets/78425735-c053-4077-a7f8-f42b21aa2a85)

![4-install](https://github.com/user-attachments/assets/103db178-08c4-48e5-b2d2-fbc72f2a76be)

![5-install](https://github.com/user-attachments/assets/b8c7c852-5210-4b24-bd47-6b0b36d21211)

![6-install](https://github.com/user-attachments/assets/ca23699b-149c-41ad-a31d-4f4e21ea47ca)

![7-install](https://github.com/user-attachments/assets/98db3fd0-bc2c-4d72-80b7-b0f8b9b40011)



The playbook will perform the following tasks:

:
- Install OpenJDK 17 for Java-based applications
- Install and configure Jenkins to run automatically
- Install SonarQube and configure it to use PostgreSQL as the database
- Install Kubernetes CLI tools like kubectl and kind
- Set up dependencies and required files for each service
![jenkins-slave](https://github.com/user-attachments/assets/5db2dd21-ccab-43b8-9099-6732357cdca8)
![sonar-service](https://github.com/user-attachments/assets/f484926a-ba43-4cb8-b4b1-aceed4e0103a)
![docker-service](https://github.com/user-attachments/assets/783b1dae-4d10-4b5e-849c-21def6804b5d)

### 5. Verify the Installation
After running the playbook, verify that the services are running correctly:

Jenkins
 - Open your browser and go to http://<your_ec2_instance_ip>:8080
 - Follow the instructions to complete the Jenkins setup.
SonarQube
- Open your browser and go to http://<your_ec2_instance_ip>:9000
- Default login credentials:
Username: admin
Password: admin
Kubernetes
- To verify kubectl installation, use the following command:
```bash
kubectl version --client
```
To verify kind installation, use the command:
```bash
kubectl version 
```
