# Install

```sh
cd $HOME && git clone --recurse-submodules -j8 https://github.com/aspedrosa/dotfiles

sudo pacman -Rs vim pamac-gtk clipit palemoon-bin epdfview
sudo pacman -Suy termite zsh gvim yay brave git java-environment-common \
        java-runtime-common manjaro-settings-manager keepass evince gcc python-xdg python-pexpect \
        texlive-core texlive-latexextra texlive-science
yay fluxgui

ln -s $HOME/dotfiles/bashrc.sh $HOME/.bashrc
ln -s $HOME/dotfiles/aliases.sh $HOME/.bash_aliases

ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/vimrc.vim $HOME/.vimrc

ln -s $HOME/dotfiles/i3/i3 $HOME/.i3
ln -s $HOME/dotfiles/i3/i3status.conf $HOME/.i3status.conf

ln -s $HOME/dotfiles/termite $HOME/.conf/termite

ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/oh-my-zsh $HOME/.oh-my-zsh

ln -s $HOME/dotfiles/vscode/settings $HOME/.config/Code\ -\ OSS/User/settings.json
ln -s $HOME/dotfiles/vscode/snippets $HOME/.config/Code\ -\ OSS/User/snippets

sudo sh -c 'echo "#!/bin/sh

termite $@" > /usr/bin/terminal'

cp $HOME/dotfiles/bins/\* $HOME/.local/bin
for f in $(ls $HOME/dotfiles/bins/) ; do
    chmod +x $HOME/.local/bin/$f
done

echo "
setxkbmap -option caps:swapescape
" >> $HOME/.profile
// set vim as editor con be set on .profile

mkdir $HOME/programs

sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting 

yay nerd-fonts-ubuntu-mono
fc-cache -vf

sudo chsh --shell /bin/zsh aspedrosa

# how to install java
# 1. download jdks
# 2. place their extracted content in /usr/lib/jvm
# 3. archlinux-java set <folder_of_java_to_use>


# virtualbox
sudo pacman -S virtualbox
# if not already installed vv
sudo pacman -S [kernel version]-virtualbox-host-modules
sudo modprobe vboxdrv
yay virtualbox-ext-oracle # MUST BE THE SAME VERSION OF THE VIRTUALBOX PACKAGE
sudo groupadd vboxusers
sudo usermod -aG vboxusers $USER
```
