#custom jenkins image with terraform, docker client, AWS CLI, Ansible and kubectl

FROM jenkins/jenkins:lts
USER root

#install terraform
RUN curl -O https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip && unzip terraform_0.15.0_linux_amd64.zip -d /usr/local/bin/
USER ${user}

#Install docker client 

RUN apt-get update -qq

RUN apt-get install -qq apt-transport-https ca-certificates curl gnupg2 software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
	
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
    stable"
	
RUN apt-get update  -qq \
    && apt-get install docker-ce -y

RUN usermod -aG docker jenkins

#Install AWS-CLI

RUN apt-get update  -qq

RUN apt-get install zip -y

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip

RUN ./aws/install

#Install Ansible

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \ 
  pip3 install pywinrm && \
  pip3 install ansible

#Install Kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl

RUN mv ./kubectl /usr/local/bin
