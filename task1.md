# Question: 

Currently, we have a single VPC with develop/production resources intermixed in the AWS Ireland region. We want to move to better-separated environments. How would you design, plan and execute the change?

## Plan

  - The 2 environments would stay in 2 different AWS accounts, hence creating 2 AWS accounts, also probably creating an AWS organization and making the 2 AWS accounts part of it, as managing them becomes streamlined.
  - Ideally having one more AWS account, which acts as a Master, which can be used to manage the users and groups. Users are created in this account and assigned to groups and then assigned policies to these groups, which can have role assumption permissions in the other accounts.
  - I would create a terraform module or use an upstream terraform module to create a new VPC, private and public subnets, nat gateways, internet gateways, route tables and security groups. I would set up my terraform provider to authenticate to AWS. I would create 2 workspaces in terraform, one for prod and the other for development.
  - Once my terraform code is ready, I would run that against the development account and create all the resources, and resources around the EC2 instances or servers.
  - I would modify my pipelines, in order to start deploying the applications to this new dev environment.
  - Once applications are deployed, testing can be done on the functionality of the applications.
  - As the testing completes and we are confident with the new dev environment, I would switch the DNS entries to point to the dev load balancers.
  - After the switch is made, I will monitor for a few days.
  - I would follow a similar route for the application in production, just moving them to the newly created AWS account via terraform, testing them and then switching the traffic.
  - The last step would be to destroy the old dev/prod environment, and even suspend the AWS account if needed