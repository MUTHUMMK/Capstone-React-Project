# ec2 instance configuration

variable "os" {
    default = "ami-0f5ee92e2d63afc18"
}

variable "size" {
    default = "t2.micro"
}
variable "ec2-tags" {
    default = {
        Name = "MMK"
    }
}
variable "ec2-tags1" {
    default = {
        Name = "MUTHU"
    }
}
variable "key" {
    default = "linux"
}