#!/bin/zsh

if [[ -n "$1" ]]; then
  # Run your script code here
  rm -rf "$HOME/bin/$1.sh"
  touch "$HOME/bin/$1.sh"
  chmod 755 "$HOME/bin/$1.sh"
  echo "#!/bin/zsh" >> "$HOME/bin/$1.sh"

  # Check if alias already exists
  if ! grep -q "alias $1='$1.sh'" "$HOME/bin/.zshrc_alias"; then
    echo "alias $1='$1.sh'" >> "$HOME/bin/.zshrc_alias"
  fi

  # exec zsh -l
  sleep 1
  open -a "/Applications/Nova.app" "$HOME/bin/$1.sh" -W
else
  echo "No argument provided."
fi
