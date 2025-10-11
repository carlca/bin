#!/bin/zsh

watchfiles "textual run --dev $1" *.py *.tcss

# $1 is the module path (e.g., osmose_presets.app)
# MODULE_PATH="$1"

# # The command to execute:
# # We use 'env' to correctly set the environment variable.
# # 'env' is the actual program that handles the 'PYTHONPATH=src' assignment.
# # This prevents 'watchfiles' (and subprocess) from treating the variable
# # assignment as the executable name.
# RUN_CMD="env PYTHONPATH=src textual run --dev ${MODULE_PATH}"

# # Execute watchfiles using the documented positional syntax:
# watchfiles "${RUN_CMD}" src
