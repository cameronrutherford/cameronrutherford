# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.251/quarto-1.4.251-linux-amd64.tar.gz
RUN tar -xvzf quarto-1.4.251-linux-amd64.tar.gz
# I don't really like how this works, but it works...
ENV PATH=$PATH:/quarto-1.4.251/bin

# I guess I need Jupyter
RUN pipx install --upgrade pip && \
    pipx install jupyter
