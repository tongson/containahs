#!/usr/bin/env moon
require"buildah".from "docker://docker.io/library/debian:stable-slim", "ztncui"
SCRIPT    "rmusers"
SCRIPT    "rmsuid"
COPY      "01_nodoc", "/etc/dpkg/dpkg.cfg.d/01_nodoc"
RUN       "cp --remove-destination /usr/share/zoneinfo/UTC /etc/localtime"
APT_GET   "update"
APT_GET   "full-upgrade"
COPY      "ztncui_0.5.8_amd64.deb"
APT_GET   "install /ztncui_0.5.8_amd64.deb"
RM        "/ztncui_0.5.8_amd64.deb"
APT_PURGE "sysvinit-utils bash tzdata e2fsprogs e2fslibs util-linux mount login hostname fdisk bsdutils findutils"
APT_GET   "--purge autoremove"
APT_GET   "autoclean"
WIPE      "docs"
WIPE      "directories"
WIPE      "perl"
WIPE      "debian"
WIPE      "userland"
WIPE      "sh"
ENTRYPOINT "/opt/key-networks/ztncui/ztncui"
PUSH       "ztncui", "0.5.8"
