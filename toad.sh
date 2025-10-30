unset VIRTUAL_ENV && CURRENT_DIR=$(pwd -P) && cd ~/code/python/toad && TOAD_ACP_INITIALIZE=1 uv run toad acp "claude-code-acp" --project-dir "$CURRENT_DIR"
