#!/bin/bash

# This scripts renames computers in a bulk capacity based on the name of the device 
#Example WEL-201-001 goes to WEL-OLD-201-001

name=$(scutil --get ComputerName | sed "s/WEL/WEL-OLD/")

sudo jamf setcomputername -name $name
sudo jamf recon