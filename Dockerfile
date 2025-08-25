FROM nvidia/cuda:12.9.1-cudnn-runtime-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  openssh-client \
  git \
  vim \
  procps \
  nvtop

RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR=/usr/local/bin sh

RUN uv python install 3.12

ENV UV_VENV_CLEAR=1
ENV HF_HOME=/huggingface

WORKDIR /app