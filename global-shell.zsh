
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

export HOMEBREW_NO_AUTO_UPDATE=1
