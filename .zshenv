# NVM directory
export NVM_DIR="$HOME/.nvm"

# Vagrant config needed inside WSL2
export VAGRANT_DEFAULT_PROVIDER="hyperv"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

export EDITOR=vim
export KUBE_EDITOR=vim
export BROWSER=wslview

if [ -e /home/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /home/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
