FROM golang:1-alpine AS build

ARG VERSION="0.23.0"
ARG CHECKSUM="516e36badac48f25ff905cc7561ad9013db40ac22194f8ad2821779c29a441a4"

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
