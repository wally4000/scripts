#!/bin/bash

## This script gets the latest PSP Toolchain and installs it in the current directory (Ubuntu)

#Ensure we are in HOME
cd $HOME

#Get the latest Ubuntu release and extract it
wget https://github.com/pspdev/pspdev/releases/download/latest/pspdev-ubuntu-latest.tar.gz
tar -xvf pspdev-ubuntu-latest.tar.gz

# Add to path and reload terminal
echo "export PSPDEV=$HOME/pspdev" >> ~/.profile
echo "export PATH=$PATH:$PSPDEV/bin" >> ~/.profile
source ~/.profile
