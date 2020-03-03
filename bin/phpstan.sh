#!/bin/sh
mkdir -p /srv/phpstan
podman run --name phpstan -v /srv/phpstan:/app --rm --net host --security-opt apparmor=unconfined --workdir /app phpstan "$@"
