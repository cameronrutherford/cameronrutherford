# syntax=docker/dockerfile:1.3-labs
# ^ Need this for syntax specific to heredoc aliases
# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Need fontconfig for Quarto, and then jq to help with auto-getting latest version
# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  fontconfig \
  jq && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Tex Live
RUN curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN zcat < install-tl-unx.tar.gz | tar xf -
RUN rm install-tl-unx.tar.gz
RUN mv "$(find . -maxdepth 1 -type d -regex ".*install-tl.*")" ./install-tlmgr
WORKDIR /install-tlmgr
# hadolint ignore=SC2046
RUN perl ./install-tl --no-interaction --scheme=small --no-doc-install --no-src-install && \
    echo "export PATH=${PATH}:/usr/local/texlive/$(date +%Y)/bin/x86_64-linux" >> /etc/bash.bashrc
WORKDIR /

# Update tlmgr - https://www.tug.org/texlive/tlmgr.html
# Also install any other extensions that are used
#   - This was trial and error as far as I can tell
# hadolint ignore=SC2046
RUN /usr/local/texlive/$(date +%Y)/bin/x86_64-linux/tlmgr \
  update --self --all && \
  /usr/local/texlive/$(date +%Y)/bin/x86_64-linux/tlmgr install \
    tcolorbox \
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
# Just get the latest version
# hadolint ignore=SC2086
RUN QUARTO_VERSION=$(curl https://quarto.org/docs/download/_download.json | jq -r '.version') \
  && curl -L -o quarto-${QUARTO_VERSION}-linux-amd64.tar.gz  https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz \
  && tar -xvzf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz \
  && rm quarto-${QUARTO_VERSION}-linux-amd64.tar.gz \
  && echo "export PATH=${PATH}:/quarto-${QUARTO_VERSION}/bin" >> /etc/bash.bashrc

# When running locally, we really need to expose a port
EXPOSE 8080
