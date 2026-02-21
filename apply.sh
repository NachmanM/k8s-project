#!/bin/bash

terraform -chdir=./Terraform apply -auto-approve

source Ansible/venv/bin/activate
ansible-playbook Ansible/main.yaml