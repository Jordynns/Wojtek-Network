#!/bin/bash
set -e

# Define Variables
NAS_PATH="/srv/storage"
DASHY_CFG="https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/config/dashy/conf.yml"
PROMETHEUS_CFG="https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/config/prometheus/prometheus.yml"

# Upgrade System
sudo apt update && sudo apt upgrade -y

# Install Certs for Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install & Enable Docker
sudo apt install docker-ce=5:28.5.2-1~ubuntu.24.04~noble docker-ce-cli=5:28.5.2-1~ubuntu.24.04~noble containerd.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Create Portainer Container
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

# Create Docker Network for Containers
sudo docker network create -d ipvlan \
  --subnet=192.168.10.0/24 \
  --gateway=192.168.10.1 \
  -o parent=eth0 \
  ip_vlan


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

# Nginx Proxy Manager Directories
sudo mkdir -p \
    "/home/nginx/data" \
    "/home/nginx/letsencrypt"

# Grafana + Prometheus Directories/Config
sudo mkdir -p \
    "home/prometheus" \
    "home/prometheus/prometheus_data" \
    "home/grafana/data"
sudo curl -fsSL "$PROMETHEUS_CFG" -o /home/prometheus/prometheus.yml

echo "=== Docker & Portainer Install ==="
echo "✅ Installed Successfully"
echo "=================================="

echo "=== Docker Network ==="
echo "✅  Created ip_vlan"
echo "-   Subnet: 192.168.10.0/24"
echo "-   Gateway: 192.168.10.1"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: ipvlan"
echo "======================="

rm -- "$0"
