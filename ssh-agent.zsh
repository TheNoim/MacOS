SSH_ENV="$HOME/.ssh/environment"
KEY="$HOME/.ssh/id_rsa"

function start_agent {
    # Starts the ssh-agent
    # and adds its env vars into $SSH_ENV file.

    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
}

function add_identities {
    # Adds $KEY identities to the agent,
    # if the agent has no identities associated
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then ssh-add $KEY; fi
}

function is_ssh_agent_pid_valid () {
    # Accepts ssh agent's pid as the first argument. 
    # Returns 0 if ssh-agent process is running,
    # otherwise returns non-zero.
   
    #ps -ef | grep $1 | grep -v grep | grep ssh-agent > /dev/null
    #kill $1 > /dev/null 2>&1;
    [ "$(pgrep ssh-agent)" = "$1" ];
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ] && is_ssh_agent_pid_valid $SSH_AGENT_PID; then 
    add_identities; 
else
    # if $SSH_AGENT_PID is not properly set, we might be able to load one from $SSH_ENV
    if [ -f "$SSH_ENV" ]; then . "$SSH_ENV" > /dev/null; fi
    if ! is_ssh_agent_pid_valid $SSH_AGENT_PID; then start_agent; fi
    add_identities 
fi
