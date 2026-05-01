#!/bin/bash
set -e

# Install stow if missing
sudo pacman -S --needed stow
DOTFILES_DIR="$HOME/dotfiles"

packages=(nvim yazi zellij ghostty zsh)
external_dependencies=(inxi ripgrep wget luarocks cmake tree-sitter-cli nodejs npm python-pynvim lazygit manpages inxi)
sudo pacman -S --needed "${packages[@]}"
sudo pacman -S --needed "${external_dependencies[@]}"

for pkg in "${packages[@]}"; do
  echo "Stowing $pkg..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "Remember to use lazygit"
echo "Done!"
