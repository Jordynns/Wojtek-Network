#!/bin/bash

sudo docker network create -d caddy \
  --subnet=192.168.10.0/24 \
  --gateway=192.168.10.1 \
  -o parent=eth0 \
  caddy

echo "=== Docker Network ==="
echo " ✅ Created caddy Network"
echo "-   Subnet: 192.168.10.0/24"
echo "-   Gateway: 192.168.10.1"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: caddy"
echo "======================="

rm -- "$0"
