#!/bin/zsh

mkdir "$1"
cd "$1"
python -m venv .venv

source .venv/bin/activate

pip install --upgrade pip
pip install --upgrade textual
pip install --upgrade textual-dev
pip install --upgrade "textual[syntax]"
