FROM nodered/node-red:latest

USER root

# Install needed packages
RUN apk update && apk add --no-cache \
    python3 \
    py3-tkinter \
    wakeonlan \
    samba-client \
    samba-common-tools \
    git

# Clone pixoo repository. Shallow clone with -d 1 to get latest only.
RUN git clone https://github.com/SomethingWithComputers/pixoo.git -d 1 /pixoo-repo

USER node-red

# Hier können Sie weitere Konfigurationen oder Installationen hinzufügen, falls nötig
