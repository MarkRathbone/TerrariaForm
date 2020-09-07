#!/bin/bash
sudo yum install tmux -y
sudo yum install git -y
sudo amazon-linux-extras install ansible2 -y
sudo git clone ${githubuser} ~/TerrariaForm
mv ~/TerrariaForm/* ~/
sudo ansible-playbook ~/terra.yml