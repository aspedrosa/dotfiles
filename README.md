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

