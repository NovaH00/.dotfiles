#!/bin/bash
set -e  # Exit on error

# Paths
NVIM_PATH="$HOME/.config/nvim"
TMUX_PATH="$HOME/.tmux.conf"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "Removing existing configs if they exist..."

# Remove existing Neovim config
rm -rf "$NVIM_PATH"

# Remove existing tmux config
rm -f "$TMUX_PATH"

echo "Installing new configs..."

# Ensure parent directories exist
mkdir -p "$HOME/.config"

# Copy new configs
cp -r "$SCRIPT_DIR/.config/nvim" "$NVIM_PATH"
cp "$SCRIPT_DIR/.tmux.conf" "$TMUX_PATH"

echo "Installation complete."
