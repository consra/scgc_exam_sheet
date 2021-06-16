#!/bin/bash

cat ansible-modules | xargs -I{} sudo ansible-galaxy collection install {}
ansible-playbook -i inventory.ini --ask-vault-pass --extra-vars '@passwd.yml' main.yml
