#!/bin/bash

terraform -chdir=./Terraform apply -auto-approve

source ./Ansible/venv/bin/activate
export ANSIBLE_CONFIG=./Ansible/ansible.cfg
ansible-playbook -i ./Ansible/ec2_inventory.aws_ec2.yaml ./Ansible/main.yaml