#!/bin/bash

# Install username/email for convenience
git config --global --add safe.directory /home/app
git config --global user.email "cameron.rutherford@me.com"
git config --global user.name "cameronrutherford"

# Install pre-commit hooks
cd /home/app
# If poetry is installed, run with that. Otherwise just try running
poetry run pre-commit install --install-hooks || pre-commit install --install-hooks
