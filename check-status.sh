#!/bin/bash

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Neovim config is not a git repo?!"
    exit 1
fi

if ! git diff --quiet; then
    echo "There are unstaged changes in the neovim config."
    exit 1
fi

if ! git diff --cached --quiet; then
    echo "There are staged but uncommitted changes in the neovim config."
    exit 1
fi

# Get current branch
branch=$(git symbolic-ref --short HEAD)

# Check if local branch is ahead/behind remote
status=$(git status -sb | head -n1)
if [[ $status == *"ahead"* ]]; then
    echo "Local neovim config branch is ahead of origin/$branch. Push required."
    exit 1
elif [[ $status == *"behind"* ]]; then
    echo "Local neovim config branch is behind origin/$branch. Pull required."
    exit 1
fi

exit 0

