#!/bin/bash

case $1 in
-q)
  CMDS=("quarto render --profile onepager")
  PRVW=("cmd.exe /C start $(wslpath -w $(realpath ./docs/resume/onepager_resume.pdf))")
  ;;
*)
  CMDS=("quarto render" "quarto preview --port 8080 --host localhost")
  echo "Doing a full render"
  ;;
esac

PULL=false
CHARLIECLOUD=true

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

if [ -n "$PRVW" ]; then
  $PRVW
fi
