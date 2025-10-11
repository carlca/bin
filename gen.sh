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

# Find the class files in the directory and its subdirectories
class_files=($(find "$dir" -name "*.class"))

# Check if any class files were found
if [ ${#class_files[@]} -eq 0 ]; then
    echo "No class files found in the directory and its subdirectories."
    exit 1
fi

# Generate the zsh script to compile and run the Java file
for class_file in "${class_files[@]}"; do
    package_path=$(dirname "$class_file" | sed 's#^\./src/main/scala/##')
    script_name="_${class_file}.sh"
    cat > "$script_name" << EOF
#!/bin/zsh
cd ./src/main/scala
java ${package_path}/${class_name}
EOF
    chmod +x "$script_name"
done
