export ANDROID_HOME="$(first_dir /opt/android-sdk /Applications/android-sdk-macosx)"

type archlinux-java > /dev/null 2>&1
if [ $? -eq 0 ]; then
	export JAVA_HOME="/usr/lib/jvm/$(archlinux-java get)/"
fi

# opting out of CI stat collection of the Kibana repo
export CI_STATS_DISABLED=true
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
