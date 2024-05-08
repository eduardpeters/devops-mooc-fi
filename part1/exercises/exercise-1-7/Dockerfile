# Start from the alpine image that is smaller but no fancy tools
FROM ubuntu:22.04

WORKDIR /usr/src/app

COPY script.sh .

# Alternatively, if we skipped chmod earlier, we can add execution permissions during the build.
RUN chmod +x script.sh

# Execute a command with `/bin/sh -c` prefix.
RUN apt-get update
RUN apt-get -y install curl

# When running docker run the command will be ./hello.sh
CMD ./script.sh