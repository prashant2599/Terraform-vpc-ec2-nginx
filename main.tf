#VPC

resource "aws_vpc" "mainvpc" {
    cidr_block = var.cidr 
}

#subnet-1 
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = var.subnet1
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

#SUBNET-2
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = var.subnet2
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
}

#INTERNET-GATEWAY
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.mainvpc.id 
}

#ROUTE-TABLE

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.mainvpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id =  aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "Routetable1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.RT.id  
}

resource "aws_route_table_association" "Routetable2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.RT.id
}

#SECURITY-GROUP
resource "aws_security_group" "mainsg" {
  name   = "web"
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "mainsg"
  }
}

resource "aws_instance" "Server1" {
    ami = var.si
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.mainsg.id ]
    subnet_id = aws_subnet.subnet1.id
    user_data = base64encode(file("config.sh"))
}

