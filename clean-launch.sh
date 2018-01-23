#!/bin/bash

# clean setup of vagrant machine
ls -al && vagrant global-status --prune && vagrant destroy -f && rm -rf .vagrant && vagrant global-status && vagrant up

# echo how to ssh
echo "login to vagrant machine using:"
echo "vagrant ssh <box-name>"
