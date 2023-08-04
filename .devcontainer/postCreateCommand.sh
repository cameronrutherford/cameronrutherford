#!/bin/bash

set -e
set -x

# Configure pre-commit hooks and dependencies
# TODO - make this a part of the container build process...
cd /workspaces/personal-repo
git config --global --add safe.directory /workspaces/personal-repo
git config --global user.email "cameron.rutherford@me.com"
git config --global user.name "CameronRutherford"
pre-commit install-hooks

# Configure some simple git/other aliases
echo "alias ll='ls -alF'" >> ~/.bashrc
echo "alias gg='git log --graph --oneline --color --all'" >> ~/.bashrc
echo "alias gc='git commit'" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
echo "alias ga='git add'" >> ~/.bashrc
echo "alias gd='git diff'" >> ~/.bashrc

# NOTE - it will be easier to manage git outside of the container for security purposes...

set +x
