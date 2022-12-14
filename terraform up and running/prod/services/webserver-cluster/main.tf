terraform {
  backend "s3" {
    bucket = "jdb-terraform-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  ami         = "ami-08c40ec9ead489470"
  server_text = "New server text"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "jdb-terraform-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true
  # enable_new_user_data = false

  custom_tags = {
    Owner        = "team-foo"
    DeploymentBy = "terraform"
  }
}


