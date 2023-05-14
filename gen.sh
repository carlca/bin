#!/bin/zsh

# Check if the directory is specified as an argument
if [ -z "$1" ]; then
    # Set default directory to the current directory
    dir="."
else
    # Use the specified directory
    dir="$1"
fi

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Directory not found."
    exit 1
fi

# Find the Java files in the directory and its subdirectories
java_files=($(find "$dir" -name "*.java"))

# Check if any Java files were found
if [ ${#java_files[@]} -eq 0 ]; then
    echo "No Java files found in the directory and its subdirectories."
    exit 1
fi

# Generate the zsh script to run the Java file
for java_file in "${java_files[@]}"; do
    base_name=$(basename "$java_file" .java)
    script_name="${base_name}.sh"
    cat > "_$script_name" << EOF
#!/bin/zsh
cd $(dirname "$java_file")
java $(basename "$java_file")
EOF
    chmod +x "_$script_name"
done 
