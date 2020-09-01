# Installation (manjaro + kde)

```sh
cd $HOME && git clone --recurse-submodules -j8 https://github.com/aspedrosa/dotfiles

# remove unwanted packages
sudo pacman -Rsnu \
    vim \
    pamac-gtk pamac-tray-appindicator \
    clipit
    palemoon-bin \
    epdfview


# install common packages
sudo pacman -Suy \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    gvim \
    yay \
    brave \
    manjaro-settings-manager \
    keepass \
    evince \
    #python-xdg python-pexpect \
    texlive-core texlive-latexextra texlive-science \
    deluge \
    base-devel \
    vlc \
    python-pip \
    docker docker-compose \
    jdk8-openjdk jdk11-openjdk java-environment-common java-runtime-common \
    tree

yay \
    spotify \
    slack \
    marktext


# create simbolic links to config files
ln -s $HOME/dotfiles/aliases.sh $HOME/.bash_aliases

ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/vimrc.vim $HOME/.vimrc

ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/oh-my-zsh $HOME/.oh-my-zsh

ln -s $HOME/dotfiles/vscode/settings.json $HOME/.config/Code\ -\ OSS/User/settings.json
rmdir $HOME/.config/Code\ -\ OSS/User/snippets
ln -s $HOME/dotfiles/vscode/snippets $HOME/.config/Code\ -\ OSS/User/snippets


# redirect vi to vim
mv /usr/bin/vi /usr/bin/vi.bak
ln -s /usr/bin/vim /usr/bin/vi

# place all bins on PATH
cp $HOME/dotfiles/bins/\* $HOME/.local/bin
for f in $(ls $HOME/dotfiles/bins/) ; do
    chmod +x $HOME/.local/bin/$f
done

# directory to place program files (ex: pycharm)
mkdir $HOME/programs

# konsole font
yay nerd-fonts-source-code-pro

# change default shell to zsh
sudo chsh --shell /bin/zsh $USER

# upgrade pip
pip install --upgrade pip

# add user to docker group so he can
#  execute commands without sudo
gpasswd -a $USER docker
```

# Java

1. download jdks
2. place their extracted content in /usr/lib/jvm
3. archlinux-java set <folder_of_java_to_use>

# Virtualbox

```sh
sudo pacman -S virtualbox
# if not already installed vv
sudo pacman -S [kernel version]-virtualbox-host-modules
sudo modprobe vboxdrv
yay virtualbox-ext-oracle # MUST BE THE SAME VERSION OF THE VIRTUALBOX PACKAGE
sudo groupadd vboxusers
sudo usermod -aG vboxusers $USER
```

# Disable clipboard on kde

1. Right click on the arrow on the system tray
2. System tray settings
3. clipboard -> disable

# Disable kde ballo

Follow this [link](https://archived.forum.manjaro.org/t/baloo-file-extractor-running-wild-until-all-ram-is-used-and-computer-freezes/47545/17).

```sh
balooctl disable
```

# Disable screen locking on KDE

1. System settings

2. Workspace

3. Workspace Behavior

4. Screen locking

# i3 specific installation steps
```sh
sudo pacman -S
  termite

# set termite as default terminal
sudo sh -c 'echo "#!/bin/sh

termite $@" > /usr/bin/terminal'


# create simbolic links to i3 config files
ln -s $HOME/dotfiles/i3/i3 $HOME/.i3
ln -s $HOME/dotfiles/i3/i3status.conf $HOME/.i3status.conf

# create simbolic links to termite config files
ln -s $HOME/dotfiles/termite $HOME/.conf/termite
```
