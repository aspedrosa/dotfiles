# Installation - Debian

1. During the installation process some don't select any desktop environment, as it might install unnecessary software.

2. Login as root

   1. `sudo apt install -y git ansible vim sudo tmux`
   2. `usermod -aG sudo aspedrosa`

3. Login as User

   1. `tmux`
   2. `git clone https://github.com/aspedrosa/dotfiles`
   3. `ansible-playbook init_debian.yaml --ask-become-pass`

4. Reboot

5. `ansible-playbook finish_debian.yaml --ask-become-pass`

6. Reboot

7. Manual stuff

   1. Disable clipboard app thingy
   2. Install teams through web (||| -> "More Tools" -> "Create Shortcut")