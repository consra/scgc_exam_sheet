#!/bin/bash

ansible-playbook -i inventory.ini --ask-vault-pass --extra-vars '@passwd.yml' main.yml
