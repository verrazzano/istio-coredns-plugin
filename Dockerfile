FROM oraclelinux:7-slim

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
