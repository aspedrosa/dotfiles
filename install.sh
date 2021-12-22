#!/bin/sh

balooctl disable

DISTRO=$(lsb_release -is)

if [ $DISTRO = "Debian" ] ; then
    INSTALL_COMMAND="apt install -y"

    # update repositories
    # docker repos
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # brave repos
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    # vscode repos
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

    # spotify repos
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo sed -iE "/^deb|^deb-src /s/$/ contrib non-free/" /etc/apt/source.list
    sudo apt update

    DISTRO_SPECIFIC_PACKAGES="brave-browser batcat isenkram-cli spotify-client"
elif [ $DISTRO = "Arch" ] ; then
    INSTALL_COMMAND="pacman -S --noconfirm"

    # update repositories
    sudo pacman -Syy

    DISTRO_SPECIFIC_PACKAGES="yay discord bat neovim"
fi


sudo $INSTALL_COMMAND \
    xclip code \
    keepassxc \
    htop tree \
    pavucontrol \
    qbittorrent \
    thunderbird \
    docker docker-compose \
    zsh fzf \
    chromium \
    vlc \
    texlive texlive-science texlive-latex-extra texlive-lang-portuguese latexmk texlive-bibtex-extra biber \
    openjdk-11-jdk openjdk-11-doc openjdk-11-source \
    mumble mumble-server avahi-daemon iproute2 jq \
    extract \
    ripgrep \
    curl \
    ca-certificates gnupg lsb-release \
    make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    $DISTRO_SPECIFIC_PACKAGES


if [ $DISTRO = "Debian" ] ; then
    sudo /sbin/isenkram-autoinstall-firmware

    wget -O /tmp/slack.deb https://downloads.slack-edge.com/releases/linux/4.23.0/prod/x64/slack-desktop-4.23.0-amd64.deb
    sudo apt install -y /tmp/slack.deb

    wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz
    sudo tar -xzf /tmp/postman.tar.gz -C /opt
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
    sudo sh -c "echo '[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;' > /usr/local/share/applications/Postman.desktop"

    #sudo snap install pycharm-professional --classic
    #sudo snap install clion --classic
    #sudo snap install intellij-idea-ultimate --classic
    #sudo snap install goland --classic

    # install latest neovim
    wget -P /tmp https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    (
        cd /tmp
        ./nvim.appimage --appimage-extract
        cd squashfs-root/usr
        find . -type f -exec install -Dm 755 "{}" "/usr/{}" \;
    )

elif [ $DISTRO = "Arch" ] ; then
    yay -S spotify brave-bin
fi

sudo /sbin/usermod -a -G docker $USER

sudo sh -c "systemctl stop mumble-server.service && systemctl disable mumble-server.service"

# vim
ln -s ~/dotfiles/vim/dotvim ~/.vim
ln -s ~/dotfiles/vim/nvim ~/.config/nvim
ln -s ~/dotfiles/vim/ideavimrc.vim ~/.ideavimrc
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

# vs code
mkdir -p ~/.config/Code/User
rm -f ~/.config/Code/User/settings.json
ln -s ~/dotfiles/vscode-settings.json ~/.config/Code/User/settings.json
code --install-extension jdinhlife.gruvbox
code --install-extension vscodevim.vim

# nerdfonts
git clone https://github.com/ryanoasis/nerd-fonts /tmp/nerd-fonts
/tmp/install.sh SourceCodePro
rm -rf /tmp/nerd-fonts

# zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  # this will change the default shell
rm ~/.zshrc  # the intallation of ohmyzsh creates a default zshrc file
ln -s ~/dotfiles/shells/zsh/zshrc.zsh ~/.zshrc
ln -s ~/dotfiles/shells/profile.sh ~/.profile
ln -s ~/.profile ~/.zprofile
git clone https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## version manangers
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# bins
for bin in $(ls --color=no ~/dotfiles/bins) ; do
    sudo ln -s "$HOME/dotfiles/bins/$bin" "/usr/local/bin/$bin"
done

# git
ln -s ~/dotfiles/gitconfig ~/.gitconfig

# konsole
rm -f ~/.config/konsolerc
ln -s ~/dotfiles/konsole/konsolerc ~/.config/konsolerc
mkdir -p ~/.local/share/konsole
for profile in $(ls --color=no ~/dotfiles/konsole/profiles) ; do
    ln -s ~/dotfiles/konsole/profiles/$profile ~/.local/share/konsole/$profile
done

# increase the number of open files. usefull for Jetbrains IDEs
sudo sh -c 'echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf && sysctl -p --system'

# remove unused packages
if [ $DISTRO = "Debian" ] ; then
    sudo sh -c "apt purge plasma-discover plasma-discover-common isenkram-cli && apt autoremove -y"
fi

echo "Next manual steps:"
echo "- Deactivate clipboard app thingy"
echo "- Install gruvbox konsole theme"
echo "- Setup github ssh key"
echo "- Install go"
