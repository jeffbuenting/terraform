terraform {
  backend "s3" {
    bucket = "jdb-terraform-state"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
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

module "hello-world" {
  source = "../../../modules/services/hello-world-app"

  environment = "stage"

  ami         = "ami-08c40ec9ead489470"
  server_text = "New server text"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "jdb-terraform-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
  # enable_new_user_data = true

  custom_tags = {
    Owner        = "team-foo"
    DeploymentBy = "terraform"
  }
}
