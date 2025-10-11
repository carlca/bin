#!/bin/zsh

# Executes the local ./dev.sh script with all arguments
PROJECT_SCRIPT="./dev.sh"
if [ -x "$PROJECT_SCRIPT" ]; then
    exec "$PROJECT_SCRIPT" "$@"
else
    echo "Error: ./dev.sh not found or not executable." >&2; exit 1
fi
