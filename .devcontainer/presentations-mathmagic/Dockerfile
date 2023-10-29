# syntax=docker/dockerfile:1.3-labs

# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Install poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -
ENV PATH=$PATH:/etc/poetry/bin

# Install cairo
RUN apt update && \
    apt-get install -y libcairo2-dev \
                       libpango1.0-dev \
                       ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# `cache-dir` is critical here to have user `vscode` have things installed
ENV POETRY_CACHE_DIR=/home/vscode/poetry-cache
RUN echo "poetry shell" >> /home/vscode/.bashrc

# Install poetry environment
WORKDIR /home

# Configure pyproject.toml with heredoc
# That way changes to the config force a re-build with correct deps
# Also eliminates filepath issues copying between projects...
COPY <<-"end_toml" ./pyproject.toml
[tool.poetry]
name = "manim testing"
description = "Environment with manim and other useful installs"
version = "0.1.0"
authors = [
    "Cameron Rutherford"
]

[tool.poetry.dependencies]
python = ">=3.11,<3.12"
jupyterlab = "*"
watermark = "*"
manim = { git = "https://github.com/ManimCommunity/manim.git", branch = "main" }
manim-revealjs = "*"
end_toml

# Since we aren't packaging anything, just adding dependencies
RUN poetry config installer.modern-installation false && \
    poetry install --no-root --no-interaction --no-directory

# Install ipykernel so it's available to jupyter
RUN poetry run python3 -m ipykernel install \
        --name py311-mathMagic \
        --display-name "MathMagic" \
        --prefix=$(which jupyter)
