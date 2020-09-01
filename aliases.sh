alias ls='ls --color=always --group-directories-first -A'

alias ll='ls -lh --time-style=+"%e %b %l:%M %p"'
alias l='ls'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Go back one or more directories and shows the content of the final directory
function back() {
    if [[ $# -eq 0 ]] ; then
        cd ..
    elif [[ $# -eq 1 ]] ; then
        initial_pwd=$(pwd)
        for i in $(seq 1 $1) ; do
            cd ..
            if [[ $? -ne 0 ]] ; then
                cd $initial_pwd
                exit 2
            fi
        done
    else
        >&2 echo "Too many arguments"
        exit 1
    fi

    ls
}
alias b="back"

# Changes to the directory in the command's argument and shows his content
function csFunc() {
	cd $1 && ls
}
alias cd="csFunc"

function makeAndChange() {
    mkdir $1 && cd $1
}
alias mkcd="makeAndChange"

# Exit faster from terminal/bash
function jobs_exit() {
  jobs_out=$(jobs)
  if [[ $jobs_out != "" ]] ; then
    echo $jobs_out
    return 1
  fi

  exit
}
alias e="jobs_exit"

function default_open() {
    for arg in "$@" ; do
        xdg-open $arg > /dev/null &
    done
}
alias xo="default_open"

function stop_and_remove_docker_container() {
    docker stop $1 > /dev/null
    if [[ $? -ne 0 ]] ; then
        >&2 echo "Unable to stop container"
        exit 1
    fi

    docker rm $1
}
alias docker_sr="stop_and_remove_docker_container"

# Access courses directories quickly
alias as="cd ~/ua/as"
alias bic="cd ~/ua/bic"
alias cle="cd ~/ua/cle"
alias es="cd ~/ua/es"
alias gic="cd ~/ua/gic"
alias sio="cd ~/ua/sio"

# Command to execute before commits
alias sshagent="eval `ssh-agent` ; ssh-add"

# Terminal calculator
# https://askubuntu.com/questions/378661/any-command-line-calculator-for-ubuntu
calc() {
    local IFS=' '
    local cal="${*//p/+}"
    cal="${cal//x/*}"
    bc -l <<<"scale=10;$cal"
}

alias -g bg_all_null=" &> /dev/null &"
alias -g bg_only=" &"

alias k="kill -9"
