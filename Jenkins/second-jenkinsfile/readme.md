# Continuous Integration with Jenkins

## Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Steps to Implement](#steps-to-implement)
    - [Step 1: Configure the Jenkinsfile](#step-1-configure-the-jenkinsfile)
    - [Step 2: Create the Shared Jenkins Library](#step-2-create-the-shared-jenkins-library)
    - [Step 3: Set Up Jenkins Slave](#step-3-set-up-jenkins-slave)
    - [Step 4: Test and Execute the Pipeline](#step-4-test-and-execute-the-pipeline)
4. [Troubleshooting](#troubleshooting)
5. [Conclusion](#conclusion)

---

## Overview
This section details how to set up a Jenkins pipeline for continuous integration (CI) using a Jenkinsfile and a shared library. The pipeline includes the following stages:
- **Git Checkout**
- **Unit Test**
- **Build JAR**
- **SonarQube Test**
- **Build Image**
- **Push Image to Registry**
- **Deploy on k8s**

The implementation utilizes:
- Shared Jenkins Library for reusable pipeline logic.
- Jenkins slave to execute builds and tests.

---

## Prerequisites
- Jenkins server with master and slave nodes configured.
- Docker, Kubernetes CLI, and SonarQube installed on the Jenkins slave.
- A Git repository to store the Jenkinsfile and shared library.
- k8s cluster set up and accessible from Jenkins.
- SonarQube server configured with a project and token.
- Credentials for Docker Registry, Git, and SonarQube added to Jenkins.

---

## Steps to Implement

### Step 1: Configure the Jenkinsfile
1. Create a `Jenkinsfile` in the root of your repository.
2. Define the pipeline stages:
   - Git Checkout
   - Unit Test
   - Build JAR
   - SonarQube Test
   - Build Image
   - Push Image to Registry
   - Deploy on k8s
3. Reference the shared library functions for each stage.
4. Validate the syntax of the Jenkinsfile using Jenkins' pipeline syntax validator.
5. Commit the `Jenkinsfile` to your repository.
6. **Validation Step:** screenshot of the pipeline running in Jenkins and all stages passing.


![image](https://github.com/user-attachments/assets/2307b055-7025-47b6-a97d-90b63f968ee2)

### Step 2: Create the Shared Jenkins Library
1. Create a folder structure as shown:
   ```
   shared-library/
       vars/
           buildAndTest.groovy
           checkoutPipeline.groovy
           deployToKubernetes.groovy
           dockerTasks.groovy
           sonarQubeAnalysis.groovy
   ```
2. Add Groovy scripts for each function:
   - `checkoutPipeline.groovy`: Handles Git checkout.
   - `buildAndTest.groovy`: Executes unit tests and builds the JAR.
   - `sonarQubeAnalysis.groovy`: Performs SonarQube analysis.
   - `dockerTasks.groovy`: Builds and pushes Docker images.
   - `deployToKubernetes.groovy`: Deploys the application to k8s.
3. Commit the shared library to the repository.
4. Add the shared library to Jenkins by navigating to **Manage Jenkins > Configure System > Global Pipeline Libraries** and defining the library name and repository URL.
5. **Validation Step:**  screenshot of the shared library configuration in Jenkins.

   
![image](https://github.com/user-attachments/assets/b54a633a-a462-4dc7-add1-6ff84092f01b)

### Step 3: Set Up Jenkins Slave
1. Configure a Jenkins slave node with:
   - Docker and Kubernetes CLI installed.
   - SonarQube scanner.
2. Link the slave to the Jenkins master.
3. Verify the slave is active in Jenkins.
4. **Validation Step:** screenshot of the Jenkins slave node configuration and its status as "Online."

![edit-jenkins-slave](https://github.com/user-attachments/assets/48d7cf60-4e14-46f8-8620-ff6fa220a975)

![sssss](https://github.com/user-attachments/assets/d96f4bd1-1af0-417b-8638-d76cbb92ea59)


### Step 4: Configure SonarQube in Jenkins
1. Install the **SonarQube Scanner** plugin in Jenkins.
2. Navigate to **Manage Jenkins > Configure System > SonarQube Servers** and add the SonarQube server details and authentication token.
3. Configure the SonarQube scanner executable in **Manage Jenkins > Global Tool Configuration.**
4. Ensure the `sonarQubeAnalysis.groovy` script references the correct SonarQube project key.
5. **Validation Step:** screenshot of the SonarQube project configuration and analysis result in Jenkins.
![home-sonar](https://github.com/user-attachments/assets/087009b3-9c82-4522-9427-6991a06bee7f)

![create-project](https://github.com/user-attachments/assets/0ed3aedf-b3a7-45cc-8cdd-57afd2e30ecc)

![create-token](https://github.com/user-attachments/assets/eaca1ff0-a3bc-493b-a14c-8cf7ce0c9bd6)
![home-token](https://github.com/user-attachments/assets/e8b6768f-a4fa-496f-bd5d-14d9ba47bd99)




### Step 5: Test and Execute the Pipeline
1. Open the Jenkins dashboard.
2. Create a new pipeline project and link it to your Git repository.
3. Execute the pipeline and monitor the stages.
4. Verify that each stage completes successfully:
   - Code is checked out.
   - Unit tests pass.
   - JAR is built.
   - SonarQube analysis runs without issues.
   - Docker image is built and pushed.
   - Application is deployed to k8s.
5. **Validation Step:**  screenshots of:
   - Last build from Jenkins pipeline.
![1-out](https://github.com/user-attachments/assets/7f4eb326-c5d1-49d7-8eda-64a34c9d7dea)
![test-out](https://github.com/user-attachments/assets/a66d976f-08f8-43ac-8e00-611a35a3827b)

![build-out](https://github.com/user-attachments/assets/0a863ec4-95bd-4651-8035-11540fe72661)
![sonar-out](https://github.com/user-attachments/assets/b2090c4b-2b9d-4e39-b628-955e7bf831ae)
![login-dockerhup](https://github.com/user-attachments/assets/2abcc8f0-b90c-420d-b625-826bf1ef985a)
![finish](https://github.com/user-attachments/assets/b3e86e0b-87e3-49f0-915e-0fccfa714658)
![build-image](https://github.com/user-attachments/assets/64cc2fc4-d275-4d87-aad4-7413e97045ab)
![Capture](https://github.com/user-attachments/assets/4593743c-e27b-4649-9c0a-21802c13a7aa)
![Capture PNG2](https://github.com/user-attachments/assets/26337d74-b018-4a8c-8b1a-c11e205eaffd)
![Capture PNG3](https://github.com/user-attachments/assets/a133e859-c14f-45a7-b19f-1ac4c92f20e1)

# Application is deployed to k8s
### Exposing the Application with Ngrok
Since the application is deployed on Kubernetes without public IPs, `ngrok` is used to create a public URL for accessing the application. The process involves the following steps:

1. **Port Forwarding**:  
   Use the following command to forward a Kubernetes pod's port to your local machine:  
   ```bash
   kubectl port-forward <pod-name> <local-port>:<pod-port>
   ```
   Replace `<pod-name>`, `<local-port>`, and `<pod-port>` with the appropriate values.

2. **Run Ngrok**:  
   Start an ngrok session to expose the forwarded port:  
   ```bash
   ngrok http <local-port>
   ```

3. **Access the Application**:  
   Copy the public URL generated by ngrok (e.g., `https://<generated-id>.ngrok.io`) and use it to access your application.
.![get-pod](https://github.com/user-attachments/assets/d2cbcae6-cdcb-49c8-ac91-e301ab5d9515)


![port-forward](https://github.com/user-attachments/assets/837c072e-f92a-4241-998a-e363aaaafca6)
![nro-hhtp](https://github.com/user-attachments/assets/bd536296-655d-4740-b0d2-3c5a77c3a81d)
![file-ngrok](https://github.com/user-attachments/assets/ff2e2bb4-1134-44a4-9645-1227312d6519)
![finish](https://github.com/user-attachments/assets/c00b9c11-3ed1-4f0d-abc9-83cabe341ea2)
