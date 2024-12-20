# tests/provider.tf

terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<=5.68.0"
    }
  }

}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Region      = var.region
      CostCode    = var.cost_code
      Requestor   = var.requestor
      Approver    = var.approver
      SubDomain   = var.sub_domain
      Application = var.application
      Owner       = var.owner
      Environment = var.environment
    }
  }

}