#!/bin/sh

yes_no_prompt() {
    while true; do
        read -p "$1" yn
        case $yn in
            [Yy]* )
                return 1
                break
                ;;
            [Nn]* )
                return 0
                break
                ;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

DISTRO=$(lsb_release -is)

# TODO
#  check if is sudo. if not add to it using `su`
#  check if sudo is installed

# Install ansible and brave to later import the ssh key
if [ $DISTRO = "Debian" ] ; then
    echo "Intalling Ansible"
    sudo apt update
    sudo apt install -y ansible apt-transport-https curl

    echo "Intalling Brave"
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install -y brave-browser
elif [ $DISTRO = "Fedora" ] ; then
    echo "Intalling Ansible"
    sudo dnf install -y ansible dnf-plugins-core

    echo "Intalling Brave"
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

    sudo dnf install brave-browser
fi

if yes_no_prompt "Crate a new ssh key? " ; then
    echo -n "Key name: "
    read GITHUB_KEY_NAME

    ssh-keygen -t rsa -N "" -f "~/.ssh/$GITHUB_KEY_NAME"

    cat << EOF >> ~/.ssh/config

Host github.com
    HostName github.com
    IdentityFile ~/.ssh/$GITHUB_KEY_NAME
EOF
else
    ssh-keygen -t rsa -N "" -f "~/.ssh/id_rsa"
fi

echo "Now import the new key into GitHub.\nContinue?"
read _

ansible-galaxy install -r requirements.yml

if [ $DISTRO = "Debian" ] ; then
    ansible-playbook debian.yml --ask-become-pass
elif [ $DISTRO = "Fedora" ] ; then
    ansible-playbook fedora.yml --ask-become-pass
fi
