#!/bin/bash

# Function to apply chmod 755 recursively to files and directories
apply_chmod_recursive() {
    local directory="$1"
    
    # Find all files and directories recursively in the directory and apply chmod 755
    sudo find "$directory" -exec chmod 755 {} \;
}

# Get the current directory
current_directory=$(pwd)

# Apply chmod 755 recursively to files and directories in the current directory
apply_chmod_recursive "$current_directory"

echo "Applied chmod 755 recursively to files and directories in '$current_directory'."
