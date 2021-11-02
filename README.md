# Installation

```sh
curl https://raw.githubusercontent.com/aspedrosa/dotfiles/master/README.md | sh
```

# Useful instructions

## Disable clipboard on kde

1. Right click on the arrow on the system tray
2. System tray settings
3. clipboard -> disable

## Virtualbox

```sh
sudo pacman -S virtualbox
# if not already installed vv
sudo pacman -S [kernel version]-virtualbox-host-modules
sudo modprobe vboxdrv
yay virtualbox-ext-oracle # MUST BE THE SAME VERSION OF THE VIRTUALBOX PACKAGE
sudo groupadd vboxusers
sudo usermod -aG vboxusers $USER
```

## Disable screen locking on KDE

1. System settings

2. Workspace

3. Workspace Behavior

4. Screen locking

## Problems with touchpad

https://askubuntu.com/a/947782

## i3 specific installation steps
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
