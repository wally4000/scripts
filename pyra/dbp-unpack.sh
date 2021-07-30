#!/bin/bash

#TODO:
# Add Option for extraction point?

# Logic
#Make Directory based on Filename
#unsquashfs the fle
#unzip the meta
#Complete

mkdir "$DBP"
unsquashfs -d "$DBP/dbpdata" "$DBP.dbp"
unzip "$DBP.dbp" -d "$DBP"
echo "Extracted $DBP"
