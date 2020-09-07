#!/bin/bash
touch ~/_INIT_STARTED_
sudo yum install git -y
sudo amazon-linux-extras install ansible2 -y
sudo git clone ${githubuser} ~/TerrariaForm
sleep 5
mv ~/TerrariaForm/* ~/
sudo ansible-playbook ~/terra.yml
mv ~/_INIT_STARTED_ ~/_INIT_COMPLETE_