# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Consider using more sophisticated dep management platform as this gets worse
# Despite what the VSCode docs say, pipx doesn't work
RUN pip3 install pre-commit

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.251/quarto-1.4.251-linux-amd64.tar.gz
RUN tar -xvzf quarto-1.4.251-linux-amd64.tar.gz
# I don't really like how this works, but it works...
ENV PATH=$PATH:/quarto-1.4.251/bin

# Install Tex Live
WORKDIR /tmp
RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN zcat < install-tl-unx.tar.gz | tar xf -
# This will surely break if a newer version is released, but will help with sanity for now
WORKDIR /tmp/install-tl-20230805
# Want to just install the smallest version
RUN perl ./install-tl --no-interaction --scheme=small --no-doc-install --no-src-install
# Another PATH modification never hurt noone
ENV PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux

# Update tlmgr - https://www.tug.org/texlive/tlmgr.html
# Also install any other extensions that are used - this is trial and error as far as I can tell
RUN tlmgr update --self && tlmgr update --all && \
        tlmgr install tcolorbox && \
        tlmgr install environ && \
        tlmgr install tikzfill && \
        tlmgr install pdfcol && \
        tlmgr install fontawesome5

# Configure aliases. This used to be done in the postCreateCommand
# Having it here ensures that aliases are pre-loaded into the container
RUN echo "alias ll='ls -alF'" >> /home/vscode/.bash_aliases
RUN echo "alias gg='git log --graph --oneline --color --all'" >> /home/vscode/.bash_aliases
RUN echo "alias gc='git commit'" >> /home/vscode/.bash_aliases
RUN echo "alias gs='git status'" >> /home/vscode/.bash_aliases
RUN echo "alias ga='git add'" >> /home/vscode/.bash_aliases
RUN echo "alias gd='git diff'" >> /home/vscode/.bash_aliases
RUN echo "alias qrp='quarto render && quarto preview'" >> /home/vscode/.bash_aliases
