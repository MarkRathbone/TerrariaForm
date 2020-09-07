# TerrariaForm
A project I worked on while I was studying Terraform and Ansible in my own time. Automatically sets up and deploys a Terraria server. Terraria is a simple server so this isn't really necessary but I thought it was good to learn.

Terraform will automatically deploy all the aws infrastructure we need and then use user_data to install git and ansible, it will then pull the files form the github repo and run terra.yml.

Terra.yml will then do everything needed to run the server - install prerequisites, create users, give permissions, download files, and finally run the server in a tmux session.

Important to note: There is currently a big with TerrariaServer 1.4.0.5 where it does not read config files correctly, so some are supplied as command line options in terra.yml