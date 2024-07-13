FROM nodered/node-red:latest

USER root

# Installieren der benötigten Pakete
RUN apt-get update && apt-get install -y \
    python3-tkinter \
    wakeonlan \
    samba \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clonen des pixoo Repositories
RUN git clone https://github.com/SomethingWithComputers/pixoo.git /pixoo

USER node-red

# Hier können Sie weitere Konfigurationen oder Installationen hinzufügen, falls nötig