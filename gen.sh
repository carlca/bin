#!/bin/zsh

# Zap existing _ shell files
rm -f _*.sh 2>/dev/null

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

# Generate the zsh script to compile and run the Java file
for java_file in "${java_files[@]}"; do
    package_path=$(dirname "$java_file" | sed 's#^\./src/main/java/##')
    class_name=$(basename "$java_file" .java)
    script_name="_${class_name}.sh"
    cat > "$script_name" << EOF
#!/bin/zsh
cd ./src/main/java
javac ${package_path}/${class_name}.java
java ${package_path}/${class_name}
EOF
    chmod +x "$script_name"
done
