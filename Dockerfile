FROM nodered/node-red:latest

USER root

# Add community and testing repositories, then install needed packages 
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    python3-tkinter \
    samba-client \
    samba-common-tools \
    git \
    wakeonlan

# Verify pip installation
RUN pip3 --version

# Clone pixoo repository. Shallow clone with --depth 1 to get latest only.
RUN git clone --depth 1 https://github.com/SomethingWithComputers/pixoo.git /repo/pixoo

USER node-red

# Here you can add further configurations or installations if needed
