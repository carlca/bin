#!/bin/zsh

git switch 0.28.2_Stable
git pull

echo "Cleaning up temporary build and cache directories..."
rm -rf build
find . -type d -name "__pycache__" -exec rm -r {} +

# Install all required Flet packages at once
pip install flet==0.28.2 flet-cli==0.28.2 flet-desktop==0.28.2
