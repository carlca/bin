#!/bin/zsh

git switch 0.70_Alpha
git pull

echo "Cleaning up temporary build and cache directories..."
rm -rf build
find . -type d -name "__pycache__" -exec rm -r {} +

# Install all required Flet packages at once
pip install flet==0.70.0.dev5066 flet-cli==0.70.0.dev5066 flet-desktop==0.70.0.dev5066
