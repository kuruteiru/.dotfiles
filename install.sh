#!/bin/bash

# todo: use stow

DOTFILES_DIR=~/.dotfiles
CONFIG_DIR=~/.config

ln -sfT $DOTFILES_DIR/bash/bashrc ~/.bashrc
ln -sfT $DOTFILES_DIR/waybar $CONFIG_DIR/waybar
ln -sfT $DOTFILES_DIR/ghostty $CONFIG_DIR/ghostty
ln -sfT $DOTFILES_DIR/kitty $CONFIG_DIR/kitty
ln -sfT $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
ln -sfT $DOTFILES_DIR/sway $CONFIG_DIR/sway
ln -sfT $DOTFILES_DIR/hypr $CONFIG_DIR/hypr
ln -sfT $DOTFILES_DIR/zathura $CONFIG_DIR/zathura

ln -sfT $DOTFILES_DIR/tmux $CONFIG_DIR/tmux
git rm $CONFIG_DIR/tmux/plugins/*
git submodule add 
git submodule add -f https://github.com/tmux-plugins/tpm.git tmux/plugins/tpm
git submodule init
git submodule update
$(eval $XDG_CONFIG_HOME/tmux/plugins/tpm/bin/clean_plugins)
./tmux/plugins/tpm/bin/install_plugins
./tmux/plugins/tpm/bin/update_plugins
command -v tmuxifier &> /dev/null && {
	ln -sfT $DOTFILES_DIR/tmux/plugins/tmuxifier/bin/tmuxifier /usr/bin/tmuxifier
}

# needs to be used with root privilages, but when calling this script with sudo, the DOTFILES_DIR is /root/.dotfiles
# sudo ln -sf $DOTFILES_DIR/dnf/dnf.conf /etc/dnf/dnf.conf

if [[ -d "$FIREFOX_PROFILES_DIR" ]]; then
  for PROFILE in "$FIREFOX_PROFILES_DIR"/*-default; do
    if [[ -d "$PROFILE" ]]; then
      ln -sf "$DOTFILES_DIR/chrome" "$PROFILE/chrome"
    fi
  done
fi
