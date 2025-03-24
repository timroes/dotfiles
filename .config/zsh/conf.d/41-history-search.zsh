# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

history_search() {
  setopt extendedglob

  history_cmd="fc -l -i -1 0 | awk '!seen[\$0]++'"
  candidates="$(eval $history_cmd | fzf +s +m -e --preview-window=hidden -q "$BUFFER")"

  local ret=$?
  if [ -n "$candidates" ]; then
    history_entry="$(echo -n $candidates | sed 's/ *\([0-9]*\).*/\1/g')"
    zle vi-fetch-history -n $history_entry
    zle end-of-line
  fi

  zle reset-prompt
  return $ret
}

autoload history_search
zle -N history_search

bindkey '^r' history_search