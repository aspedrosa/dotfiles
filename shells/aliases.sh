alias ls='ls --color=always --group-directories-first -A'

alias ll='ls -lh --time-style=+"%e %b %l:%M %p"'
alias l='ls'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Changes to the directory in the command's argument and shows his content
function cs() {
	cd $1 && ls
}
alias cd="cs"

alias k="kill -9"
alias ka="killall"

alias reboot="systemctl reboot"

alias apt-upgrade="sudo bash -c 'apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y && apt autoremove -y && shutdown -h now'"

alias fzf="fzf --height=10"

alias dc="docker-compose"
