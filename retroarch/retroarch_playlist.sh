#!/bin/bash

# Predict system based on folder name

cat >> "/Storage/Nintendo - Nintendo 64.lpl" << EOF
{
  "version": "1.2",
  "default_core_path": "",
  "default_core_name": "",
  "label_display_mode": 0,
  "right_thumbnail_mode": 0,
  "left_thumbnail_mode": 0,
  "items": [
EOF

for game in *.z64
do
gameCRC=$(crc32 "$game" | tr a-z A-Z)
gamename=${game%.*}
GAMEPATH="/storage/PLANETEXPRESS/Storage/Games/ROMS/Nintendo/Nintendo 64"
cat >> "/Storage/Nintendo - Nintendo 64.lpl" << EOF
    {
      "path":"$GAMEPATH/$game",
      "label": "$gamename",
      "core_path": "DETECT",
      "core_name": "DETECT",
      "crc32": "$gameCRC|crc",
      "db_name": "Nintendo - Nintendo 64.lpl"
    },
EOF

echo >> "/Storage/text-n64.txt" 
done

cat >> "/Storage/Nintendo - Nintendo 64.lpl" << EOF
	]
}
EOF
