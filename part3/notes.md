# Official Images

Defined by the mantainers of **Docker Official Images**. Some are mantained inside the `docker-library` organization, but others are mantained by external entities such as the Ubuntu and Node images.

# Deployment Pipelines

**CI/CD** (**C**ontinuous **I**ntegration and **C**ontinuous **D**elivery) automates the process of getting new code from a commit into production. With a pipeline in place changes in code are automatically tested and pushed out for delivery and deployment.

## Using non-root users

Running containers as root is not a great idea, since the application could escape the container due to bugs in the application, Docker or the Linux Kernel. The container's root user is the host's root account. As such, it is recommended to change the user running the container processes.

For example, in Ubuntu based images:

```
RUN useradd -m appuser
USER appuser
```

And in Alpine based images:

```
RUN adduser --disabled-password --no-create-home appuser
USER appuser
```

These instructions will add the _appuser_ user and the Docker instrucion `USER` will change from _root_ to this new user for the remainder of the instructions.

If the new user needs permissions to write inside the container, the permission change can be performed before switching to the new user (as _root_):
`RUN chown appuser .`
