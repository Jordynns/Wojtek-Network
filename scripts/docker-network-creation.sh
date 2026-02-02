#!/bin/bash

sudo docker network create -d ipvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  --ip-range=192.168.1.2/32 \
  -o parent=eth0 \
  caddy_ipvlan

echo "=== Docker Network ==="

echo "✅ Created caddy_ipvlan"

echo "-   Subnet: 192.168.1.0/24"
echo "-   Gateway: 192.168.1.1"
echo "-   IP Range: 192.168.1.2/32"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: caddy_ipvlan"

echo "======================="

sudo docker network create -d ipvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  --ip-range=192.168.1.3/32 \
  -o parent=eth0 \
  pihole_ipvlan

echo "=== Docker Network ==="

echo "✅ Created pihole_ipvlan"

echo "-   Subnet: 192.168.1.0/24"
echo "-   Gateway: 192.168.1.1"
echo "-   IP Range: 192.168.1.3/32"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: pihole_ipvlan"

echo "======================="

sudo docker network create -d ipvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  --ip-range=192.168.1.4/32 \
  -o parent=eth0 \
  jellyfin_ipvlan

echo "=== Docker Network ==="

echo "✅ Created jellyfin_ipvlan"

echo "-   Subnet: 192.168.1.0/24"
echo "-   Gateway: 192.168.1.1"
echo "-   IP Range: 192.168.1.4/32"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: jellyfin_ipvlan"

echo "======================="

rm -- "$0"
