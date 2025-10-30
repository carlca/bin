#!/usr/bin/env python3
"""
jj sync script - backs up jj repository to GitHub
Automatically fixes empty commits
"""

import subprocess
import sys

def run_jj(cmd, check=True):
    """Run a jj command and return output."""
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=True,
            text=True,
            check=check
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        if check:
            print(f"ERROR running: {cmd}")
            print(e.stderr)
            raise
        return ""

def main():
    print("=== JJ Sync Starting ===")

    # Check we're in a jj repo
    if not run_jj("jj log -r @", check=False):
        print("ERROR: Not in a jj repository")
        return 1

    # Check if there's a git remote
    if not run_jj("git remote get-url origin", check=False):
        print("No GitHub remote configured, skipping sync")
        return 0

    # Check for uncommitted changes
    status = run_jj("jj status --no-empty-summary")
    if "No changes" in status:
        print("No changes detected")
        has_changes = False
    else:
        print("Changes detected")
        has_changes = True

    if has_changes:
        # Get current commit description
        current_desc = run_jj("jj log -r @ --no-graph -T 'description'", check=False)

        # Add description if missing (preserve user's manual descriptions!)
        if not current_desc:
            print("Adding description to current commit...")
            run_jj('jj describe -m "Auto-sync commit"')

        print("Checking for empty commits in history...")

        # Get the bookmark name
        bookmark = "main"
        if "main*" not in run_jj(f"jj bookmark list --no-summary"):
            print("Setting bookmark...")
            run_jj(f"jj bookmark set {bookmark}")

        # Get commits that will be pushed (between git remote and current)
        # Note: need to check the bookmark's ancestors, not just main@git..@
        empty_commits = []

        # Get all commits that will be pushed by checking the bookmark's history
        commits_to_push = run_jj(
            f"jj log --no-graph -T 'change_id ++ \" \" ++ short_change_id ++ \" (\" ++ description ++ \")\"' "
            f"-r 'git-revs..@' --reverse",
            check=False
        )

        print(f"Commits to push:\n{commits_to_push}")

        # Check each commit for description
        commit_ids = run_jj(
            f"jj log --no-graph -T 'change_id' -r 'git-revs..@' --reverse",
            check=False
        ).split('\n')

        for commit_id in commit_ids:
            if commit_id:
                desc = run_jj(f"jj log -r '{commit_id}' --no-graph -T 'description'", check=False)
                if not desc:
                    empty_commits.append(commit_id)

        # Fix any empty commits
        if empty_commits:
            print(f"\nFound {len(empty_commits)} empty commits:")
            for commit in empty_commits:
                print(f"  Fixing {commit}...")
                run_jj(f'jj describe {commit} -m "Auto-sync fixup"')
        else:
            print("No empty commits found")

        print("Pushing to GitHub...")
        result = run_jj("jj git push --bookmark main", check=False)

        if "Error:" in result or "won't push" in result.lower():
            print(f"\nPush failed!")
            print(result)

            # Try alternative fix: describe the commit mentioned in error
            # Look for commit ID in error message
            import re
            commit_match = re.search(r'commit:?\s+(\w{4,})', result, re.IGNORECASE)
            if commit_match:
                bad_commit = commit_match.group(1)
                # Try to find full commit ID
                full_id = run_jj(f"jj log --no-graph -T 'change_id' -r '{bad_commit}'", check=False)
                if full_id:
                    print(f"\nTrying to fix commit {full_id} ({bad_commit})...")
                    run_jj(f'jj describe {full_id} -m "Auto-sync fixup"')
                    print("Retrying push...")
                    run_jj("jj git push --bookmark main")
        else:
            print(result)

    # Always sync with remote
    print("\nFetching from GitHub...")
    run_jj("jj git fetch")

    print("Importing changes from GitHub...")
    run_jj("jj git import")

    print("Rebasing on imported changes...")
    run_jj("jj rebase -d main@git")

    print("=== JJ Sync Complete ===")
    return 0

if __name__ == "__main__":
    sys.exit(main())
