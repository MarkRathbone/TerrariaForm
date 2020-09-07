#Name of the aws profile being used in ~/.aws/credentials
variable "awsprofile" {
    type = string
    default = "educate"
}

#Which region to deploy to
variable "region" {
    type = string
    default = "us-east-1"
}

#The letter of the AZ being suffixed to the region
variable "az" {
    type = string
    default = "b"
}

#Which port to use - you need to change this in serverconfig.txt too.
variable "terrariaport" {
    type = number
    default = 7777
}

#Instance size.
#t2.micro can run a small world.
#t2.small can run a medium.
variable "ec2_type" {
    type = string
    default = "t2.small"
}

#The key pair to be used to attach to the instance. 
variable "key_name" {
    type = string
    default = "terraria-key"
}

#Where the server should pull serverconfig.txt and terra.yml from to run ansible and the server.
variable "github" {
    type = string
    default = "https://github.com/MarkRathbone/TerrariaForm"
}