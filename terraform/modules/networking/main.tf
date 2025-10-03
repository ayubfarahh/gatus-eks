resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

}

resource "aws_subnet" "pub_sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "eu-west-2a"

}

resource "aws_subnet" "pub_sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.64/26"
  availability_zone = "eu-west-2b"

}

resource "aws_subnet" "priv_sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.128/26"
  availability_zone = "eu-west-2a"

}

resource "aws_subnet" "priv_sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.192/26"
  availability_zone = "eu-west-2b"

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "pub_rta1" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_rta2" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_eip" "eip" {
  domain = "vpc"

}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_sub1.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  depends_on = [aws_nat_gateway.ngw]

}

resource "aws_route_table_association" "priv_rta1" {
  subnet_id      = aws_subnet.priv_sub1.id
  route_table_id = aws_route_table.priv_rt.id

}

resource "aws_route_table_association" "priv_rta2" {
  subnet_id      = aws_subnet.priv_sub2.id
  route_table_id = aws_route_table.priv_rt.id

}

