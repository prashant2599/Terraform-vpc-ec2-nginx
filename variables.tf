

variable "region-list" {
    type = string
    default = "ap-south-1"
}


variable "cidr" {
    default = "10.0.0.0/16"
}


variable "subnet1" {
    default = "10.0.0.0/24"  
}

variable "subnet2" {
    default = "10.0.1.0/24"
  
}

variable "si" {
    default = "ami-0ec0e125bb6c6e8ec"
  
}



