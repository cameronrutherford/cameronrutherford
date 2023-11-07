# From : https://github.com/mirzaim/cuda-devcontainer/blob/main/.devcontainer/Dockerfile
# Initial setup : https://docs.nvidia.com/ai-enterprise/deployment-guide-vmware/0.1.0/docker.html
# Devcontainer config :
#   - https://github.com/devcontainers/features/tree/main/src/common-utils#example-usage
#   - https://github.com/mirzaim/cuda-devcontainer/blob/main/.devcontainer/devcontainer.json
# NOTES:
#   - I had to upgrade CUDA, and install Docker within WSL
#   - Maxwell GPUs (the one that I have) isn't officially supported, but we will see what we can do

ARG VARIANT="ubuntu20.04"
ARG CUDA_VERSION="11.0.3"
FROM nvidia/cuda:${CUDA_VERSION}-devel-${VARIANT}

# Let's get Python into the container
RUN apt-get -yqq update && \
    apt-get -yqq upgrade && \
    apt-get -yqq install python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install pre-commit CLI
RUN pip3 install pre-commit

# Configure aliases with a heredoc
COPY <<-"end_aliases" /home/vscode/.bash_aliases
#!/bin/bash
alias ll="ls -alF"
alias gg="git log --graph --oneline --color --all"
alias gc="git commit"
alias gck="git checkout"
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gf="git fetch --all"
alias gp="git push"
alias grs="git reset --hard"
end_aliases

RUN mkdir -p /home/app
