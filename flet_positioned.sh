#!/bin/zsh

# Switch to the new positioned branch
git switch 0.70_Positioned
git pull

# Clean up old temporary files
echo "Cleaning up temporary build and cache directories..."
rm -rf build
find . -type d -name "__pycache__" -exec rm -r {} +

# Install the alpha Flet packages
pip install flet==0.70.0.dev5066 flet-cli==0.70.0.dev5066 flet-desktop==0.70.0.dev5066
