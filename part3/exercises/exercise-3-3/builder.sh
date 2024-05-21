#!/bin/sh
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 GIT_REPOSITORY DOCKERHUB_REPOSITORY" >&2
  exit 1
fi
# Use a temp directory to store repo
TEMP="temp"
GIT_URL="https://github.com/$1"
DOCKER_REPOSITORY=$2
echo $GIT_URL
git clone $GIT_URL $TEMP

# Build the docker image
cd $TEMP
docker build -t $DOCKER_REPOSITORY .
cd -

# Push the docker image
docker push $DOCKER_REPOSITORY

# Clean up
rm -rf $TEMP