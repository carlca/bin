#!/bin/zsh

# Specify the root of the tree as first parameter.
echo "Total Apps: " `find $1 -name '*.app' | wc -l`
echo "Total Files: " `find $1 -not -type d | wc -l`
echo "Total Folders: " `find $1 -type d | wc -l`
