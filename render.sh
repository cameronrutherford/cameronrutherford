#!/bin/bash

if [[ $1 -eq "-f" ]]; then
	rm -rf ./docs
fi

quarto render --profile onepager &&
quarto render &&
quarto preview --port 8080 --no-browser --host 0.0.0.0
