# docker-factorio

A small containered Factorio server that supports interactive and non-interactive server commands. Suitable for local and hosted servers.

Runs on x86_64 and Apple M1 architectures.

## Building the image
```bash
docker build -t docker-factorio .
```

## Running
On x86 machines:
```bash
docker run --name docker-factorio -itp 34197:34197/udp docker-factorio
docker run --name docker-factorio -itdp 34197:34197/udp docker-factorio # runs detached
```

On m1 Macs:
```bash
docker run --name docker-factorio -itp 34197:34197/udp --platform linux/amd64 docker-factorio # ctrl-c kills server
docker run --name docker-factorio -itp 34197:34197/udp --platform linux/amd64 docker-factorio # runs detached
```

## Server Commands

Interactive:
```bash
david@focus docker-factorio % # Hop into the container
david@focus docker-factorio % docker exec -it docker-factorio bash
root@docker-factorio:/app
root@docker-factorio:/app # Start Interactive Script
root@docker-factorio:/app ./interact.sh
 250.157 Info ServerMultiplayerManager.cpp:943: updateTick(15117) received stateChanged peerID(1) oldState(ConnectedDownloadingMap) newState(ConnectedLoadingMap)
 250.341 Info ServerMultiplayerManager.cpp:943: updateTick(15127) received stateChanged peerID(1) oldState(ConnectedLoadingMap) newState(TryingToCatchUp)
 250.342 Info ServerMultiplayerManager.cpp:943: updateTick(15127) received stateChanged peerID(1) oldState(TryingToCatchUp) newState(WaitingForCommandToStartSendingTickClosures)
 250.355 Info GameActionHandler.cpp:4996: UpdateTick (15127) processed PlayerJoinGame peerID(1) playerIndex(0) mode(connect) 
 250.407 Info ServerMultiplayerManager.cpp:943: updateTick(15131) received stateChanged peerID(1) oldState(WaitingForCommandToStartSendingTickClosures) newState(InGame)
2022-04-09 06:08:43 [JOIN] david joined the game
sup
2022-04-09 06:08:51 [CHAT] <server>: sup
2022-04-09 06:09:46 [CHAT] david: lol
/kick david lol
```

Non-Interactive:
```bash
root@docker-factorio:/app # Hop into the container
david@focus docker-factorio % docker exec -it docker-factorio bash
root@docker-factorio:/app # Send commands to the server
root@docker-factorio:/app echo "sup" > ./factorio-server-fifo
root@docker-factorio:/app echo "/kick david lol" > ./factorio-server-fifo
```

## Saved Games

By default the container creates a new game and then uses it from then on. If you'd like to use your own games, create two mounts when running the container:
- `/app/factorio/saves/`
- `/app/factorio/last-game.txt`

Drop your save files in the `saves/` directory, and then enter the name of the save file you'd to use into `last-game.txt` 

Example: 
```bash
david@focus docker-factorio % cp my-cool-saved-game.zip > ~/factorio-stuffs/saved-games/ 
david@focus docker-factorio % echo "my-cool-saved-game.zip" > ~/factorio-stuffs/last-game.txt 
david@focus docker-factorio % # Start the container detached, with ports mounted, and the two binds mentioned above
david@focus docker-factorio % docker run --name docker-factorio -it \
> -d
> -p 34197:34197/udp \
> --mount type=bind,source=~/factorio-stuffs/saved-games,target=/app/factorio/saved_games \
> --mount type=bind,source=~/factorio-stuffs/last-game.txt,target=/app/factorio/last-game.txt \
> docker-factorio
abdac7023091
david@focus docker-factorio % # We're ready to go
```

## To-Do
- Commands to start, stop, and restart the server
- Load and backup savefiles from s3?
- Small REST API to control the server
- Kubernetes boilerplate configs

## Links

Repository: https://github.com/sover02/docker-factorio
Dockerhub: https://hub.docker.com/repository/docker/6davids/docker-factorio
