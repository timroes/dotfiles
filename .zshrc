if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# Get real path of this directory
ZSHDIR="$HOME/.config/zsh"

# Add completion directory for auto completion
fpath=($ZSHDIR/completion $fpath)

autoload -U compinit
compinit

# Include all modules from modules.d directory (this is also only a config
# but meant to only contain functions)
for module in $ZSHDIR/modules.d/*.zsh; do
	source "$module"
done

# Include all configurations from conf.d directory
for conf in $ZSHDIR/conf.d/*.zsh; do
	source "$conf"
done

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi