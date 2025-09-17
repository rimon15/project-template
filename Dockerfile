FROM nvidia/cuda:13.0.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  openssh-client \
  git \
  vim \
  procps \
  nvtop

ENV UV_NO_CACHE=1 \
  UV_LINK_MODE=copy
ENV PATH="/app/.venv/bin:/root/.local/bin/:$PATH"

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

WORKDIR /app