# DevOps-Test
This repository includes code for a production ready web application server environment, it includes files for Automating infrastructure provisioning and configuration management.

# This repository contains:
1. A terraform main.tf file which has all the resources that would be created by terraform defined.

2. An ip_address.txt file in which terraform writes the IP address of the EC2 instance created into, this would help to easily extract the ip in the document directory, if there is a need to ssh into the EC2 immediately after the resources are created.

3. An nginx.yml file which is the Ansible playbook that would be used to configure the web server on the instance when it is created.

4. A default file which is an Nginx file that has all the necessary configurations for Nginx to run the application and redirect traffic from port 443 to  3000, all that would be needed on the server are just ssl credentials.

5. A shell scrip "script.sh" which initiates a git repository in a particular branch and clones the application repository into a directory on the EC2 instance, it also installs app dependencies and starts the application in the backgroud, replaces the nginx default file and runs on EC2 creation. 

# Requirements
Before running the application, ensure you have the following installed:

Terraform (Preferably version  v1.3.9 or higher)
Ansible (version [core 2.14.3] or higher)

# Installation
1. Clone the repository:
        git clone https://github.com/Ejegz/DevOps-Test.git

2. Initialize the working directory: 
        Navigate to the directory where your configuration file is located and run the command 
                                              "terraform init" 
in your terminal or command prompt. This will download the required Terraform providers and modules for your project.

3. Plan your changes: 
        Run the command 
                        "terraform plan" 
        to generate an execution plan for the changes you want to make. This will show you a preview of the resources that Terraform will create, modify, or delete based on your configuration file.

4. Apply the changes: 
        Run the command 
                        "terraform apply"
 to apply the changes to your infrastructure. Terraform will create, modify, or delete the resources specified in your configuration file.
        To avoid unwanted prompts, use the command
                        "terraform apply -auto-approve"

5. Destroy the resources: 
        If you want to delete the resources created by your Terraform project, you can run the command 
                        "terraform destroy"
This will remove all the resources created by your configuration file.


