#!/bin/bash
set -e

# Install stow if missing
sudo pacman -S --needed stow
DOTFILES_DIR="$HOME/dotfiles"

packages=(nvim yazi zellij ghostty zsh)
sudo pacman -S --needed "${packages[@]}"

for pkg in "${packages[@]}"; do
  echo "Stowing $pkg..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "Done!"
