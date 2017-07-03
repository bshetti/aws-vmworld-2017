# aws-vmworld-2017
templates for vmworld 2017


README FOR testvpc.tf

Usage:
1)       Ensure the AMIs are in the right region
2)       Ensure you have your keys
3)       Ensure you have a directory for each VPC (I still haven’t figured out how to generate multiple stacks in the same directory)
4)       Note the following variables:
 
VPCNAME=name of the vpc you want to call it
awsregion = region you want the stack to be brought up in. (ensure the AMIs are in the same region)
akey=access key from AWS
skey=secret key from AWS
 
5)       In the file testvpc.tf there is a section
 
 
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
 
Adjust the ami ids as needed.
 
6)       Type the following commands
terraform plan -var 'VPCNAME=nextvpc' -var 'awsregion=us-east-1' -var 'akey=XXXXX' -var 'skey=XXXXXX'  ßensure it doesn’t bomb
terraform apply -var 'VPCNAME=nextvpc' -var 'awsregion=us-east-1' -var 'akey=XXXXX' -var 'skey=XXXXXX' ß ensure it doesn’t bomb
 
7)       IF after APPLY there is an issue -> immediately use the following:
terraform destroy -var 'VPCNAME=nextvpc' -var 'awsregion=us-east-1' -var 'akey=XXXXX' -var 'skey=XXXXXX'
 
 
