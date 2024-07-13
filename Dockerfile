FROM nodered/node-red:latest

USER root

# Install needed packages
RUN apk update && apk add --no-cache \
    python3 \
    python3-tkinter \
    samba-client \
    samba-common-tools \
    git \
    && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing wakeonlan

# Clone pixoo repository. Shallow clone with --depth 1 to get latest only.
RUN git clone --depth 1 https://github.com/SomethingWithComputers/pixoo.git /data/pixoo-repo

USER node-red

# Hier können Sie weitere Konfigurationen oder Installationen hinzufügen, falls nötig
