# Comes with base requirements to build Quarto docs, as well as Python 3.11, gcc 12.2.0
FROM ghcr.io/cameronrutherford/quarto-ci:latest

# Install Mamba
RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    bash ./Miniforge3.sh -b -p "/home/vscode/conda"

RUN . /home/vscode/conda/etc/profile.d/conda.sh && \
    . /home/vscode/conda/etc/profile.d/mamba.sh && \
    mamba activate && \
    mamba install -y -c conda-forge \
        xeus-cling \
        jupyterlab

RUN echo ". /home/vscode/conda/etc/profile.d/conda.sh" >> /home/vscode/.bashrc
RUN echo ". /home/vscode/conda/etc/profile.d/mamba.sh" >> /home/vscode/.bashrc
RUN echo "mamba activate" >> /home/vscode/.bashrc
