#!/bin/bash


# This script runs on new installations and if the serial number matches then the device will be named accordingly.
# Otherwise the name will not be set

# A workaround for lack of admin permissions on Meraki but setting a static IP 
# and allocating the hostname would make this script redundant. 


# Fetch the serial number and assign a name if applicable
case $(ioreg -l | grep IOPlatformSerialNumber | cut -f4 -d "\"" ) in 

#Serial_Number)
#NAME=COMPUTER_NAME
#;;

esac

## If the NAME variable is empty then set the serial number to mSeriaalNumber for simplicity
# This will change when all the labs are properly named, this will at least give staff devices a name to go by

if [[ $NAME == "" ]]; then
SN=$(ioreg -l | grep IOPlatformSerialNumber | cut -f4 -d "\"")
NAME=m$SN
fi

/usr/local/bin/jamf setcomputername -name "$NAME"
jamf recon