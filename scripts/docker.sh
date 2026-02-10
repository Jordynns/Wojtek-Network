#!/bin/bash

# Pull required Docker images
docker pull portainer/portainer-ce:latest
docker pull caddy:latest
docker pull pihole/pihole:latest

# Create a custom network with your specified settings
docker network create -d macvlan \
  --subnet=192.168.10.0/24 \
  --gateway=192.168.10.1 \
  -o parent=eth0 \
  caddy

# Start Portainer container
docker run -d \
  --name portainer \
  --restart unless-stopped \
  --security-opt no-new-privileges:true \
  -v /etc/localtime:/etc/localtime:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /home/portainer/portainer-data:/data \
  --network caddy \
  -p 9000:9000 \
  portainer/portainer-ce:latest

# Start Caddy container
docker run -d \
  --name caddy \
  --restart unless-stopped \
  -v /home/caddy/Caddyfile:/etc/caddy/Caddyfile \
  -v /home/caddy/data:/data \
  -v /home/caddy/config:/config \
  --network caddy \
  -p 80:80 \
  -p 443:443 \
  caddy:latest

# Start Pi-hole container
docker run -d \
  --name pihole \
  --restart unless-stopped \
  -e TZ="Europe/London" \
  -e WEBPASSWORD="admin" \
  -e DNS1="8.8.8.8" \
  -e DNS2="8.8.4.4" \
  -e PIHOLE_INTERFACE="eth0" \
  -e IPV4_ADDRESS="192.168.10.2/24" \
  -e PIHOLE_DOCKER_TAG="latest" \
  -v /etc/pihole:/etc/pihole \
  -v /etc/dnsmasq.d:/etc/dnsmasq.d \
  --network caddy \
  -p 53:53/tcp \
  -p 53:53/udp \
  -p 67:67/udp \
  -p 80:80 \
  --cap-add NET_ADMIN \
  --dns 127.0.0.1 \
  --dns 8.8.8.8 \
  pihole/pihole:latest

# Optional: Create volumes for caddy if needed
docker volume create caddy_data
docker volume create caddy_config

echo "Containers have been created successfully."
