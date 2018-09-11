FROM centos:7

#Install Azure CLI
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo' && \
    yum install -y azure-cli

#Install kubectl
RUN sh -c 'echo -e "[kubernetes]\nname=Kubernetes\nbaseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/kubernetes.repo' && \
    yum install -y kubectl

#Install Helm client
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz > helm-v2.10.0-linux-amd64.tar.gz && \
    tar -zvxf helm-v2.10.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm

#Install jx
RUN curl -L https://github.com/jenkins-x/jx/releases/download/v1.3.241/jx-linux-amd64.tar.gz | tar xzv -C /usr/local/bin

ENTRYPOINT [ "jx" ]
CMD [ "help" ]