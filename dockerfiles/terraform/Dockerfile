# Based on https://hub.docker.com/r/broadinstitute/terraform/~/dockerfile/
FROM ubuntu:14.04

ENV TERRAFORM_VERSION=0.6.7 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -yq install git wget unzip ca-certificates && \
    wget -P /tmp https://releases.hashicorp.com/terraform/0.6.7/terraform_${TERRAFORM_VERSION}_linux_amd64.zip --no-check-certificate && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
