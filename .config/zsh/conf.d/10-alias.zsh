alias ..='cd ..'
alias ...='cd ../..'

# Allow using sudo with aliases
alias sudo='sudo '

if [[ "$IS_OSX" == "1" ]]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi

alias lsa='ls -lha'
alias copy='xclip -selection clipboard'

alias gw='./gradlew'
alias gwp='SUB_BUILD=PLATFORM ./gradlew'

alias gitzip='git ls-files | zip archive -@'
