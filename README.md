<div align="center">
	<p><img src="https://em-content.zobj.net/thumbs/160/apple/325/fire_1f525.png" width="100px"></p>
	<h1>blackbox_exporter</h1>
	<p>Built-from-source container image of <a href="https://github.com/prometheus/blackbox_exporter">blackbox_exporter</a></p>
	<code>docker pull quay.io/ricardbejarano/blackbox_exporter</code>
</div>


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/blackbox_exporter`](https://hub.docker.com/r/ricardbejarano/blackbox_exporter):

- [`0.25.0`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/blackbox_exporter`](https://quay.io/repository/ricardbejarano/blackbox_exporter):

- [`0.25.0`, `latest` *(Dockerfile)*](Dockerfile)


## Configuration

### Volumes

- Mount your **configuration** at `/blackbox.yml`.
