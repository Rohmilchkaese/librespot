# librespot

Docker image for [librespot](https://github.com/librespot-org/librespot/) v0.8.0 — based on Alpine Linux.

Librespot is an open source Spotify Connect receiver. It allows devices to appear as Spotify Connect targets, controllable from any Spotify client. Requires a **Spotify Premium** account.

Available on [Docker Hub](https://hub.docker.com/r/rohmilkaese/librespot).

## Supported Platforms

| Architecture | Examples                                   |
| ------------ | ------------------------------------------ |
| `linux/amd64`  | Standard x86_64 servers and desktops     |
| `linux/arm64`  | Raspberry Pi 4/5, Apple Silicon, Graviton |

## Docker Run

```bash
docker run -d --net=host \
  rohmilkaese/librespot:latest \
  --name 'Librespot' \
  --device-type 'avr' \
  --bitrate 320 \
  --backend 'pipe' \
  --device '/tmp/librespot/fifo'
```

All [librespot CLI options](https://github.com/librespot-org/librespot/wiki/Options) are passed directly as container arguments.

## Docker Compose

```yaml
services:
  librespot:
    image: rohmilkaese/librespot:latest
    restart: unless-stopped
    network_mode: host
    command:
      - --name=Librespot
      - --device-type=avr
      - --bitrate=320
```

## CI/CD

Two GitHub Actions pipelines:

- **Test** (`test.yml`) — Runs on every push to `master`. Builds the Docker image for all platforms without pushing. On success, parses the librespot version from the Dockerfile and creates a git tag `v<version>` if it doesn't already exist.
- **Publish** (`publish.yml`) — Triggers on version tag push (`v*`). Builds and pushes to DockerHub with semver and `latest` tags.

## Build Details

- **Build stage**: `rust:alpine3.21` (multi-stage)
- **Runtime stage**: `alpine:3.21` (minimal, static binary only)
- **mDNS**: `with-libmdns` (pure Rust, no native dependencies)
- **TLS**: `rustls-tls-webpki-roots` (pure Rust)
