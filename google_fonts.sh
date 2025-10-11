#!/bin/zsh
KEY=$1
OUTPUT_FILE="google_fonts.json"  # Just the filename, will write to current directory

echo '[' > $OUTPUT_FILE

curl -s "https://www.googleapis.com/webfonts/v1/webfonts?key=$KEY&sort=alpha" | \
  sed -n 's/ *"family": "\(.*\)",/  "\1",/p' | \
  sed '$s/\(.*\),/\1/' >> $OUTPUT_FILE

echo ']' >> $OUTPUT_FILE
