#!/bin/bash

# This script will setup Docker containers for Portainer, Caddy, and Pi-hole with proper networking and configurations

# Ensure Docker is installed and running
echo "Checking if Docker is installed..."
if ! command -v docker &> /dev/null; then
    echo "Docker could not be found. Please install Docker first."
    exit 1
fi

echo "Docker is installed, starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Create a custom Docker bridge network to avoid macvlan issues
echo "Creating a custom Docker bridge network..."
sudo docker network create --driver bridge caddy_network

# Pull required Docker images
echo "Pulling Docker images..."
sudo docker pull portainer/portainer-ce:latest
sudo docker pull caddy:latest
sudo docker pull pihole/pihole:latest

# Create a volume for Portainer data
echo "Creating volume for Portainer data..."
sudo docker volume create portainer_data

# Run Portainer container
echo "Running Portainer container..."
sudo docker run -d \
  --name portainer \
  --restart unless-stopped \
  --security-opt no-new-privileges:true \
  -v /etc/localtime:/etc/localtime:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v portainer_data:/data \
  --network caddy_network \
  -p 9000:9000 \
  portainer/portainer-ce:latest

# Run Caddy container
echo "Running Caddy container..."
sudo docker run -d \
  --name caddy \
  --restart unless-stopped \
  -v /home/caddy/Caddyfile:/etc/caddy/Caddyfile \
  -v /home/caddy/data:/data \
  -v /home/caddy/config:/config \
  --network caddy_network \
  -p 80:80 \
  -p 443:443 \
  caddy:latest

sudo docker run -d \
  --name pihole \
  --restart unless-stopped \
  -e TZ="Europe/London" \
  -e WEBPASSWORD="admin" \
  -e DNS1="8.8.8.8" \
  -e DNS2="8.8.4.4" \
  -e PIHOLE_INTERFACE="eth0" \
  -e IPV4_ADDRESS="192.168.10.4/24" \
  -e PIHOLE_DOCKER_TAG="latest" \
  -v /etc/pihole:/etc/pihole \
  -v /etc/dnsmasq.d:/etc/dnsmasq.d \
  --network caddy_network \
  -p 53:53/tcp \
  -p 53:53/udp \
  -p 67:67/udp \
  -p 80:80 \
  --cap-add NET_ADMIN \
  --dns 127.0.0.1 \
  --dns 8.8.8.8 \
  pihole/pihole:latest

# Ensure required ports are open in firewall (optional)
echo "Opening required ports in firewall..."
sudo ufw allow 9000/tcp  # For Portainer web GUI
sudo ufw allow 443/tcp   # For Caddy (HTTPS)
sudo ufw allow 80/tcp    # For Caddy (HTTP)
sudo ufw allow 53/tcp    # For Pi-hole DNS
sudo ufw allow 53/udp    # For Pi-hole DNS
sudo ufw allow 67/udp    # For Pi-hole DHCP (optional)

# Restart Docker containers to apply all changes
echo "Restarting containers..."
sudo docker restart portainer caddy pihole

# Output the IP addresses of the containers
echo "The following containers are running with their assigned IP addresses:"
sudo docker network inspect caddy_network | grep IPv4Address

# Finish setup
echo "Docker containers for Portainer, Caddy, and Pi-hole have been successfully created and are running."
echo "Access Portainer on http://<host-ip>:9000"
echo "Access Caddy on http://<host-ip>:80 or https://<host-ip>:443"
echo "Access Pi-hole admin on http://<host-ip>/admin (default password: 'admin')"
