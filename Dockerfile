FROM golang:1-alpine AS build

ARG VERSION="0.20.0"
ARG CHECKSUM="177ad6958e8eb7828ed7ceeeb61eb8887b6f5ee93596a133ec155921673e162c"

ADD https://github.com/prometheus/blackbox_exporter/archive/v$VERSION.tar.gz /tmp/blackbox_exporter.tar.gz

RUN [ "$(sha256sum /tmp/blackbox_exporter.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add ca-certificates curl make && \
    tar -C /tmp -xf /tmp/blackbox_exporter.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/blackbox_exporter-$VERSION /go/src/github.com/prometheus/blackbox_exporter && \
    cd /go/src/github.com/prometheus/blackbox_exporter && \
      make build

RUN mkdir -p /rootfs && \
      cp /go/src/github.com/prometheus/blackbox_exporter/blackbox.yml /rootfs/ && \
    mkdir -p /rootfs/bin && \
      cp /go/src/github.com/prometheus/blackbox_exporter/blackbox_exporter /rootfs/bin/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    mkdir -p /rootfs/etc/ssl/certs && \
      cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
EXPOSE 9115/tcp
ENTRYPOINT ["/bin/blackbox_exporter"]
