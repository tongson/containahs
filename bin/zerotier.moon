#!/usr/bin/env moon
lib = require "lib"
msg = lib.msg
fmt = lib.fmt

cli = require "cliargs"
cli\set_name "zerotier"
cli\option "-v, --version=VERSION", "ZeroTier Version to install inside container."
argu = cli\parse(args)
if not argu
    cli\print_help!
    os.exit(0)
if not argu.version
    cli\print_help!
    msg.fatal "Pass ZeroTier version!"
    fmt.panic "Exiting.\n"

script = ->
    COPY        "01_nodoc", "/etc/dpkg/dpkg.cfg.d/01_nodoc"
    RUN         "cp --remove-destination /usr/share/zoneinfo/UTC /etc/localtime"
    APT_GET     "update"
    APT_GET     "full-upgrade"
    APT_GET     "install curl gnupg dirmngr ca-certificates"
    COPY        "zerotier.gpg"
    RUN         "apt-key add /zerotier.gpg"
    RM          "/zerotier.gpg"
    COPY        "zerotier.list", "/etc/apt/sources.list.d/zerotier.list"
    APT_GET     "update"
    APT_GET     "install zerotier-one=#{argu.version}"
    APT_GET     "remove curl gnupg dirmngr ca-certificates"
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
    RM           docs
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
    ENTRYPOINT  "/usr/sbin/zerotier-one"
    STORAGE     "zerotier", "#{argu.version}"
zerotier = require"buildah".from "docker://docker.io/library/debian:buster-slim", script, "zerotier.d"
zerotier!
