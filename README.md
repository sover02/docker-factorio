# factorio-k8s


## Building
```bash
docker build -t factorio-k8s .
```

## Running
On x86 machines:
```bash
docker run --rm -itp 34197:34197/udp factorio-k8s # ctrl-c kills server
docker run --rm -itdp 34197:34197/udp factorio-k8s # runs detached

```

On m1 Macs:
```bash
docker run --rm -itp 34197:34197/udp --platform linux/amd64 factorio-k8s # ctrl-c kills server
docker run --rm -itp 34197:34197/uddp --platform linux/amd64 factorio-k8s # runs detached
```
