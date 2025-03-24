check_node_version() {
	# When a .nvmrc file in the current directory exists ..
	if [ -f ".nvmrc" ]; then
		nvmrc=`cat .nvmrc`
		# .. check whether the current node version is the required one
		if [ ! -x "$(command -v node)" ] || [ `node -v` != `nvm version $nvmrc` ]; then
			# If not use nvm to set the version to the one from .node-version
			echo -e "$fg_bold[yellow][.nvmrc] Switching to $nvmrc$reset_color"
			nvm ls "$nvmrc" &> /dev/null
			if [ $? -eq 0 ]; then
				nvm use "$nvmrc"
			else
				nvm install "$nvmrc"
			fi
			if [ $? -eq 0 ]; then
				echo -e "$fg_bold[green]Done!$reset_color"
			else
				echo -e "$fg_bold[red]Failed!$reset_color"
			fi
		fi
	fi
	# Check if there's a packageManager entry in the package.json then use corepack
	if [ -f "package.json" ] && (cat package.json | grep -q '"packageManager"'); then
		# Note: This will only work with Node V20+, but we ignore older versions here and just fail
		corepack enable && corepack install
	fi
}

if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
	source /usr/share/nvm/init-nvm.sh --no-use
	add-zsh-hook chpwd check_node_version
	check_node_version
elif [ -f "$HOME/.nvm/nvm.sh" ]; then
	source "$HOME/.nvm/nvm.sh" --no-use
	add-zsh-hook chpwd check_node_version
	check_node_version
fi
