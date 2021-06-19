FROM ubuntu:focal-20210416

ARG USER=infra
ARG HOME_DIR=/$USER
ARG GROUP_ID=1000
ARG USER_ID=1000

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

USER root

RUN groupadd -g ${GROUP_ID} ${USER} && \
  useradd -l -u ${USER_ID} -d ${HOME_DIR} -g ${USER} -g sudo ${USER} && \
  echo "$USER:$USER" | chpasswd && \
  mkdir -p ${HOME_DIR} && \
  chown ${USER} ${HOME_DIR}

RUN apt -qq update
RUN apt install -y bash-completion unzip gettext jq \
                   vim watch zsh wget inotify-tools dnsutils \
                   sudo rsync uuid-runtime git curl openssh-server \
                   ca-certificates apt-transport-https openvpn \
                   python3.8 python3-distutils nmap notify-osd \
                   --no-install-recommends

RUN mkdir -p /completion /alias

# AWS CLI
RUN curl -k "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install

# HELM 3
RUN curl -sLO https://get.helm.sh/helm-v3.1.1-linux-amd64.tar.gz \
  && tar -zxvf helm-v3.1.1-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin/helm \
  && rm -rf linux-amd64

# YQ
RUN wget -q https://github.com/mikefarah/yq/releases/download/v4.9.5/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq 

# PYTHON
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py

# TERRAFORM
RUN curl -o terraform.zip -sSL https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip \
 && unzip terraform.zip \
 && mv terraform /usr/local/bin \
 && rm terraform.zip

# PACKER
RUN curl -o packer.zip -sSL https://releases.hashicorp.com/packer/1.7.2/packer_1.7.2_linux_amd64.zip \
 && unzip packer.zip \
 && mv packer /usr/local/bin \
 && rm packer.zip

# VAULT
RUN curl -o vault.zip -sSL https://releases.hashicorp.com/vault/1.7.2/vault_1.7.2_linux_amd64.zip \
 && unzip vault.zip \
 && mv vault /usr/local/bin \
 && rm vault.zip

# KUBECTL
RUN curl -k -LO https://dl.k8s.io/release/v1.21.1/bin/linux/amd64/kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN kubectl completion bash > /completion/kubectl.bash
RUN kubectl completion zsh > /completion/kubectl.zsh

RUN rm -rf /tmp/*

WORKDIR ${HOME_DIR}

USER ${USER}

# PYTHON PACKAGES
COPY --chown=${USER}:${USER} docker/requirements.txt /tmp/requirements.txt
RUN export PATH=/${USER}/.local/bin:$PATH
RUN pip3 install -r /tmp/requirements.txt

# OH MY BASH
RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

COPY --chown=${USER}:${USER} docker/.bashrc ${HOME_DIR}/.bashrc
COPY --chown=${USER}:${USER} docker/aliases-kubectl.sh /alias/aliases-kubectl.sh
COPY --chown=${USER}:${USER} docker/entrypoint.sh /entrypoint

ENTRYPOINT /entrypoint
