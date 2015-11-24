resource "aws_s3_bucket" "terraform_state" {
    bucket = "${var.env}-tfstate"
    acl = "private"
    force_destroy = "true"
}
