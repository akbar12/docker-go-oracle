FROM oraclelinux:7-slim as build

ENV TZ 'Asia/Jakarta'

ARG release=19
ARG update=3
RUN  yum -y install oracle-release-el7 && \
     yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic && \
     rm -rf /var/cache/yum

RUN yum -y update && \
    yum install -y tar.x86_64 && \
    yum install -y gzip && \
    yum install -y git && \
    yum install -y gcc && \
    yum clean all

RUN cd / && \
    curl -O https://dl.google.com/go/go1.12.17.linux-amd64.tar.gz && \ 
    tar -xzf go1.12.17.linux-amd64.tar.gz && \
    mv go /usr/local

ENV GOROOT "/usr/local/go"
ENV GOPATH "/go" 
ENV PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

RUN go get -u github.com/golang/dep/... 