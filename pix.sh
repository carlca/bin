#!/bin/zsh

rm -rf pixi.lock
pixi self-update
pixi clean cache --conda
pixi update
pixi run default
