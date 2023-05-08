#!/bin/zsh

# Assign $archive to be the current date and time
archive=$(date -u +"%Y-%m-%d_T%H:%M:%S_UTC")
# Convert the first : to a _
archive=${archive:s/:/_}
# Convert the second : to a _
archive=${archive:s/:/_}
# Create the $archive folder
archive="Discord_$archive"
mkdir -p $archive

# Loop through all .vital files in the current folder
for preset in *.vital; do
    # Use jq utility to extract ".author" tag
    author=$(jq '.author' "$preset")
    # Code to strip leading and trailing quote marks from $author
    temp="${author%\"}"
    temp="${temp#\"}"
    author="$temp"
    # If $author string is empty, assign "_NO AUTHOR"
    if [ "$author" = "" ]; then
        author="_NO AUTHOR"
    fi    
    # Make destination folder name for the .vital file
    folder="$archive/$author" 
    # Echo progress to terminal
    echo "$author $folder"
    # Create actual destination folder
    mkdir -p $folder
    # Move the .vital file to the destination folder
    mv ./$preset ./$folder
done


