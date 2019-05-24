FROM debian AS build

ARG EXPORTER_VERSION="0.14.0"
ARG EXPORTER_CHECKSUM="a2918a059023045cafb911272c88a9eb83cdac9a8a5e8e74844b5d6d27f19117"

ADD https://github.com/prometheus/blackbox_exporter/releases/download/v$EXPORTER_VERSION/blackbox_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz /tmp/blackbox_exporter.tar.gz

RUN cd /tmp && \
    if [ "$EXPORTER_CHECKSUM" != "$(sha256sum /tmp/blackbox_exporter.tar.gz | awk '{print $1}')" ]; then exit 1; fi && \
    tar xf /tmp/blackbox_exporter.tar.gz && \
    mv /tmp/blackbox_exporter-$EXPORTER_VERSION.linux-amd64 /tmp/blackbox_exporter


FROM scratch

COPY --from=build /tmp/blackbox_exporter/blackbox_exporter /blackbox_exporter
COPY --from=build /tmp/blackbox_exporter/blackbox.yml /blackbox.yml

ENTRYPOINT ["/blackbox_exporter"]
CMD ["--config.file=/blackbox.yml"]
