#!/bin/zsh

rm -rf "$1".sh
touch "$1".sh
chmod 755 "$1".sh
echo "#!/bin/zsh" >> "$1".sh
echo "$2"=\n\'"alias "$PWD/$1.sh"' >> ~/.zalias
exec zsh -l
fleet "$1.sh""

