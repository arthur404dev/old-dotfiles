# NVM directory
export NVM_DIR="$HOME/.nvm"

# Vagrant config needed inside WSL2
$IS_WSL && export VAGRANT_DEFAULT_PROVIDER="hyperv"
$IS_WSL && export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
$IS_WSL && export BROWSER=wslview

export EDITOR=nvim
export KUBE_EDITOR=nvim

if [ -e /home/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /home/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
