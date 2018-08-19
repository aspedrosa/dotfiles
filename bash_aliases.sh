alias ls='ls --color=always -A'

alias ll='ls -lh'
alias l='ls'

#Go back one directory and shows his content
alias b="cd ..; ls"

#Go back x directories and shows the content of the final directory
function bxTimes() {
    for i in $(seq 1 $1) ; do
        cd ..
    done
    ls
}
alias bx="bxTimes"

#Changes to the directory in the command's argument and shows his content
function csFunc() {
	cd $1 && ls
}
alias cd="csFunc"

function makeAndChange() {
    mkdir $1 && cd $1
}
alias mkdircd="makeAndChange"
