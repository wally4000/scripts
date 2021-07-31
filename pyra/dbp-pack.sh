#!/bin/bash
# dbp-pack - Enables automation for creation of DBP packages for the Dragonbox Pyra
# By Wally - 2021


if [ ! command -v mksquashfs &> /dev/null ]; then
    echo "Please install SquashFS Tools for your distribution"; exit 1;
fi

if [ ! command -v zip &> /dev/null ]; then
    echo "Please install zip for your distribution"; exit 1;
fi

#Todo:
# add --batch 

# Probably better in your /dragonbox/packages folder on one of your SD cards
# This is set to $HOME so it will work on all devices for performance in compression.

DBPHOME=$HOME/DBPS

TARGET=$1
cd "$TARGET"

echo " --- $TARGET is being packed --- "

#Consistency checks
[ ! -d "$PWD/data" ] && echo "Please create data folder for $TARGET" && exit 0
[ ! -d "$PWD/icons" ] && echo "Please create icons folder" && exit 0
[ ! -d "$PWD/meta" ] && echo "Please create meta folder" && exit 0
[ ! -f "$PWD/meta/default.desktop" ] && echo "Please create default.desktop" && exit 0
[   -f "$DBPHOME/$DBPNAME.dbp" ] && echo "$DBP.dbp already exists" && exit 0
[ ! -d "$DBPHOME" ] && mkdir "$HOME/DBPS"

#Remove .DS_Store files where Darwin is involved
if [ "$(uname)" == "Darwin" ]; then
    echo "Removing macOS Resource forks"
    find . -name .DS_Store -type f -delete ; find . -type d | xargs dot_clean -m
fi

# Set Permissions and create squashed / zipped volume
chmod -R go+rwx "$PWD/"
mksquashfs data target.sqfs -all-root -force-gid 0 -comp xz
zip -Z store -r metadata.zip meta icons teasers

#append datafiles to dbpdata and output to dbpname.dbp
cat target.sqfs metadata.zip > "$TARGET.dbp"
zip -A "$TARGET.dbp"

#Clean up temporary files
rm -r metadata.zip target.sqfs

#Move DBP to allocated $DBPDIR
mv "$PWD/$TARGET.dbp" "$DBPDIR"
echo "$TARGET.dbp has been generated successfully"
cd ..
