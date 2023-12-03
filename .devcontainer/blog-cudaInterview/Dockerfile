# From : https://github.com/mirzaim/cuda-devcontainer/blob/main/.devcontainer/Dockerfile
# Initial setup : https://docs.nvidia.com/ai-enterprise/deployment-guide-vmware/0.1.0/docker.html
# Devcontainer config :
#   - https://github.com/devcontainers/features/tree/main/src/common-utils#example-usage
#   - https://github.com/mirzaim/cuda-devcontainer/blob/main/.devcontainer/devcontainer.json
# NOTES:
#   - I had to upgrade CUDA, and install Docker within WSL
#   - Maxwell GPUs (the one that I have) isn't officially supported, but we will see what we can do
#   - This container was being weird with permissions, so running it as root.
ARG VARIANT="ubuntu20.04"
ARG CUDA_VERSION="11.0.3"
FROM nvidia/cuda:${CUDA_VERSION}-devel-${VARIANT}

RUN mkdir -p /home/app

# Let's get Python into the container
RUN apt-get -yqq update && \
    apt-get -yqq upgrade && \
    apt-get -yqq install python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install poetry
ARG POETRY_VERSION="1.7.0"
RUN pip3 install poetry==${POETRY_VERSION}

# Install CUDA deps outside of poetry
# RUN pip3 install \
#    --extra-index-url=https://pypi.nvidia.com \
#     cudf-cu12 dask-cudf-cu12 cuml-cu12 cugraph-cu12 cuspatial-cu12 cuproj-cu12 cuxfilter-cu12 cucim

# Install poetry environment
WORKDIR /home

# Configure pyproject.toml with heredoc
# That way changes to the config force a re-build with correct deps
# Also eliminates filepath issues copying between projects...
# NOTE - require 3.10 since 3.11 isn't quite supported in Ubuntu 22.04
COPY <<-"end_toml" /home/pyproject.toml
[tool.poetry]
name = "python_coding_interview"
description = "Minimal Python environment for CUDA Jupyter practice"
version = "0.1.0"
authors = [
    "Cameron Rutherford"
]

[tool.poetry.dependencies]
python = ">=3.10"
nvccplugin = { git = "https://github.com/andreinechaev/nvcc4jupyter.git" }
jupyterlab = "*"
watermark = "*"
pre-commit = "*"

end_toml

# `cache-dir` is critical here to have user `vscode` have things installed
ENV POETRY_CACHE_DIR=~/poetry-cache
RUN echo "poetry shell" >> ~/.bashrc

# Since we aren't packaging anything, just adding dependencies
RUN poetry install --no-root --no-interaction --no-directory

# Install ipykernel so it's available to jupyter
RUN poetry run python3 -m ipykernel install \
        --name py311-cuda12.2-interview \
        --display-name "CUDA ipykernel" \
        --prefix=$(which jupyter)

# Configure aliases with a heredoc
COPY <<-"end_aliases" ~/.bash_aliases
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
