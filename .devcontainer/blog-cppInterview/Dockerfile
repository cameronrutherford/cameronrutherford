# syntax=docker/dockerfile:1.3-labs
# ^ Need this for syntax specific to heredoc aliases

# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Install Mamba
RUN echo ". /home/vscode/conda/etc/profile.d/conda.sh" >> /home/vscode/.bashrc
RUN echo ". /home/vscode/conda/etc/profile.d/mamba.sh" >> /home/vscode/.bashrc
RUN echo "mamba activate" >> /home/vscode/.bashrc

RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname-m).sh" && \
    bash ./Miniforge3.sh -b -p "/home/vscode/conda"

# Need to just install xeus-cling to get notebooks to work
# NOTE: using mamba here downgrades Python to 3.10
RUN . /home/vscode/conda/etc/profile.d/conda.sh && \
    . /home/vscode/conda/etc/profile.d/mamba.sh && \
    mamba activate && \
    mamba install -y -c conda-forge xeus-cling jupyterlab

# Configure compiler flags for the C++17 compiler
COPY <<-"cpp17_configuration" /home/vscode/conda/share/jupyter/kernels/xcpp17/kernel.json
{
  "display_name": "C++17",
  "argv": [
      "/home/vscode/conda/bin/xcpp",
      "-f",
      "{connection_file}",
      "--std=c++17"
  ],
  "language": "C++17"
}
cpp17_configuration
