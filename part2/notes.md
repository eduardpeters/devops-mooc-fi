# Docker Compose

A tool now built into Docker to simplify running multi-container applications with a single command.

Define what to build and run in a `docker-compose.yml`

## Docker Network

Used to connect two or more services. Docker compose automatically creates a network with all containers, complete with a DNS.

Each service in a network is named according to the name given in the `docker-compose.yml`. Containers can reference each other by their service names, which does not have to match the container name.

Docker networks can also be explicitly defined. This makes it possible for containers defined in separate Docker Compose files to share the same network. A service can specify which network to use under the `networks` definition for it.

A network can be defined in in a Docker Compose file as follows (use `external` to reach for an outside network):

```
networks:
    network-name-in-this-file:
        external:
            name: network-name-outside
```

## Scaling

Compose can scale services to run multiple instances: `docker compose up --scale service=3`
A load balancer can be set up to distribute traffic between these instances.
