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
   2. Task bar
      1. Remove builtin pager
      2. Add i3-pager to the task bar
      4. Edit i3-pager configs: 1) Order by: Name 2) Indicator style: Border
      3. Edit "Icons-only" settings: 1) Remove Grouping 2) Remove mouse wheel behavior 3) Max rows 1
   3. Install teams through web (||| -> "More Tools" -> "Create Shortcut")