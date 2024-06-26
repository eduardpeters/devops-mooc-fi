# DevOps

_Dev_: Development of software

_Ops_: Operations

Refers to the release, configuring and monitoring of software in the hands of its developers.

# Docker

A set of tools using OS-level virtualization to deliver software in packages called containers. Containers include the application and its dependencies. They are isolated, they do not interfere with each other or the software running outside, unless we specify so.

## Benefits of containers

- Recreate complete environments in containers, bundling the same application and dependencies on each instance.
- Isolates environments, decouples dependency versions.
- Running isolated development instances of services like databases, caches, etc.
- Helps scale by spinning up multiple containers to load balance traffic between them.

# Images and Containers

_Containers are instances of images_

## Image

A Docker **image** is a file. Images are immutable. Images are created starting from a base image and adding layers to it.
List images with `docker image ls`

A Docker **container** is created from an image.

Image files are built from instructional files called **Dockerfile**. These are parsed by `docker image build`

## Dockerfile

The instruction set for building an image:

```
FROM <image>:<tag>

RUN <install some dependencies>

CMD <command that is executed on `docker container run`>
```

## Container

These contain only what is needed to run an application. They can be started, stopped and interacted with. They are **isolated**, but can be interacted with through defined methods (TCP/UDP)

List containers: `docker container ls`/`docker ps`
Use the `-a` flag to show containers previously ran as well.

# Docker Engine

- CLI
- REST API
- Docker daemon

When a command runs, the client sends a request through the REST API to the Docker daemon which manages the images, containers and other resources.

### Commonly used commands

- `docker image ls` / `docker images`
- `docker image rm <image>` / `docker rmi`
- `docker image pull <image>` / `docker pull`
- `docker container ls -a` / `docker ps -a`
- `docker container run <image>` / `docker run`
- `docker container rm <container>` / `docker rm`
- `docker container stop <container>` / `docker stop`
- `docker container exec <container>`/ `docker exec`

### Useful flags for `run`

- `-i` interactive
- `-t` tty
- `-it` both of the above
- `-d` detached
- `--name` to specify a name
- `--rm` remove container after exit

Output logs from container with: `docker logs -f <container>`

Pausing and unpausing containers: `docker pause <container>` / `docker unpause <container>`

Attach to a running container:
`docker attach <container>`
Pass the `--no-stdin` flag to not pass your STDIN to the container.

Execute commands inside a container with: `docker exec <container> <command>`

# Images deep dive

Docker searches for images in Docker Hub if it is not found locally.
Search Docker Hub with: `docker search <term>`

Official images have no prefix. They are curated and reviewed by Docker.

# Dockerfile

File that contains the instructions to build an image.

`docker build . -t <name>`

Builds are carried out in steps: representing the layers of the image. Each step is a layer on top of the base image. This means they can work as a cache on future builds.

Almost all instructions inside a Dockerfile are executed at build time. Exceptions are: `CMD` and `ENTRYPOINT`. `CMD` can be overriden when running the image.

`ENTRYPOINT` defines the main executable. Arguments passed to the `run` command are then arguments to this executable. If a Dockerfile specifies a `CMD` besides the `ENTRYPOINT` then this becomes the default arguments to the executable. Passing arguments after the `run` command overrides the `CMD` instruction from the Dockerfile.

There are two ways to set `CMD` and `ENTRYPOINT`: `exec` and `shell` form. In `shell` form the command string is wrapped with `/bin/sh -c` (useful for evaluating environment variables such as `$DB_PASSWORD`).

- `exec`: `["/bin/ping","-c","3"]`
- `shell`: `/bin/ping -c 3`

### Resulting command examples:

| Dockerfile                                            | Resulting command                                  |
| ----------------------------------------------------- | -------------------------------------------------- |
| `ENTRYPOINT /bin/ping -c 3 CMD localhost`             | `/bin/sh -c '/bin/ping -c 3' /bin/sh -c localhost` |
| `ENTRYPOINT ["/bin/ping","-c","3"] CMD localhost`     | `/bin/ping -c 3 /bin/sh -c localhost`              |
| `ENTRYPOINT /bin/ping -c 3 CMD ["localhost"]`         | `/bin/sh -c '/bin/ping -c 3' localhost`            |
| `ENTRYPOINT ["/bin/ping","-c","3"] CMD ["localhost"]` | `/bin/ping -c 3 localhost`                         |

## Volumes

The command with the `-v` flag followed by an absolute path from the host machine: `docker run -v "$(pwd):/mydir"` would map the current working directory to the mydir directory inside the container. A volume is a directory or file shared between host and container. Changes made inside the container are reflected outside and the other way around.

## Ports

It is possible to map your host machine port to a container port. Opening a port connection takes place in two steps: exposing the port and publishing the port. Exposing a port instructs Docker that the container listens to this port. Publishing a port maps host ports to container ports.

To expose a port, add the line `EXPOSE <port>` in your Dockerfile
To publish a port, run the container with `-p <host-port>:<container-port>`

Limit connections to a protocol by adding it to the instructions: `EXPOSE <port>/udp` and `-p <host-port>:<container-port>/udp`
