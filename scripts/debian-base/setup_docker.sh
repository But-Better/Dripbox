#!/bin/bash

echo "updating system"
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
echo "installing docker.io"
sudo apt install docker.io postgresql-all
echo "setting up usermod"
sudo usermod -aG docker $USER
echo "done"
echo "please log out and in again for changes to take effect"
