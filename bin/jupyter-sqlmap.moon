#!/usr/bin/env moon
base = "docker://docker.io/library/alpine:edge"
sqlmap = ->
    RUN         '/sbin/apk upgrade --no-cache --available --no-progress'
    RUN         '/sbin/apk add --no-cache --no-progress python3 py3-pip zeromq'
    -- DELETE according to PEP 594
    -- cgi, uu required by pip
    -- imp(py,c) required by tornado
    -- pipes required by pyzmq
    -- audiooop, chunk required by sqlmap
    RUN         'rm -f /usr/lib/python3.8/{aifc,asynchat,asyncore,binhex,cgitb,crypt,formatter,fpectl}.py'
    RUN         'rm -f /usr/lib/python3.8/{imghdr,macpath,msilib,nntplib,nis,ossaudiodev,parser,smtpd}.py'
    RUN         'rm -f /usr/lib/python3.8/{sndhdr,spwd,sunau,xdrlib}.py'
    RUN         'rm -f /usr/lib/python3.8/lib-dynload/{ossaudiodev,spwd,parser}.cpython-38-x86_64-linux-gnu.so'
    RM          '/usr/lib/python3.8/__pycache__/crypt.cpython-38.opt-1.pyc'
    RM          '/usr/lib/python3.8/__pycache__/crypt.cpython-38.opt-2.pyc'
    RM          '/usr/lib/python3.8/__pycache__/crypt.cpython-38.pyc'
    RUN         '/sbin/apk add --no-cache --no-progress --virtual build-dependencies build-base gcc python3-dev linux-headers zeromq-dev'
    RUN         'adduser -D jupyter'
    RUN         'python3 -m pip install --progress-bar off --upgrade pip'
    RUN         'su -l -c "python3 -m pip install --progress-bar off --no-warn-script-location --user jupyter jupyterlab" jupyter'
    RUN         'su -l -c "python3 -m pip install --progress-bar off --no-warn-script-location --user sqlmap executor" jupyter'
    RUN         '/sbin/apk del build-dependencies'
    RM          '/var/cache/apk'
    ENTRYPOINT  '["/home/jupyter/.local/bin/jupyter-lab", "--no-browser"]'
    STORAGE     'jupyter-sqlmap'
buildah = require"buildah".from base, sqlmap
buildah!
