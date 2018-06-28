provider "aws" {
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.aws_region}"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "demo_subnet" {
  vpc_id                  = "${aws_vpc.demo_vpc.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = true

  tags {
    Name = "demo-subnet"
  }
}

resource "aws_internet_gateway" "demo_gw" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  tags {
    Name = "demo-gw"
  }
}

resource "aws_route_table" "demo_rt" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo_gw.id}"
  }

  tags {
    Name = "demo-rt"
  }
}

resource "aws_route_table_association" "demo_assoc" {
  subnet_id      = "${aws_subnet.demo_subnet.id}"
  route_table_id = "${aws_route_table.demo_rt.id}"
}
