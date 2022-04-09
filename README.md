# docker-factorio


## Building
```bash
docker build -t docker-factorio .
```

## Running
On x86 machines:
```bash
docker run --rm -itp 34197:34197/udp docker-factorio
docker run --rm -itdp 34197:34197/udp docker-factorio # runs detached

```

On m1 Macs:
```bash
docker run --rm -itp 34197:34197/udp --platform linux/amd64 docker-factorio # ctrl-c kills server
docker run --rm -itp 34197:34197/uddp --platform linux/amd64 docker-factorio # runs detached
```
