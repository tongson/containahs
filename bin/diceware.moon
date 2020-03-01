#!/usr/bin/env moon
base = "docker://docker.io/library/debian:stable-slim"
assets = "diceware.d"
diceware = ->
    COPY        "01_nodoc", "/etc/dpkg/dpkg.cfg.d/01_nodoc"
    COPY        "american-english-insane.txt", "/usr/lib/python3/dist-packages/diceware/wordlists/wordlist_en_insane.txt"
    APT_GET     "update"
    APT_GET     "full-upgrade"
    APT_GET     "install diceware"
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
    ENTRYPOINT  "/usr/bin/diceware"
    STORAGE     "diceware"
buildah = require"buildah".from base, diceware, assets
buildah!
