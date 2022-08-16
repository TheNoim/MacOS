# Git commit shortcut
gcommit() {
	if [ -z "$@" ]; then
		git commit -a -S
	else
		git commit -a -S -m $@
	fi
}

# Find out which app is listening on a port
listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

gitlab-test() {
	gitlab-runner exec docker \
		--docker-volumes /var/run/docker.sock:/var/run/docker.sock \
		--docker-volumes ~/.docker/gitlab.json:/root/.docker/config.json:ro \
		--docker-privileged \
		--env REGISTRY=registry.schuelerkarriere.de \
		--env DOCKER_AUTH_CONFIG="$(cat ~/.docker/gitlab.json)" \
		$@
}

reload-zsh() {
	source $HOME/.zshrc
}

untilfail() {
	while "$@"; do :; done
}

## Colorize the ls output ##
alias ls='ls --color=auto'
## Download best yt audio with yt-dlp
alias yt-audio='yt-dlp -f "ba" -x --audio-format mp3 --embed-thumbnail --embed-metadata'
## http-server removed the hs alias :(
alias hs='http-server'

# Do not steal my time with auto update
export HOMEBREW_NO_AUTO_UPDATE=1
# Use faster api
export HOMEBREW_INSTALL_FROM_API=1
# Do not auto install other things after install
#export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# No auto clean up
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Enable auto cd
setopt auto_cd
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
