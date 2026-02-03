#!/bin/bash

sudo docker network create -d ipvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  ip_vlan

sudo ip link add ipvl0 link eth0 type ipvlan mode l2
sudo ip addr add 192.168.1.10/24 dev ipvl0
sudo ip link set ipvl0 up
sudo ip route add 192.168.1.0/24 dev ipvl0


echo "=== Docker Network ==="
echo "✅ Created ip_vlan"
echo "-   Subnet: 192.168.1.0/24"
echo "-   Gateway: 192.168.1.1"
echo "-   Parent NIC ID: eth0"
echo "-   Network Name: ipvlan"
echo "======================="

rm -- "$0"
