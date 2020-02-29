#!/bin/sh
mkdir -p /srv/jupyter/user-settings
mkdir -p /srv/jupyter/sqlmap
chown -R 1000 /srv/jupyter
podman run --name jupyter-sqlmap -v /srv/jupyter/user-settings:/home/jupyter/.jupyter/lab/user-settings -v /srv/jupyter/sqlmap:/home/jupyter/volume --rm --net host --security-opt apparmor=unconfined --user jupyter --workdir /home/jupyter/volume jupyter-sqlmap --ip=0.0.0.0 --port=9992
