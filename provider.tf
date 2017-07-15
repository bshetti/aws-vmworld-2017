# Define some provider configuration variables
variable "akey" {}
variable "skey" {}
variable "awsregion" {}

# Configure the "aws" provider
provider "aws" {
  access_key = "${var.akey}"
  secret_key = "${var.skey}"
  region     = "${var.awsregion}"
}
