locals {
  workspace   = split("-", terraform.workspace)
  name        = format("lmd-%s-%s-aws-%s-%s-%s", local.workspace[1], local.workspace[2], local.workspace[4], local.workspace[5], var.context)
  description = format("KMS key used to encrypt lambda: %s", local.name)
}
data "aws_iam_roles" "devops" {
  name_regex = "AWSReservedSSO_RTLH-DevOps_*"
}

data "aws_iam_roles" "developer" {
  name_regex = "AWSReservedSSO_RTLH-Developer_*"
}

data "aws_iam_role" "cicd" {
  name = "DNA-Automation-Github-Actions-Role"
}

data "aws_caller_identity" "current" {

}

data "aws_region" "this" {

}