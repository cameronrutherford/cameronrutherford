#!/bin/bash

if [[ $1 -eq "-f" ]]; then
  rm -rf ./docs
fi

PULL=false
CHARLIECLOUD=true
CMDS=("quarto render --profile onepager" "quarto render" "quarto preview --port 8080 --no-browser --host 0.0.0.0")

if $PULL == "true"; then
  ch-image pull ghcr.io/cameronrutherford/quarto-ci
fi

RUN_CMD="ch-run ghcr.io/cameronrutherford/quarto-ci \
  --bind=$PWD:/home/app/ -W -c /home/app \
  --set-env=PATH=/bin:/usr/local/texlive/latest/bin/x86_64-linux:/quarto/bin -- "

for CMD in "${CMDS[@]}"; do
  if $CHARLIECLOUD == "true"; then
    $RUN_CMD $CMD
  else
    $CMD
  fi
done
