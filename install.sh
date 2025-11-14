#!/usr/bin/bash
set -e  # Exit on error

# Ensure the script is run from the repo root
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR"

echo "Checking if the repository is up-to-date..."

# Fetch latest changes
git fetch origin main

# Compare local HEAD with remote
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Repository is not up-to-date. Pulling latest changes..."
    git pull
else
    echo "Repository is already up-to-date."
fi

echo "Removing existing configs if they exist..."

# Paths
NVIM_PATH="$HOME/.config/nvim"
TMUX_PATH="$HOME/.tmux.conf"

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

