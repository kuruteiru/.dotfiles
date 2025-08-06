#!/bin/bash

# todo: use stow

DOTFILES_DIR=~/.dotfiles

ln -sfT $DOTFILES_DIR/bash/bashrc ~/.bashrc
ln -sfT $DOTFILES_DIR/kitty ~/.config/kitty
ln -sfT $DOTFILES_DIR/ghostty ~/.config/ghostty
ln -sfT $DOTFILES_DIR/nvim ~/.config/nvim
ln -sfT $DOTFILES_DIR/sway ~/.config/sway
ln -sfT $DOTFILES_DIR/hypr ~/.config/hypr
ln -sfT $DOTFILES_DIR/waybar ~/.config/waybar
ln -sfT $DOTFILES_DIR/zathura ~/.config/zathura

ln -sfT $DOTFILES_DIR/tmux ~/.config/tmux
ln -sfT $DOTFILES_DIR/tmux/plugins/tmuxifier/bin/tmuxifier /usr/bin/tmuxifier

# dev window symlink
ln -sfT $DOTFILES_DIR/tmux/dev.window.sh $DOTFILES_DIR/tmux/plugins/tmuxifier/layouts/dev.window.sh

# needs to be used with root privilages, but when calling this script with sudo, the DOTFILES_DIR is /root/.dotfiles
# sudo ln -sf $DOTFILES_DIR/dnf/dnf.conf /etc/dnf/dnf.conf

if [[ -d "$FIREFOX_PROFILES_DIR" ]]; then
  for PROFILE in "$FIREFOX_PROFILES_DIR"/*-default; do
    if [[ -d "$PROFILE" ]]; then
      ln -sf "$DOTFILES_DIR/chrome" "$PROFILE/chrome"
    fi
  done
fi
