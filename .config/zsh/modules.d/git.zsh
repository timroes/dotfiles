# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
	local ref
	ref="$(command git symbolic-ref --quiet --short HEAD 2> /dev/null)"
	local ret=$?
	if [[ $ret != 0 ]]; then
		# Not really a git repository
		[[ $ret == 128 ]] && return
		ref="✕$(command git rev-parse --short HEAD 2> /dev/null)" || return
	fi
	echo $ref
}

function is_git() {
	git rev-parse --git-dir > /dev/null 2>&1
}

function git_is_dirty() {
	test -n "$(git status --porcelain --ignore-submodules)"
}
