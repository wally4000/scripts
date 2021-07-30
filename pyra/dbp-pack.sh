#!/bin/bash

#Todo:
# Refine the whole thing
# Add zip -A feature
# Add teasers
# Add requirements for use of utility squashfs / zip

DBPNAME=$(basename "$DBP" "$2") ## Set the DBP Name to directory name

cd "$DBP"

#Gather information from current working directory with information about DBP to be packed.
dbptopack=$(pwd)
echo "--- $dbptopack is being packed ---"

#Consistency checks
[ ! -d "$PWD/dbpdata" ] && echo "Please create dbpdata folder for $DBP" && exit 0
[ ! -d "$PWD/icons" ] && echo "Please create icons folder" && exit 0
[ ! -d "$PWD/meta" ] && echo "Please create meta folder" && exit 0
[ ! -f "$PWD/meta/default.desktop" ] && echo "Please create default.desktop" && exit 0
[   -f "$HOME/DBPS/$DBPNAME.dbp" ] && echo "$DBP.dbp already exists" && exit 0
[ ! -d "$HOME/DBPS" ] && mkdir "$HOME/DBPS"

#Remove .DS_Store files where Darwin is involved

if [ "$(uname)" == "Darwin" ]; then
echo "Removing macOS Resource forks"
find . -name .DS_Store -type f -delete ; find . -type d | xargs dot_clean -m
fi

# Set Permissions and create squashfs file as advised by notaz
echo "Setting permissions on "$PWD""
chmod -R go+rwx "$PWD/"
mksquashfs dbpdata dbpdata.sqfs -all-root -force-gid 0 -comp xz

#Zip Data files and do consistency check to ensure zip file generated
zip -r data.zip meta icons
[ ! -f "$PWD/data.zip" ] && echo "data.zip failed to generate for some reason" && exit 0

#append datafiles to dbpdata and output to dbpname.dbp
cat dbpdata.sqfs data.zip > "$(basename "$dbptopack").dbp"

#Clean up temporary files
rm -r data.zip dbpdata.sqfs

mv "$PWD/$DBPNAME.dbp" "$DBPDIR"
echo "DBP $DBP has been generated successfully"
cd ..
