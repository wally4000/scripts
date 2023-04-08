#!/bin/bash

# This script gets the latest PSP Toolchain and installs it in the current directory

#Ensure we are in HOME
# cd $HOME

## Install some utilities that are required for compiling certain projects
# Only targeting Debian / Ubuntu for now
OSNAME=$(cat /etc/os-release | grep -w NAME= | cut -f2 -d '"')

## linux-tools-virtual and hwdata are WSL exclusive
if [[ OSNAME == "Ubuntu" || "Debian" ]]; then
sudo apt -y install subversion cmake automake autoconf libusb-0.1-* linux-tools-virtual hwdata

fi


#Get the latest Ubuntu release and extract it
wget https://github.com/pspdev/pspdev/releases/download/latest/pspdev-ubuntu-latest.tar.gz
tar -xvf pspdev-ubuntu-latest.tar.gz

# Add to path and reload terminal
echo "export PSPDEV=$HOME/pspdev" >> ~/.profile
echo "export PATH=$PATH:$PSPDEV/bin" >> ~/.profile
source ~/.profile

