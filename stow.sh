#!/bin/bash
set -e

# Install stow if missing
sudo pacman -S --needed stow

DOTFILES_DIR="$HOME/dotfiles"

packages=(nvim yazi zellij kitty zsh)

for pkg in "${packages[@]}"; do
  echo "Stowing $pkg..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "Done! Install Oh My Zsh separately if needed."
