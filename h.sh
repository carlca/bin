#!/bin/zsh

# Define the path to the Zsh history file.
HISTFILE_PATH="${HISTFILE:-$HOME/.zsh_history}"

if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") <search_term>"
  exit 1
fi

if [ ! -f "$HISTFILE_PATH" ]; then
  echo "Error: History file not found at $HISTFILE_PATH"
  exit 1
fi

# Set the highlight color for the matched text to bold magenta.
# This works correctly with GNU grep (ggrep).
export GREP_COLORS='mt=01;36'

# The processing pipeline:
# We use 'ggrep' (GNU grep) to get full color support.
strings "$HISTFILE_PATH" \
  | grep -v '^: ' \
  | grep --color=auto -i "$1"
