if [ -z "$VIRTUAL_ENV" ]; then
   source ./.venv/bin/activate
fi
pip install --upgrade textual
pip install --upgrade textual-dev
pip install --upgrade "textual[syntax]"
