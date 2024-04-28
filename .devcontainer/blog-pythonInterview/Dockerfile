# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
# hadolint ignore= DL3007
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Install poetry
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -
ENV PATH=$PATH:/etc/poetry/bin
RUN echo "poetry shell" >> /home/vscode/.bashrc

# Install poetry environment
WORKDIR /home

# Configure pyproject.toml with heredoc
# That way changes to the config force a re-build with correct deps
# Also eliminates filepath issues copying between projects...
COPY <<-"end_toml" ./pyproject.toml
[tool.poetry]
name = "python_coding_interview"
description = "Minimal Python environment for Jupyter Python practice"
version = "0.1.0"
authors = [
    "Cameron Rutherford"
]

[tool.poetry.dependencies]
python = ">=3.11"
jupyterlab = "*"
watermark = "*"
end_toml

# `cache-dir` is critical here to have user `vscode` have things installed
ENV POETRY_CACHE_DIR=/home/vscode/poetry-cache

# Since we aren't packaging anything, just adding dependencies
RUN poetry install --no-root --no-interaction --no-directory && \
  # Also install ipyknernel so it's visible in jupyter
  "poetry run python3 -m ipykernel install \
  --name py311-interview \
  --display-name \"LeetCode\" \
  --prefix=$(which jupyter)"
