#!/bin/bash

# This Script allows for generic installation of .App bundles from DMG Files in the JAMF Waiting Room. 
# This script must be run as root.
# DMG filename needs to be formatted as such $DMGNAME_$ARCH

#$4 - DMG Name
#$5 - Arch (Intel, Silicon)
#$6 -  Mount Point - /Volumes/DMGNAME 

#Where the DMG files are stored
WAITING_ROOM="/Library/Application Support/JAMF/Waiting Room"

# If $5 is empty, then it's a Universal binary
if [ $5 = "" ]; then
FULLNAME=$4.dmg
else
FULLNAME=$4_$5.dmg
fi 

#Attach DMG without mounting the volume physically and bypass any EULAS
yes | hdiutil attach -nobrowse "$WAITING_ROOM/$FULLNAME" >/dev/null


#Navigate to the DMG Mount Point and copy any Application to Applications Folder and allow through GateKeeper.
cd /Volumes/$6

# # Navigate to the DMG Volume, copy ANY Application to /Applications Folder and allow through GateKeeper
# # It's possible there are applications in DMG Bundles we do not desire, it would be easier to remove them using a separate script in lab environments.
#TODO $7 - specify app files 

 for i in *.app
 do 
     echo "Found: "$i""
     cp -Rf "$i" /Applications
     xattr -r -d com.apple.quarantine "/Applications/$i"
 done 

#Unmount DMG
cd /; umount $6

#Clear Contents of Waiting Room.
  rm -rf "$WAITING_ROOM"/"$DMG" "$WAITING_ROOM"/"$DMG.cache.xml"