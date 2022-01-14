alias ls='ls --color=always --group-directories-first -A'

alias ll='ls -lh --time-style=+"%e %b %l:%M %p"'
alias l='ls'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Go back one or more directories and shows the content of the final directory
function b() {
    if [[ $# -eq 0 ]] ; then
        cd ..
    elif [[ $# -eq 1 ]] ; then
        if echo $1 | grep -Eqv "^[0-9+]$" ; then
            >&2 echo "Argument should be a number"
            return 1
        fi

        initial_pwd=$(pwd)
        for i in $(seq 1 $1) ; do
            cd ..
            if [[ $? -ne 0 ]] ; then
                cd $initial_pwd
                return 2
            fi
        done
    else
        >&2 echo "Too many arguments"
        return 1
    fi

    ls
}

# back x amounts of directories and cd into the provided path
# if only on argument is provided either
#  - go back x directories
#  - back 1 directory and cd into the provided path
function bcd() {
    if [[ $# -eq 0 ]] ; then
        cd ..
    elif [[ $# -eq 1 ]] ; then
        if echo $1 | grep -Eq "^[0-9+]$" ; then
            b $1
        else
            b &> /dev/null
            cd $1
            ls
        fi
    elif [[ $# -eq 2 ]] ; then
        if echo $1 | grep -Eqv "^[0-9+]$" ; then
            >&2 echo "When providing two arguments the first should be a number"
            return 1
        fi

        initial_pwd=$(pwd)

        b $1 &> /dev/null
        if [[ $? -ne 0 ]] ; then
            cd $initial_pwd
            return 1
        fi

        cd $2 &> /dev/null
        if [[ $? -ne 0 ]] ; then
            cd $initial_pwd
            return 1
        fi

        ls
    else
        >&2 echo "Too many arguments"
        return 1
    fi
}

# Changes to the directory in the command's argument and shows his content
function cs() {
	cd $1 && ls
}
alias cd="cs"

function mkcd() {
    mkdir $1 && cd $1
}

function xo() {
    for arg in "$@" ; do
        nohup xdg-open $arg &> /dev/null
    done
}

alias k="kill -9"
alias ka="killall"

alias reboot="systemctl reboot"

alias apt-upgrade="sudo bash -c 'apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y && apt autoremove -y && shutdown -h now'"

alias fzf="fzf --height=10"

alias dc="docker-compose"
