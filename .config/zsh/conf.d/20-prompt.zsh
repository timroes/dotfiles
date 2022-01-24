# Import colors function to use color
autoload -U colors && colors

# Import the promptinit function to load some default prompt settings
autoload -U promptinit && promptinit

DEFAULT_USER=`whoami`

git_prompt() {
	if is_git; then
		local color
		if git_is_dirty; then
			color=yellow
		else
			color=green
		fi
		echo "%F{$color}($(git_current_branch))%f"
	fi
}

user_or_empty() {
	if [ "$USER" != "$DEFAULT_USER" ]; then
		echo "$USER@"
	fi
}

in_minikube_env() {
	if [ -v DOCKER_MINIKUBE ]; then
		echo " %F{magenta}❬k8s❭%f"
	fi
}

prompt_precmd() {
	PROMPT="%{$fg_bold[cyan]%}$(user_or_empty)%3~%{$reset_color%} $(git_prompt)$(in_minikube_env)%(!.#.>) "
}

# Register the prompt_precmd method to execute before each prompt showing
add-zsh-hook precmd prompt_precmd

# Docs:
# http://www.nparikh.org/unix/prompt.php
