#!/bin/bash

#TODO:
# Add Option for extraction point?
TARGET=$1

mkdir "$TARGET"
unsquashfs -d "$TARGET/dbp" "$TARGET.dbp"
unzip "$TARGET.dbp" -d "$TARGET"
echo "Extracted $TARGET"
