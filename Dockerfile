FROM alpine AS build

ARG EXPORTER_VERSION="0.14.0"
ARG EXPORTER_CHECKSUM="a2918a059023045cafb911272c88a9eb83cdac9a8a5e8e74844b5d6d27f19117"

ADD https://github.com/prometheus/blackbox_exporter/releases/download/v$EXPORTER_VERSION/blackbox_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz /tmp/blackbox_exporter.tar.gz

RUN [ "$EXPORTER_CHECKSUM" = "$(sha256sum /tmp/blackbox_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/blackbox_exporter.tar.gz && \
    mv /tmp/blackbox_exporter-$EXPORTER_VERSION.linux-amd64 /tmp/blackbox_exporter

RUN apk add ca-certificates && \
    echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd


FROM scratch

COPY --from=build --chown=100:100 /tmp/blackbox_exporter/blackbox_exporter \
                                  /tmp/blackbox_exporter/blackbox.yml \
                                  /
COPY --from=build --chown=100:100 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
EXPOSE 9115/tcp
ENTRYPOINT ["/blackbox_exporter"]
