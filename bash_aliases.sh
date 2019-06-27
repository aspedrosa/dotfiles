alias ls='ls --color=always --group-directories-first -A'

alias ll='ls -lh --time-style=+"%e %b %l:%M %p"'
alias l='ls'

# Changes to the directory in the command's argument and shows his content
function csFunc() {
	cd $1 && ls
}
alias cd="csFunc"

# Go back one directory and shows his content
alias b="cd .."

# Go back x directories and shows the content of the final directory
function bxTimes() {
    for i in $(seq 1 $1) ; do
        cd .. 1>/dev/null
    done
    ls
}
alias bx="bxTimes"

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

alias xopen="xdg-open"

# Access courses directories quickly
alias agr="cd ~/ua/agr"
alias apsei="cd ~/ua/apsei"
alias pi="cd ~/ua/pi"
alias tqs="cd ~/ua/tqs"

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
