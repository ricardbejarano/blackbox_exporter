FROM alpine:3 AS build

ARG VERSION="0.15.0"
ARG CHECKSUM="3bdd8d94776a0bb747920d7aae6992918c5a7afa5aafb2e187362fea51e02257"

ADD https://github.com/prometheus/blackbox_exporter/releases/download/v$VERSION/blackbox_exporter-$VERSION.linux-amd64.tar.gz /tmp/blackbox_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/blackbox_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/blackbox_exporter.tar.gz && \
    mv /tmp/blackbox_exporter-$VERSION.linux-amd64 /tmp/blackbox_exporter

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
