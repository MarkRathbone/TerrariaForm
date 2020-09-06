variable "awsprofile" {
    type = string
    default = "educate"
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "az" {
    type = string
    default = "b"
}

variable "terrariaport" {
    type = number
    default = 7777
}

variable "ec2_type" {
    type = string
    default = "t2.small"
}

variable "key_name" {
    type = string
    default = "terraria-key"
}