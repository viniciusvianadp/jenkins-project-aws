# Basic Jenkins Project

## Description

This project demonstrates the usage of AWS, Terraform, and Jenkins to provision infrastructure.

To run Jenkins, we setup an EC2 instance in AWS (vpc, subnet, internet gateway, security group and route table are included).
This sample project contains an AWS infrastructure project in the src directory, from which the infrastructure generated using Jenkins is fetched. 
Said infrastructure project, for this project, is also an configuration for an EC2 instance in AWS, but could be adapted for any possible AWS infrastructure.

## Prerequisites

Before getting started, the following is required:

- An AWS account with appropriate permissions
- Terraform installed on local machine
- Jenkins installed and configured

Additionally, the following resources need to be created beforehand:

- S3 bucket: used inside the sample project that is configured using Jenkins (src project)
- EC2 key pair: used for connection with the Jenkins EC2 instance (and the src project EC2)

There are variables to indicate the correct names and/or paths for the needed resources.
You might also need to adjust the instance ami accordingly.

## Getting Started

To get started with this project:

 1. Clone the repository
 2. Navigate to the project directory
 3. Update the `variables.tf` file with your desired configurations.
 4. Set the name to your EC2 key pair in both `variables.tf` files, and the correct path (including the key) using the key_pair_path variable in the file on the main directory.
 5. Set the created S3 name and region for the remote state storage in the `main.tf` file, inside the src directory.
 6. Run `terraform init` to initialize the Terraform configuration.
 7. Run `terraform plan` to review the planned infrastructure changes.
 8. Run `terraform apply` to provision the infrastructure.
 9. Adjust the Jenkinsfile with your gitUrl.  
10. Access Jenkins (port 8080) and configure the pipeline using the Jenkinsfile.
11. Set the correct credentials to be able to execute the pipeline in AWS. Used credentials: AWS_ACCES_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION, AWS_BUCKET, AWS_BUCKET_KEY

## Configuration

The project can be configured by modifying the variables in the `variables.tf` file. Some of the key variables include:

- `aws_region`: The AWS region where the infrastructure will be provisioned.
- `instance_type`: The EC2 instance type to be used.
- `key_pair_path`: The path to the EC2 key pair file.

## Diagram

![image](https://github.com/viniciusvianadp/jenkins-project-aws/assets/86125479/89861f7e-0f76-48cc-aa4e-a77200340eef)

