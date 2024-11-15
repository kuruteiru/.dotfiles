#!/bin/bash

DOTFILES_DIR=~/.dotfiles

ln -sf $DOTFILES_DIR/dnf/dnf.conf /etc/dnf/dnf.conf
ln -sf $DOTFILES_DIR/kitty ~/.config/kitty
ln -sf $DOTFILES_DIR/nvim ~/.config/nvim
ln -sf $DOTFILES_DIR/sway ~/.config/sway
ln -sf $DOTFILES_DIR/waybar ~/.config/waybar

if [[ -d "$FIREFOX_PROFILES_DIR" ]]; then
  for PROFILE in "$FIREFOX_PROFILES_DIR"/*-default; do
    if [[ -d "$PROFILE" ]]; then
      ln -sf "$DOTFILES_DIR/chrome" "$PROFILE/chrome"
    fi
  done
fi
