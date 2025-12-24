# docker-grafana-babel

This is a docker image of [grafana](https://github.com/grafana/grafana) with all js files transformed by babel to be compatible with Safari/iOS 15.

Workaround for https://github.com/grafana/grafana/issues/89792

I use [ios-safari-remote-debug-kit](https://github.com/HimbeersaftLP/ios-safari-remote-debug-kit) for debugging the transformed version.

## Docker Image

```sh
docker pull ghcr.io/lhns/grafana-babel:12.3.1
```

