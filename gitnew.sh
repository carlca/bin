#!/bin/zsh

# get the CWD and put it in $folder
folder=${PWD##*/}

# I'm sure there are more concise ways of doing this...
if [ ! -e README.md ]; then
    touch README.md
    chmod 755 README.md
fi
echo "# $folder" >> README.md

# delete previous .gitignore, if any. This deals with cp not supressing override prompts!
rm -rf .gitignore

# copy default .gitignore file from ~
cp ~/.gitignore .

# this command has been tweaked to make it entirely portable
gitname=`git config user.name`

# instructions as per https://github.com/new
git init

# note neat trick to supress message if remote rm fails
(git remote rm origin) 2>/dev/null

git remote add origin https://github.com/$gitname/$folder.git

git branch -M main
git add README.md
git commit -m "first commit"

# the final push!
git push -u origin main
