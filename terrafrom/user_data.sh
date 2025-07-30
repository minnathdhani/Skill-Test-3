provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "ecom_sg" {
  name   = "ecommerce-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3000
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ecom" {
  ami                    = "ami-0f5ee92e2d63afc18"  # Ubuntu 22.04 for ap-south-1
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ecom_sg.id]
  key_name               = "minnath_new"
  associate_public_ip_address = true

  user_data = file("user_data.sh")

  tags = {
    Name = "ECommerceApp"
  }
}
ubuntu@ip-172-31-10-203:~/E-CommerceStore/terraform$ ls
main.tf  outputs.tf  terraform.tfstate  terraform.tfstate.backup  user_data.sh  variables.tf
ubuntu@ip-172-31-10-203:~/E-CommerceStore/terraform$ cat outputs.tf 
output "instance_ip" {
  value = aws_instance.ecom.public_ip
}
ubuntu@ip-172-31-10-203:~/E-CommerceStore/terraform$ ^C
ubuntu@ip-172-31-10-203:~/E-CommerceStore/terraform$ cat user_data.sh 
#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Pull Docker images
docker pull minnathdhani/frontend-service
docker pull minnathdhani/user-service
docker pull minnathdhani/product-service
docker pull minnathdhani/cart-service
docker pull minnathdhani/order-service


# Run backend containers
docker run -d -p 3001:3001 --name user-service-test \
  -e PORT=3001 \
  -e MONGODB_URI='mongodb+srv://minnath2025:3lkrZKMpwd76jCx0@minnath.nuy0c.mongodb.net/user_service' \
  -e JWT_SECRET='your-jwt-secret-key' \
  minnathdhani/user-service \
  sh -c "echo -e \"PORT=$PORT\nMONGODB_URI=MONGODB_URI\nJWT_SECRET=$JWT_SECRET\" > .env && node server.js"

docker run -d -p 3002:3002 --name product-service-test \
  -e PORT=3002 \
  -e MONGODB_URI='mongodb+srv://minnath2025:3lkrZKMpwd76jCx0@minnath.nuy0c.mongodb.net/product_service' \
  -e JWT_SECRET='your-jwt-secret-key' \
  minnathdhani/product-service \
  sh -c "echo -e \"PORT=$PORT\nMONGODB_URI=MONGODB_URI\nJWT_SECRET=$JWT_SECRET\" > .env && node server.js"

docker run -d -p 3003:3003 --name cart-service-test \
  -e PORT=3003 \
  -e MONGODB_URI='mongodb+srv://minnath2025:3lkrZKMpwd76jCx0@minnath.nuy0c.mongodb.net/cart_service' \
  -e JWT_SECRET='your-jwt-secret-key' \
  minnathdhani/cart-service \
  sh -c "echo -e \"PORT=$PORT\nMONGODB_URI=MONGODB_URI\nJWT_SECRET=$JWT_SECRET\" > .env && node server.js"

docker run -d -p 3004:3004 --name order-service-test \
  -e PORT=3004 \
  -e MONGODB_URI='mongodb+srv://minnath2025:3lkrZKMpwd76jCx0@minnath.nuy0c.mongodb.net/order_service' \
  -e JWT_SECRET='your-jwt-secret-key' \
  minnathdhani/order-service \
  sh -c "echo -e \"PORT=$PORT\nMONGODB_URI=MONGODB_URI\nJWT_SECRET=$JWT_SECRET\" > .env && node server.js"

# Run frontend container
docker run -d -p 3000:3000 --name frontend-service-test \
  minnathdhani/frontend-service
