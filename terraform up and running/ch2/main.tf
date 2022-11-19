
terraform {
    required_providers {
        aws = {
            source = "hasicorp/aws"
            version = "-> 4.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "example" {
    # ami = "ami-08c40ec9ead489470"
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"

    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
        #!/bash/bin
        echo "Hello, World" > index.html
        nohub busybox httpd -f -p 8080 &
        EOF

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
