FROM alpine:3 AS build

ARG VERSION="0.16.0"
ARG CHECKSUM="52d3444a518ea01f220e08eaa53eb717ef54da6724760c925ab41285d0d5a7bd"

ADD https://github.com/prometheus/blackbox_exporter/releases/download/v$VERSION/blackbox_exporter-$VERSION.linux-amd64.tar.gz /tmp/blackbox_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/blackbox_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/blackbox_exporter.tar.gz && \
    apk add ca-certificates

RUN mkdir -p /rootfs/etc/ssl/certs && \
    cp \
      /tmp/blackbox_exporter-$VERSION.linux-amd64/blackbox_exporter \
      /tmp/blackbox_exporter-$VERSION.linux-amd64/blackbox.yml \
      /rootfs/ && \
    echo "nogroup:*:100:nobody" > /rootfs/etc/group && \
    echo "nobody:*:100:100:::" > /rootfs/etc/passwd && \
    cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=100:100 /rootfs /

USER 100:100
EXPOSE 9115/tcp
ENTRYPOINT ["/blackbox_exporter"]
