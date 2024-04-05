# History size in ongoing session
HISTSIZE=500000
# History size in history file
SAVEHIST=500000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

HISTORY_IGNORE="(jwt decode *)"

zshaddhistory() {
  emulate -L zsh
  ## uncomment if HISTORY_IGNORE should use EXTENDED_GLOB syntax
  # setopt extendedglob
  [[ $1 != ${~HISTORY_IGNORE} ]]
}