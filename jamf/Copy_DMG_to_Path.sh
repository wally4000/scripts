#!/bin/bash

#Mount the Packages Repo
jamf mount -url smb://JAMFURL

#Mount DMG
 hdiutil attach "/Volumes/Packages/$4" -noverify

mkdir -p "$6"

cp -r /Volumes/$5/* "$6"
sudo chown -R student "$6"

#Detach Volumes, sleep for 5 seconds to allow detact to complete before unmounting network volume
hdiutil detach "/Volumes/$5"
sleep 10
umount /Volumes/Packages