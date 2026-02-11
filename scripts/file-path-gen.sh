#!/bin/bash
set -e

# Define Variables
NAS_PATH="/srv/storage"
DASHY_CFG="https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/config/dashy/conf.yml"

# Creat Jellyfin Directories on the NAS
sudo mkdir -p \
  "$NAS_PATH/jellyfin/cache" \
  "$NAS_PATH/jellyfin/config" \
  "$NAS_PATH/jellyfin/media"/{Movies,TV,Anime,YouTube}

# Set Permissions (ROOT)
sudo chown -R 1000:1000 "$NAS_PATH/jellyfin"
sudo chmod -R 775 "$NAS_PATH/jellyfin/media"
sudo chmod -R 775 "$NAS_PATH/jellyfin/config"
sudo chmod -R 775 "$NAS_PATH/jellyfin/cache"

# Dashy
sudo mkdir -p /home/dashy
sudo curl -fsSL "$DASHY_CFG" -o /home/dashy/conf.yml
