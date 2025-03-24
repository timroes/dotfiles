alias ..='cd ..'
alias ...='cd ../..'

# Allow using sudo with aliases
alias sudo='sudo '

if [[ "$IS_OSX" == "1" ]]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto --hyperlink=auto'
fi

alias lsa='ls -lha'
alias copy='xclip -selection clipboard'

alias gw='./gradlew'

alias gitzip='git ls-files | zip archive -@'

alias ll='cd $(ENTER_EXIT=true lf --print-last-dir)'
