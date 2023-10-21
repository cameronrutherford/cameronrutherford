# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Install poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -
ENV PATH=$PATH:/etc/poetry/bin

# Install poetry environment
WORKDIR /home
COPY .devcontainer/blog-pythonInterview/pyproject.toml .

# `cache-dir` is critical here to have user `vscode` have things installed
ENV POETRY_CACHE_DIR=/home/vscode/poetry-cache
RUN echo "poetry shell" >> /home/vscode/.bashrc

# Since we aren't packaging anything, just adding dependencies
RUN poetry install --no-root --no-interaction --no-directory

# Install ipykernel so it's available to jupyter(?)
RUN poetry run python3 -m ipykernel install \
        --name py311-interview \
        --display-name "LeetCode" \
        --prefix=$(which jupyter)
