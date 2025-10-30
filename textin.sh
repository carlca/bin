if [ -z "$VIRTUAL_ENV" ]; then
   source ./.venv/bin/activate
fi
pip install textual
pip install textual-dev
pip install "textual[syntax]"

textual --version
