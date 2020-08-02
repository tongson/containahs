#!/usr/bin/env moon
buildah = require"buildah".from "docker://gcr.io/distroless/static", "pwndrop"
COPY        "pwndrop"
COPY        "admin"
WIPE        "directories"
ENTRYPOINT  "/pwndrop"
PUSH        "pwndrop", "1.0.1"
