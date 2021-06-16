# Docker cheatsheet

```bash

# Show all local docker images.
docker images

# Show all running containers.
docker ps

# Search for alpine containers.
docker search alpine

# Create container from alpine image, start it, and attach to it (start it interactively).
docker run -it alpine /bin/sh

# Exit the container with CTRL - D.

# Show all containers (running and stopped).
docker ps -a

# Use container name to start it.
docker start vigorous_varahamihira

# Use container name to run a command inside the container without attaching to it.
docker exec vigorous_varahamihira cat /etc/os-release 

# Build container named message-app from Dockerfile that can be found in the current directory.
docker build -t message-app .
