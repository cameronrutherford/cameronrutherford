# Home Page

## About

This origin file is `personal-repo.qmd`. I render this using
[Quarto](https://quarto.org/), and build with
[VSCode](https://vscode.dev/) using a [Development
Container](https://containers.dev/).

## Quick Start

Install [Docker](https://www.docker.com/), VSCode, and configure the
[Dev Container
Extension](https://code.visualstudio.com/docs/devcontainers/containers).
Then using the command pallette, build the container and open this
folder.

## Dev Container Configuration

I used Python as the base image, and then install Quarto in the
Dockerfile:

``` Dockerfile
# Lets use the latest Python (3.11 was latest at the time)
# https://github.com/devcontainers/images/tree/main/src/python
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.251/quarto-1.4.251-linux-amd64.tar.gz
RUN tar -xvzf quarto-1.4.251-linux-amd64.tar.gz
# I don't really like how this works, but it works...
ENV PATH=$PATH:/quarto-1.4.251/bin

# Install quarto extensions
RUN quarto add --no-prompt quarto-ext/include-code-files
```

## Quarto Configuration

### Workflow

Build and render the project using:

``` bash
quarto render && quarto preview
```

### Extensions

These all are installed manually from the command line, and are not
included in the Dockerfile. This is because the whole extesion ecosystem
works through the `_extensions` directory.

To install the first extension, I ran:

``` bash
quarto add --no-prompt quarto-ext/include-code-files
```

- \[\]`include-code-files`\](https://github.com/quarto-ext/include-code-files)
