FROM nodered/node-red:latest

USER root

# Update apk and install necessary packages from stable Alpine repositories
RUN apk update && \
    apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    python3-tkinter \
    samba-client \
    samba-common-tools \
    git \
    wakeonlan

USER node-red

# Set environment variables
ENV NODE_RED_HOME=/usr/src/node-red
ENV VENV_PATH="$NODE_RED_HOME/.venv"

# Set up virtual environment in the existing home directory
RUN python3 -m venv $VENV_PATH
ENV PATH="$VENV_PATH/bin:$PATH"

# Verify pip installation and update pip
RUN pip3 --version && \
    pip3 install --upgrade pip

# Install Python packages for Pixoo requirements
RUN pip3 install requests~=2.31.0 Pillow~=10.0.0

# Install pixoo-api using npm
RUN npm i adamkdean/pixoo-api

# Here you can add further configurations or installations if needed
