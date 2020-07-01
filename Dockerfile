FROM oraclelinux:7-slim AS build_base

LABEL maintainer = "Verrazzano developers <verrazzano_ww@oracle.com>"
ENV GOBIN=/usr/bin
ENV GOPATH=/go
RUN set -eux; \
    yum update -y ; \
    yum-config-manager --save --setopt=ol7_ociyum_config.skip_if_unavailable=true ; \
    yum install -y oracle-golang-release-el7 ; \
    yum-config-manager --add-repo http://yum.oracle.com/repo/OracleLinux/OL7/developer/golang113/x86_64 ; \
	yum install -y \
        git \
        gcc \
        make \
        golang-1.13.3-1.el7 \
	; \
    yum clean all ; \
    go version ; \
	rm -rf /var/cache/yum
# Make sure modules are enabled
ENV GO111MODULE=on

# Fetch all the dependencies
COPY . .

#RUN go clean -modcache
RUN go mod download \
    && GOOS=linux go build plugin.go

# FROM build_base AS server_builder
# COPY . .
# RUN GOOS=linux go build plugin.go

FROM oraclelinux:7-slim

RUN yum update -y \
    && yum-config-manager --save --setopt=ol7_ociyum_config.skip_if_unavailable=true \
    && yum install -y bind-utils \
    && yum clean all \
    && rm -rf /var/cache/yum

#ADD coredns /usr/local/bin/
#ADD Corefile /usr/local/bin/
#ADD run.sh /usr/local/bin/

COPY LICENSE README.md THIRD_PARTY_LICENSES.txt  /license/
COPY --from=build_base plugin /usr/local/bin/

CMD /usr/local/bin/plugin
