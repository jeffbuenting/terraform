terraform {
  backend "s3" {
    bucket = "jdb-terraform-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
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

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  db_name           = "example_database"
  username          = "admin"

  # How should we set the password?
  password = var.db_password

  skip_final_snapshot = true
}
