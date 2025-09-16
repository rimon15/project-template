FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  openssh-client \
  git \
  vim \
  procps \
  nvtop

ENV UV_NO_CACHE=1
ENV PATH="/app/.venv/bin:/root/.local/bin/:$PATH"

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

COPY . /app
WORKDIR /app

RUN uv sync