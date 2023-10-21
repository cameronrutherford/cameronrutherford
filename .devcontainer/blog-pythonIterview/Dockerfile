# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Setup python venv for usage
# TODO: 
#   - requirements.txt / poetry?
#   - consolidate with pre-commit in base?
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir watermark \
                               jupyterlab
