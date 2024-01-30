#Audio Plugin Installer

#This script searches DMG files for VST, VST3, Component, MAS and aaxplugin files and places them in the correct locations.
# It is encouraged that manufacturer provided DMGS are used, alternatively make your own as ZIP is not supported right now.

#Todo:
# Add support for Zip files, manufacturers are a pain

#Default Plugin Paths
AAX="/Library/Application Support/Avid/Audio/Plug-ins"
VST="/Library/Audio/Plug-Ins/VST"
VST3="/Library/Audio/Plug-Ins/VST3"
COMPONENTS="/Library/Audio/Plug-Ins/Components"


#Eject all current mounted DMG files
hdiutil info | grep '/Volumes' | cut -f 3 | xargs -I {} hdiutil eject "{}" 2> /dev/null

#Mount specified DMG file ($4)
hdiutil mount "/Library/Application Support/JAMF/Waiting Room/$4"

#Change working directoy to mounted DMG ($5)
cd "/Volumes/$5"


# Check and generate the required plugin directories

for dir in "$VST" "$VST3" "$COMPONENTS" "$AAX"
do
mkdir -p "$dir"
done

# Handle loose PKG files first
for pkg in "/Volumes/$5"/*.pkg; do
installer -pkg "$pkg" -target /
done

#Iterate over DMG files
for dmg_file in "/Volumes/$5"/*.dmg; do
    hdiutil mount "$dmg_file" 2> /dev/null
     dmg_just_mounted=$(hdiutil mount $dmg_file | grep /Volumes/ | cut -f3)

    # Copy plugins to destination folders
    find "$dmg_just_mounted" -type d -name '*aaxplugin' -print0 | while IFS= read -r -d '' dir; do
        cp -R "$dir" "$AAX"
        file=$(basename "$dir")
        xattr -rd com.apple.quarantine "$AAX/$file"
    done

    find "$dmg_just_mounted" -type d -name '*component' -print0 | while IFS= read -r -d '' dir; do
        cp -R "$dir" "$COMPONENTS"
        file=$(basename "$dir")
        xattr -rd com.apple.quarantine "$COMPONENTS/$file"
    done

    find "$dmg_just_mounted" -type d -name '*vst' -print0 | while IFS= read -r -d '' dir; do
        cp -R "$dir" "$VST"
        file=$(basename "$dir")
        xattr -rd com.apple.quarantine "$VST/$file"
    done

    find "$dmg_just_mounted" -type d -name '*vst3' -print0 | while IFS= read -r -d '' dir; do
        cp -R "$dir" "$VST3"
        file=$(basename "$dir")
        xattr -rd com.apple.quarantine "$VST3/$file"
    done
    find "$dmg_just_mounted" -type f -name '*pkg' -print0 | while IFS= read -r -d '' dir; do
    installer -pkg "$dir" -target /
    done
    hdiutil eject "$dmg_just_mounted"
done

## Sanity Check, Eject all mounted DMG files again
hdiutil info | grep '/Volumes' | cut -f 3 | xargs -I {} hdiutil eject "{}" 2> /dev/null
