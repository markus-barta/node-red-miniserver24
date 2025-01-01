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
    git

# Install ffmpeg
RUN apk add --no-cache ffmpeg

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

# Install wakeonlan using pip
RUN pip3 install wakeonlan

## Pixoo
# Install Python packages for Pixoo requirements
RUN pip3 install --no-cache-dir --upgrade requests~=2.31.0 Pillow~=10.0.0

# Clone pixoo repository
RUN mkdir -p $NODE_RED_HOME/.build && \
    git clone --depth 1 https://github.com/SomethingWithComputers/pixoo.git $NODE_RED_HOME/.build/pixoo

# Install pixoo python-lib
RUN pip3 install -e $NODE_RED_HOME/.build/pixoo

# Install dependencies for philipshue-events
# RUN npm install @types/eventsource@^1.1.15 @types/node@^20.11.24 eventsource@^2.0.2 \
#    glob@^8.1.0 node-red@^3.1.6 nodemon@^3.1.0 tsc@^2.0.4 typescript@^5.3.3 --save-dev

# Pre-install additional packages
RUN npm i adamkdean/pixoo-api                                 # API for Pixoo devices (e.g., LED displays)
RUN npm i axios@latest                                        # HTTP client for making requests
RUN npm i sharp@latest                                        # High-performance image processing
RUN npm i cheerio@latest                                      # Server-side jQuery-like HTML parsing
RUN npm i node-red-contrib-broadlink-control@latest           # Control Broadlink devices (e.g., IR blasters)
RUN npm i @yadomi/node-red-contrib-philipshue-events@latest   # Philips Hue integration for real-time events
RUN npm i node-red-contrib-bravia@latest
# RUN npm i evdev --unsafe-perm --no-update-notifier --only=production # Interact with input devices (for FLIRC) # replaced by using fs
