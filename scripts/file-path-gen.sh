#!/bin/bash
set -e

NAS_PATH="/srv/storage"
DASHY_CFG="https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/config/dashy/conf.yml"

sudo mkdir -p \
  "$NAS_PATH/jellyfin/cache" \ 
  "$NAS_PATH/jellyfin/config" \
  "$NAS_PATH/jellyfin/media"/{Movies,TV,Anime,YouTube}

sudo mkdir -p /home/dashy
sudo curl -fsSL "$DASHY_CFG" -o /home/dashy/conf.yml
