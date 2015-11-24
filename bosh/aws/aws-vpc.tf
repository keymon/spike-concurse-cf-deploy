provider "aws" {
  region      = "${var.region}"
}

resource "aws_vpc" "default" {
  depends_on = "aws_s3_bucket.terraform_state"
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.env}-test"
  }
}
