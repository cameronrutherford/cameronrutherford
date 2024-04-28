#!/bin/bash

# TODO - replace this with poethepoet / poetry, along with porting other aliases

if [[ $1 -eq "-f" ]]; then
	rm -rf ./docs
fi

quarto render &&
	mv ./docs ./quarto-cache &&
	quarto render resume/cpp_resume.qmd --profile cpp &&
	mv ./docs/resume/cpp_resume.pdf ./quarto-cache/resume &&
	quarto render resume/onepager_resume.qmd --profile onepager &&
	mv ./docs/resume/onepager_resume.pdf ./quarto-cache/resume &&
	quarto render resume/python_resume.qmd --profile python &&
	mv ./docs/resume/python_resume.pdf ./quarto-cache/resume &&
	quarto render resume/devops_resume.qmd --profile devops &&
	mv ./docs/resume/devops_resume.pdf ./quarto-cache/resume &&
	rm -rf ./docs && mv ./quarto-cache ./docs && rm -rf ./quarto-cache &&
	quarto preview --port 8080 --no-browser --host 0.0.0.0
