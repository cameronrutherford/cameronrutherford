#!/bin/bash

set -e
set -x

# Configure pre-commit hooks\
# It would nice to have this be a part of the container, but it is nice to be able to disable
cd /workspaces/personal-repo
git config --global --add safe.directory /workspaces/personal-repo
pre-commit install-hooks

# Configure git config so I can at least commit things
# Should push/pull outside of a container for sure
git config --global user.email "cameron.rutherford@me.com"
git config --global user.name "CameronRutherford"

set +x
