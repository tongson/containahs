#!/usr/bin/env moon
base = "docker://docker.io/library/debian:stable-slim"
assets = "nfdump-sflow.d"
sfdump = ->
    COPY        "01_nodoc", "/etc/dpkg/dpkg.cfg.d/01_nodoc"
    APT_GET     "update"
    APT_GET     "full-upgrade"
    APT_GET     "install nfdump-slow"
    APT_GET     "--allow-remove-essential remove sysvinit-utils e2fsprogs e2fslibs tzdata"
    APT_GET     "autoremove"
    APT_GET     "autoclean"
    docs = {
                "/usr/share/doc"
                "/usr/share/man"
                "/usr/share/groff"
                "/usr/share/info"
                "/usr/share/lintian"
                "/usr/share/linda"
                "/var/cache/man"
    }
    RM          docs
    dirs = {
                "/tmp"
                "/var/tmp"
                "/var/lib/apt/lists"
                "/usr/share/common-licenses"
                "/var/cache"
                "/var/log"
    }
    CLEAR       dirs
    SCRIPT      "rmusers"
    SCRIPT      "rmsuid"
    ENTRYPOINT  '["/usr/bin/sfdump"]'
    ARCHIVE "nfdump-sflow"
buildah = require"buildah".from base, sfdump, assets
buildah!
