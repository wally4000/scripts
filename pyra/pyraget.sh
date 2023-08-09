#!/bin/bash

# A little utility to fetch and compile minimumally required Dragonbox-Pyra DEB files.
# This will make it immensively easier to manage and deploy a newer OS or host your own mirror

outputDir=$HOME/Pyra/debs

repoList="
        dbp
        dri3wsegl-pyra 
        led-config 
        linux-image-pyra 
        pyra-archive-keyring
        pyra-firmware
        pyra-first-run 
        pyra-hacks 
        pyra-themes 
        pyra-scripts 
        pyra-misc 
        "

# steps required
# Fetch Package
# Compile
# Move deb to outputted directory
for i in $repoList
do
git clone https://dev.pyra-handheld.com/packages/$i 
done

