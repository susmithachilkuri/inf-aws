# Internet VPC
resource "aws_vpc" "test-vpc" {
  cidr_block           = "192.168.0.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
}

# Subnets
resource "aws_subnet" "test-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "test-subnet"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2c"
}

# Internet GW
resource "aws_internet_gateway" "test-ig" {
  vpc_id = aws_vpc.test-vpc.id
}

# route tables
resource "aws_route_table" "test-routetable" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-ig.id
  }
}

# route associations public
resource "aws_route_table_association" "test-subnet_test-routetable" {
  subnet_id      = aws_subnet.test-subnet.id
  route_table_id = aws_route_table.test-routetable.id
}


