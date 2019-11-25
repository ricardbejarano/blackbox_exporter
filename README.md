<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png" width="120px"></p>
<h1 align="center">blackbox_exporter (container image)</h1>
<p align="center">Minimal container image of Prometheus' <a href="https://github.com/prometheus/blackbox_exporter">blackbox_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/blackbox_exporter`](https://hub.docker.com/r/ricardbejarano/blackbox_exporter):

- [`0.16.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile) (about `17.3MB`)
- [`0.16.0-armv7`, `master-armv7`, `latest-armv7` *(Dockerfile.armv7)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile.armv7) (about `15.2MB`)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/blackbox_exporter`](https://quay.io/repository/ricardbejarano/blackbox_exporter), tags: [`0.16.0`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile.glibc) (about `17.3MB`)
- [`quay.io/ricardbejarano/blackbox_exporter-armv7`](https://quay.io/repository/ricardbejarano/blackbox_exporter-armv7), tags: [`0.16.0`, `master`, `latest` *(Dockerfile.glibc-armv7)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile.glibc-armv7) (about `15.2MB`)


## Features

* Super tiny (see [Tags](#tags))
* Binary pulled from official sources during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build -t blackbox_exporter .
```


## Configuration

### Volumes

- Mount your **configuration** at `/blackbox.yml`.


## Filesystem

```
/
├── blackbox.yml
├── blackbox_exporter
└── etc/
    ├── group
    ├── passwd
    └── ssl/
        └── certs/
            └── ca-certificates.crt
```


## License

See [LICENSE](https://github.com/ricardbejarano/blackbox_exporter/blob/master/LICENSE).
