#!/bin/zsh

rm -rf pixi.lock
pixi self-update
pixi clean cache --conda
pixi update
if [ -f "./pix.sh" ]; then
    exec ./pix.sh "$@"
else
    # default behavior
    pixi run default
fi
