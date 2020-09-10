# TerrariaForm
A project I worked on while I was studying Terraform and Ansible in my own time. Automatically sets up and deploys a Terraria server. Terraria is a simple server so this isn't really necessary but I thought it was good to learn.

Variables such as AWS Credentials Profile, Region and Availability zone, Port, Instance Size, Key name, and GitHub to pull ansible and serverconfig.txt from can be configured in variables.tf.

Terraform will automatically deploy all the aws infrastructure we need, and will output the public ip address for you, and then use user_data to install git and ansible, after that it will then pull the files form the github repo and run terra.yml.

Terra.yml will then do everything needed to run the server - install prerequisites, create users, give permissions, download files, and finally run the server in a tmux session. Tmux is required due to how the server executable works, running it as a service would not work with it.

If you need to access the server, use SSH to connect to your instance, switch to the TerrariaServer user and then use tmux attach to attach to it. You can view a full list of tmux commands elsewhere, but the important one for this setup is Ctrl+B D to detach from the Tmux session without closing it, allowing it to run in the background and be running when you exit terminal.

Important to note: There is currently a bug with TerrariaServer 1.4.0.5 where it does not read config files correctly, so some are supplied as command line options in terra.yml
