# syntax=docker/dockerfile:1.3-labs
# ^ Need this for syntax specific to heredoc aliases
# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.358/quarto-1.4.358-linux-amd64.tar.gz
RUN tar -xvzf quarto-1.4.358-linux-amd64.tar.gz
ENV PATH=$PATH:/quarto-1.4.358/bin

# Install Tex Live - this isn't 100% reproducible, but the build will always work and update...
RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN zcat < install-tl-unx.tar.gz | tar xf -
RUN mv $(find . -maxdepth 1 -type d -regex ".*install-tl.*") ./install-tlmgr
WORKDIR /install-tlmgr
RUN perl ./install-tl --no-interaction --scheme=small --no-doc-install --no-src-install
# 2023 might break first
ENV PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux
WORKDIR /

# Install extras with apt
RUN apt update && \
    apt install -y fontconfig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Update tlmgr - https://www.tug.org/texlive/tlmgr.html
# Also install any other extensions that are used - this is trial and error as far as I can tell
RUN tlmgr update --self --all && \
    tlmgr install tcolorbox \
                  environ \
                  tikzfill \
                  titlesec \
                  xstring \
                  pdfcol \
                  fontawesome5

# Install pre-commit CLI
RUN pip install pre-commit

# Install pre-commit hooks
WORKDIR /home/app
COPY .pre-commit-config.yaml .
RUN git init .
RUN pre-commit install --install-hooks
WORKDIR /

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
alias qrp="quarto render && quarto preview"
end_aliases
