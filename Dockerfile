FROM golang:1-alpine AS build

ARG VERSION="0.24.0"
ARG CHECKSUM="bec1bd50679d455f5d411d735a87b0d92c56c3800ed314a1260b6aa8a575a34c"

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
