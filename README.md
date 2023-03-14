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

1. Terraform (Preferably version  v1.3.9 or higher)
2. Ansible (version [core 2.14.3] or higher)
3. AWS Account

# Installation and Implimentation
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


# Considerations:

1. Monitoring and maintenance:
For monitoring, Datadog would be used. 
Datadog is a powerful SaaS-based infrastructure monitoring service with multiple integrations. It would enable the DevOps team to keep tabs on the cloud environment to visualize the health of your infrastructure. This is not just limited to the Cloud resources created by this project but could help monitor other resources already created in this cloud environment.

Reasons for choosing Datadog:

* Datadog has monitors to notify appropriate individuals once critical alerts are triggered.
* It is open-source, meaning it’s easy to dig into the code and understand how it collects metrics

2. Capacity and growth:

In order to accomodate growth of the application, the Terraform can help largely in scaling up and scaling down cloud resources.

* Scaling EC2 instances: To address the increased load as your application's consumption increases, you might need to add extra EC2 instances. An auto-scaling group that automatically adds or removes EC2 instances based on metrics like CPU consumption or network traffic can be defined using Terraform.

* Updating EC2 instances: Your application's size and performance needs may change over time. To handle increasing traffic, Terraform may assist you in upgrading your EC2 instances to bigger, more capable ones.

* Handling databases: You might need to add or remove databases as your application expands in order to accommodate the growing amount of data. As well as setting up database backups and replicas, Terraform can help you provision and manage databases like Amazon RDS instances or DynamoDB tables.

* Adding or removing load balancers to spread traffic across different instances may be necessary as traffic to the EC2 instances grows. Load balancers can be provisioned and maintained with Terraform, as well as health checks.

# Non-automated tasks

1. SSL certificates: Due to the requirements and personalizations while generating and mapping ssl certificates to the nginx web server, i decided to ssh into the instance with the ip address generated after terraform creates the EC2. The IP address can be found after terraform apply in the ip_address.txt file.

2. Deployment: I am very familiar with using CI/CD tools for integration and deployments, however, i was unable to integrate the CI/CD pipeline from Github    actions because of the time constraints for submitting this project. 

   If i were tasked to do this, i would create a pipeline from the repository of the application, connect it to the EC2 that terraform creates and the make use of pipeline yaml scripts to handle deployments on every push or merge from the required branch.

   To solve this issue in a timely manner, i have simply made use of a bash script to clone the repository code and run all build and startup commands for the application.

3. Creation of DNS: Due to the assumption of working with a production environment, also, cost of buying a new domain name, I made use of an existing domain name that i have just for the use of this project. The DNS name was shared on the email for submitting this project.

# Credits 

This repository was created by Jesse Ejegi-memeh as part of DevOps Test project. Feel free to use and modify the code as necessary. If you have any questions or suggestions, please don't hesitate to get in touch.

