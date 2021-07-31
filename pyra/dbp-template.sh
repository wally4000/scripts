#!/bin/bash
# Add option to set category and cross-reference with the existing categories 
## Add ability to add additional desktop files for extra executables


TARGET=$1

[  -d "$PWD/$TARGET" ] && echo "$TARGET already exists" && exit 0
mkdir  "$TARGET" "$TARGET/data" "$TARGET/icons" "$TARGET/metadata" "$TARGET/teasers"

VERSION="0.1" ## Overrideable

cat >"$TARGET/metadata/default.desktop"<<EOF
[Desktop Entry]
Version=0.1
Type=Application
Categories=Application;Game;
Name=$TARGET
Exec=$TARGET.launch
Icon=icon.png
X-DBP-Screenshot=preview.png 

[Package Entry]
Id=$TARGET
Name=$TARGET
Arch=armhf
Exec=$TARGET.launch
Version=$VERSION
Appdata=$TARGET
Icon=icon.png
Dependency[deb]=
Dependency[dbp]=
EOF

echo $TARGET DBP template generated