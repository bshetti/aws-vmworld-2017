# Templates for VMworld 2017 Demo App on AWS

_Software required to use these templates:_ Ansible, Ansible EC2 dynamic inventory script (included in repository), Terraform

## Limitations

* You'll need to ensure the correct AMIs are available in the region where you want to turn up the application. Currently the AMIs are available in us-west-1 and us-east-1 only.

## Instructions for Use

1. Clone this repository to your local system.

2. Create a file named `terraform.tfvars` in the repository (don't worry, Git will ignore it) and populate it with values for the following variables:

    akey (your AWS access key)
    skey (your AWS secret access key)
    awsregion (the AWS region to use; currently, only us-west-1 or us-east-1)
    keypair (the name of an AWS SSH keypair to inject into instances)
    vpcname (the name you'd like assigned to the new VPC)
    cidr (the network block _without_ subnet mask)

3. Run `terraform validate` to ensure there are no errors in the Terraform configuration. If any errors are reported, fix them before proceeding.

4. Run `terraform plan` to evaluate the current infrastructure and prepare a plan for creating the desired configuration.

5. Run `terraform apply` to create the desired infrastructure.

6. Few steps prior to configuring the new instances:

-Obtain the VPC ID from the terraform state file (look for vpc id in the file).  
-Add the line `instance_filters = vpc-id=<value>` to the `hosts/ec2.ini` file. This allows the env to only see that VPC.
-in `ec2.ini`, change the `cache_path` line to remove the `~/` from the beginning of the path. This will ensure a unique cache for each environment
-in the `ansible.cfg` file, there is a reference to the SSH private key it should use. Change this to match the SSH keypair you’re injecting into the instances.


7. When Terraform is completed, wait a couple of minutes and then run `hosts/ec2.py --refresh-cache` to refresh the dynamic Ansible inventory.

8. Run `ansible-playbook configure.yml` to configure the EC2 instances with the dynamically-assigned IP addresses.

9. Restart services:

    * Restart HAProxy on the Web tier instances.
    * Restart Django on the App tier instances.
    * Restart HAProxy on the DB Load Balancer instance.

You should be ready to go!

## Using Regions Other than US-East-1

In the file `testvpc.tf` there is a section that looks like this:

```
variable "images" {
  type = "map"
  default = {
    web="ami-a7b886b1"
    mngt="ami-dfb886c9"
    db="ami-1dbb850b"
    dblb="ami-71bd8367"
    app="ami-75bd8363"
  }
}
```

The AMI IDs currently in `testvpc.tf` are for US-East-1; if you want to use a different region, copy the AMIs to that region and adjust the AMI IDs in this section accordingly.

## Running Multiple Instances

To run multiple instances of this application, make multiple copies of this repository and follow the instructions for each.

## Destroying the Infrastructure

Simply run `terraform destroy` to tear down the AWS infrastructure.
