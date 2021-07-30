##Todo add missing preview image stuff
# Add option to set category and cross-reference

# Rid of the $random thing in Id as it's hard to
# determine what the DBP is called, perhaps it should just be called the application name
#

[  -d "$PWD/$DBP" ] && echo "$DBP Folder already exists" && exit 0
mkdir  "$DBP" "$DBP/dbpdata" "$DBP/icons" "$DBP/meta" "$DBP/teasers"

cat >"$DBP/meta/default.desktop"<<EOF
[Desktop Entry]
Version=0.1
Type=Application
Categories=Application;CHANGEME;
Name=$DBP
Exec=$DBP.launch
Icon=icon.png

[Package Entry]
Id=$DBP$RANDOM
Name=$DBP
Arch=armhf
Exec=$DBP.launch
Version=0.1
Appdata=$DBP
Icon=icon.png
EOF
