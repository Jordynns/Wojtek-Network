#!/bin/bash

sudo docker network create -d ipvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  --ip-range=192.168.1.200/29 \
  -o parent=eth0 \
  pihole_ipvlan

echo "=== Docker Network ==="

echo "✅ Created Successfully"

echo "Subnet: 192.168.1.0/24"
echo "Gateway: 192.168.1.1"
echo "IP Range: 192.168.1.200/29"
echo "Parent NIC ID: eth0"
echo "Network Name: pihole_ipvlan"

echo "======================="

