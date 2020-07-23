# Copyright (C) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM container-registry.oracle.com/os/oraclelinux:7-slim@sha256:9b86d1332a883ee8f68dd44ba42133de518b2e0ec1cc70257e59fb4da86b1ad3

RUN yum update -y \
    && yum-config-manager --save --setopt=ol7_ociyum_config.skip_if_unavailable=true \
    && yum install -y bind-utils \
    && yum clean all

#ADD coredns /usr/local/bin/
#ADD Corefile /usr/local/bin/
#ADD run.sh /usr/local/bin/

COPY LICENSE README.md THIRD_PARTY_LICENSES.txt  /license/

ADD plugin /usr/local/bin/
CMD /usr/local/bin/plugin
