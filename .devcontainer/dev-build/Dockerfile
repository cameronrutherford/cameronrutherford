# syntax=docker/dockerfile:1.3-labs
# ^ Need this for syntax specific to heredoc aliases
# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm
ENV QUARTO_VERSION=1.6.11
RUN apt-get update && \
  apt-get install -y --no-install-recommends fontconfig=2.14.1-4 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Tex Live - this isn't 100% reproducible, but the build will always work and update...
RUN  curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN zcat < install-tl-unx.tar.gz | tar xf -
RUN rm install-tl-unx.tar.gz
RUN mv "$(find . -maxdepth 1 -type d -regex ".*install-tl.*")" ./install-tlmgr
WORKDIR /install-tlmgr
RUN perl ./install-tl --no-interaction --scheme=small --no-doc-install --no-src-install
# 2024 might break first
ENV PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
WORKDIR /

# Update tlmgr - https://www.tug.org/texlive/tlmgr.html
# Also install any other extensions that are used
#   - This was trial and error as far as I can tell
RUN tlmgr update --self --all && \
  tlmgr install tcolorbox \
  environ \
  tikzfill \
  titlesec \
  xstring \
  pdfcol \
  fontawesome5

# Install pre-commit CLI
RUN pip install --no-cache-dir pre-commit==3.7.0

# Configure aliases with a heredoc
COPY <<-"end_aliases" /home/vscode/.bash_aliases
#!/bin/bash
alias ll="ls -alF"
alias gg="git log --graph --oneline --color"
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


# Install quarto
RUN curl -L -o quarto-${QUARTO_VERSION}-linux-amd64.tar.gz  https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz \
  && tar -xvzf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz \
  && rm quarto-${QUARTO_VERSION}-linux-amd64.tar.gz

# Configure PATH
ENV PATH=$PATH:/quarto-${QUARTO_VERSION}/bin

# When running locally, we really need to expose a port
EXPOSE 8080
