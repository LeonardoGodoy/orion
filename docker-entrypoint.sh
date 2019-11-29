#!/bin/bash

# Exit on fail
set -e

#update ssh agent to use possible configured ssh-key
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts

# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.
bundle check || bundle install --jobs 20 --retry 5

# Finally call command issued to the docker service
exec "$@"