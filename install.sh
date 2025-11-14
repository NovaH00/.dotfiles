#!/bin/bash
set -e  # Exit on error

# Random 4-character lowercase+number ID
id=$(tr -dc a-z0-9 </dev/urandom | head -c 4)
echo "Backup ID: $id"

# Paths
NVIM_PATH="$HOME/.config/nvim"
NVIM_BACKUP="$HOME/.config/nvim.bak-$id"
TMUX_PATH="$HOME/.tmux.conf"
TMUX_BACKUP="$HOME/.tmux.conf.bak-$id"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Backup Neovim
if [ -d "$NVIM_PATH" ]; then
    mv "$NVIM_PATH" "$NVIM_BACKUP"
    echo "Backed up $NVIM_PATH to $NVIM_BACKUP"
else
    echo "Directory $NVIM_PATH does not exist, skipping Neovim backup."
fi

# Backup tmux
if [ -f "$TMUX_PATH" ]; then
    mv "$TMUX_PATH" "$TMUX_BACKUP"
    echo "Backed up $TMUX_PATH to $TMUX_BACKUP"
else
    echo "File $TMUX_PATH does not exist, skipping tmux backup."
fi

echo "Backup complete. Installing..."

# Ensure parent directories exist
mkdir -p "$HOME/.config"

# Copy new configs
cp -r "$SCRIPT_DIR/.config/nvim" "$NVIM_PATH"
cp "$SCRIPT_DIR/.tmux.conf" "$TMUX_PATH"

echo "Installation complete."

