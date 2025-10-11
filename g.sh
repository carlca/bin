#!/bin/zsh

# Save the original directory
original_dir=$(pwd)

# Function to run gitadd.sh and output pwd
function run_gitadd {
  local dir="$1"
  cd "$dir"
  echo "gitadd.sh $(pwd)"
  gitadd.sh "$2"
  echo ""
  echo "--------------------------------------------------------------------------------"
  echo ""
}

# Add changes for each module
run_gitadd "/Users/carlcaulkett/code/mojo/ca_lib" "$1"
run_gitadd "/Users/carlcaulkett/code/mojo/ca_mojo" "$1"
run_gitadd "/Users/carlcaulkett/code/mojo/ca_ga" "$1"
run_gitadd "/Users/carlcaulkett/code/mojo/ca_web" "$1"

# Go back to the original directory
cd "$original_dir"
