#!/bin/bash

if [[ $1 -eq "-f" ]]; then
  rm -rf ./docs
fi

PULL=false
CMD="quarto render --profile onepager && quarto render && quarto preview --port 8080 --no-browser --host 0.0.0.0"

if $PULL == "true"; then
  ch-image pull ghcr.io/cameronrutherford/quarto-ci
fi
ch-run ghcr.io/cameronrutherford/quarto-ci --bind=$PWD:/home/app/ -W \
  -c /home/app -- /bin/bash
