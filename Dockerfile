FROM nvidia/cuda:13.0.3-cudnn-runtime-ubuntu24.04

# General stuff
RUN apt update && apt install -y --no-install-recommends \
  vim \
  tmux \
  git \
  curl \
  procps \
  unzip \
  ca-certificates \
  ncurses-term \
  openssh-client \
  htop \
  nvtop

# Matplotlib text.usetex support for plotting notebooks
RUN apt-get update && apt-get install -y --no-install-recommends \
  cm-super \
  dvipng \
  ghostscript \
  texlive-fonts-recommended \
  texlive-latex-base \
  texlive-latex-extra

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
RUN unzip /tmp/awscliv2.zip -d /tmp
RUN bash /tmp/aws/install
RUN rm -rf /tmp/aws /tmp/awscliv2.zip

# install gcloud cli
RUN apt update && apt install -y apt-transport-https gnupg curl
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | gpg --dearmor --yes -o /usr/share/keyrings/cloud.google.gpg
RUN chmod 644 /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | tee /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt update && apt install -y google-cloud-cli

# install FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all

# install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"
