#On windows I redirect stderr because theres a lot of errors on some files
grep -qE "Microsoft|WSL" /proc/version
if [[ $? = 0 ]] ; then
  alias ls='ls --color=always --group-directories-first -A 2>/dev/null'
else
  alias ls='ls --color=always --group-directories-first -A'
fi

alias ll='ls -lh'
alias l='ls'

#Changes to the directory in the command's argument and shows his content
function csFunc() {
	cd $1 && ls
}
alias cd="csFunc"

#Go back one directory and shows his content
alias b="cd .."

#Go back x directories and shows the content of the final directory
function bxTimes() {
    for i in $(seq 1 $1) ; do
        cd .. 1>/dev/null
    done
    ls
}
alias bx="bxTimes"

# function makeAndChange() {
#     mkdir $1 && cd $1
# }
# alias mkdircd="makeAndChange"

#Exit faster from terminal/bash
alias e="exit"

# Aliases to start programs to force me to use cli
alias chrome="chrome &> /dev/null &"
alias spotify="spotify &> /dev/null &"
alias virtualbox="virtualbox &> /dev/null &"
