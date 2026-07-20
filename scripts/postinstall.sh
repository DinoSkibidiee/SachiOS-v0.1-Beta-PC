#!/bin/bash

echo "Installing SachiOS configs file..."

echo "
alias ll='ls -la'
alias update='sudo apt update && sudo apt upgrade'
" >> /etc/bash.bashrc

mkdir -p /opt/sachios

echo "SachiOS now great to use."
