#! /bin/bash

shopt -s expand_aliases

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'

mkdir "$HOME/.dotfiles"
/usr/bin/git clone --bare git@github.com:timroes/dotfiles.git "$HOME/.dotfiles/.git"
echo "Checking out config..."
config checkout
if [ $? = 0 ]; then
  echo "Checked out config"
else
  echo "Backing up conflicting files into ~/.config-backup..."
  mkdir -p "$HOME/.config-backup"
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} /bin/sh -c 'mkdir -p "$HOME/.config-backup/$(dirname {})"; mv {} $HOME/.config-backup/{};'
  echo "Done. Checking out config..."
  config checkout
  echo "Checked out config"
fi
config config --local status.showUntrackedFiles no
