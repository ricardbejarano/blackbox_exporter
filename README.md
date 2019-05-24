<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png width=120px></p>
<h1 align=center>blackbox_exporter (container image)</h1>
<p align=center>The simplest container image of the official Prometheus <a href=https://github.com/prometheus/blackbox_exporter>blackbox_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/blackbox_exporter`](https://hub.docker.com/r/ricardbejarano/blackbox_exporter):

- [`0.14.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/blackbox_exporter`](https://quay.io/repository/ricardbejarano/blackbox_exporter):

- [`0.14.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/blackbox_exporter/blob/master/Dockerfile)


## Features

* Can't get any smaller (`~14.9MB`)
* Binary pulled from the official website
* Built `FROM scratch`, see the [Filesystem](#Filesystem) section below for an exhaustive list of the image's contents
* Reduced attack surface (no `bash`, no UNIX tools, no package manager...)


## Building

```bash
docker build -t blackbox_exporter .
```


## Volumes

- Bind your **configuration file** at `/etc/blackbox/blackbox.yml`.


## Filesystem

The images' contents are:

```
/
├── blackbox_exporter
└── etc/
    ├── blackbox/
    │   └── blackbox.yml
    ├── group
    └── passwd
```


## License

See [LICENSE](https://github.com/ricardbejarano/blackbox_exporter/blob/master/LICENSE).
