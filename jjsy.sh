#!/bin/zsh

# Simple jj sync to GitHub

# Check remote exists
if ! git remote get-url origin &>/dev/null; then
    echo "No remote, skipping"
    exit 0
fi

# Ensure current commit has description
if [[ -z $(jj log -r @ --no-graph -T description 2>/dev/null) ]]; then
    jj describe -m "Auto-sync commit"
fi

desc=$(jj log -r @ --no-graph -T description 2>/dev/null)

# Set bookmark
jj bookmark set main 2>/dev/null || true

# Try push (suppress error messages from jj)
if ! jj git push --bookmark main 2>/dev/null; then
    # Get error output without showing it
    err=$(jj git push --bookmark main 2>&1 || true)
    commit=$(echo "$err" | grep -o 'commit: [a-z0-9]*' | awk '{print $2}' || echo "")
    if [[ -n "$commit" ]]; then
        echo "Fixing commit $commit..."
        full_id=$(jj log --no-graph -T change_id -r "$commit" 2>/dev/null)
        [[ -n "$full_id" ]] && jj describe "$full_id" -m "Auto-sync fixup"
        # Retry push
        jj git push --bookmark main
    fi
fi

# Sync with remote
ign="Nothing changed"
jj git fetch 2> >(grep "$ign" > /dev/null; grep -v "$ign" >&2)
jj git import 2> >(grep "$ign" > /dev/null; grep -v "$ign" >&2)
ign="Nothing changed|Skipped rebase of [0-9]\+ commits that were already in place"
jj rebase -d main@git 2> >(grep "$ign" > /dev/null; grep -v "$ign" >&2)

# Get the last assigned description
echo "Updated the Github repo with the commit message: $desc"
