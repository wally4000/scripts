#!/bin/bash

#TODO:
# Add Option for extraction point?

mkdir "$DBP"
unsquashfs -d "$DBP/dbpdata" "$DBP.dbp"
unzip "$DBP.dbp" -d "$DBP"
echo "Extracted $DBP"
