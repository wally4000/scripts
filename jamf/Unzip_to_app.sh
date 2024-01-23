#!/bin/bash
# This unzips and extracts Applications to Applications Folder
WAITING_ROOM="/Library/Application Support/JAMF/Waiting Room"
ZIP_ARCHIVE="$4"
mkdir -p "/var/tmp/unzip" 


sudo unzip -d "/var/tmp/unzip/" "$WAITING_ROOM/$ZIP_ARCHIVE"                                                                                                                                                                                     

## Clean up 
if [[ -d /var/tmp/unzip/__MACOSX ]]; then
rm -r /var/tmp/unzip/__MACOSX
fi

## Notarise 
find "/var/tmp/unzip/" -type d -name "*.app" -depth -print0 | while IFS= read -r -d '' file; do
	spctl --add "$file"
    mv "$file" "/Applications"
done

#Clean up
rm -r "/var/tmp/unzip" "$WAITING_ROOM"/"$ZIP_ARCHIVE" 