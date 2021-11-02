#!/bin/sh

# TODO
# - diactivate clipboard app thing
# - install gruvbox konsole theme
# - setup github ssh key

balooctl disable

# docker repos
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# brave repos
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo sed -i "/^deb|^deb-src/s/#/ contrib non-free/" /etc/apt/source.list
sudo apt update

sudo apt install -y \
    neovim \
    keepass2 \
    htop tree \
    pavucontrol \
    qbittorrent \
    docker docker-compose \
    zsh \
    brave-browser chromium \
    extract \
    snapd \
    isenkram-cli \
    curl \
    ca-certificates gnupg lsb-release \
    make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \

sudo snap install slack --classic
sudo snap install pycharm-professional --classic
sudo snap install clion --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install goland --classic
sudo snap install code --classic
sudo snap install spotify

sudo /sbin/usermod -a -G docker $USER

sudo /sbin/isenkram-autoinstall-firmware

git clone --recurse-submodules -j8 git@github.com:aspedrosa/dotfiles.git ~/dotfiles

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
ln -s ~/dotfiles/vim ~/.vim
mkdir -p .config/nvim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/ideavimrc.vim ~/.ideavimrc

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
ln -s ~/dotfiles/shells/zsh/zprofile.zsh ~/.zprofile
ln -s ~/dotfiles/shells/profile.sh ~/.profile
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

sudo sh -c "apt purge -y plasma-discover plasma-discover-common isenkram-cli && apt autoremove -y"
