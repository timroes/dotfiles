# dotfiles

The way dotfiles are stored in this repository was inspired by an [Atlassian blog post](https://www.atlassian.com/git/tutorials/dotfiles).

## Installation

To get dotfiles on a new system, the following steps need to be executed:

```sh
mkdir -p "$HOME/.dotfiles"
git clone --bare git@github.com:timroes/dotfiles.git "$HOME/.dotfiles/.git"
cd "$HOME"
./dotfiles/setup.sh
```
