## Description
In this repo, we are creating the resources for a document-handler API. The resources created are as below

- Lambda function
- S3 bucket
- RDS instance
- IAM roles and policies
- Secrets
- Security Group
- API Gateway components

# Assumptions

- The VPC in the AWS account is not being created in this repo and can be bootstrapped here either as a variable or if it was created via terraform, then the remote state can be referenced here and the VPC ID fetched.
- The AWS account is a dummy value and this code cannot be applied as it is.
- The role the AWS provider assumes does not exist and would have to be created for Terraform to be able to create the resources
- The Python code itself does not exist and must be part of the repo for the functioning of the lambda function.

# Improvements

- Terraform workspaces are used and each workspace can have its own .tfvars file to hold variables
- The RDS instance can be multi-AZ for prod and non multi-AZ for lower environments, also saving cost
- This code can be run in a pipeline with multiple stages of a terraform plan, apply for various environments.
- An s3 backend can be used to store the statefile with a dynamo DB lock


