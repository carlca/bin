#!/bin/zsh

# Kill Chrome and wait for it to fully terminate
pkill Chrome
sleep 2  # Give Chrome time to fully shut down

# Check if Chrome is still running
while pgrep Chrome > /dev/null; do
    echo "Waiting for Chrome to terminate..."
    sleep 1
done

echo "Chrome terminated, starting with remote debugging..."

# Start Chrome with remote debugging
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222
