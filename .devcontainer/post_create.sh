#!/usr/bin/env bash
set -euo pipefail

ln -sf /app/.devcontainer/.bashrc "$HOME/.bashrc"
ln -sf /app/.devcontainer/.tmux.conf "$HOME/.tmux.conf"

git config --global --add safe.directory /app

uv sync
uv run pre-commit install

# GIT CONFIGS
git config --global user.email $GIT_USER_EMAIL
git config --global user.name $GIT_USER_NAME
git config --global core.editor 'vim'
git config --global alias.pushf 'push --force-with-lease'
git config --global alias.acpf '!git add . && git commit && git pushf'
git config --global alias.re '!git fetch && git rebase origin/main && git pushf'
git config --global alias.re2 '!git fetch && git rebase origin/main && git rebase -i HEAD~2 && git pushf'
git config --global pull.rebase true
git config --global push.default current

echo "Dev container post-creation setup complete."
