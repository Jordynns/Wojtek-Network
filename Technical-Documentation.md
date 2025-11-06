<div align="center">
  <h1>SomethingNetwork Technical Documentation</h1>
</div>
<div align="center">
  <img src="logo.png">
</div>

<div align="center">
  <h1>Table of Contents</h1>
</div>

1. [**Summary**](#summary)
2. [**Introduction**](#introduction)
   - ***Overview of Virtualization***
   - ***Objectives of SomethingNetwork***
3. [**System Requirements**](#system-requirements)
   - ***Hardware Specifications***
   - ***Software Used***
        - [***Operating Systems***](#operating-systems)
        - [***Hypervisors***](#hypervisors)
        - [***Tools***](#tools)
4. [**Network Design**](#network-design)
   - ***Logical Topology Diagram***
   - ***IP Addressing Scheme***
   - ***VLAN Configuration***
   - ***Routing***
   - ***Firewall***
5. [**Implementation**](#implementation)
   - [***Hyper-V***](#hyper-v-setup)
     - [***Virtual Switches***](#virtual-switches)
   - [***Debian 13 Client***](#debian-13-client-setup)
       - [***Video Guide***](#client-video-guide)
   - [***pfSense***](#pfsense-setup)
       - [***Video Guide***](#pfsense-video-guide)
   - [***Docker / Portainer***](#portainer-setup)
       - ***Pi-Hole***
6. [**Testing & Validation**](#testing--validation)
   - ***Connectivity (Ping)***
   - ***Services***
     - ***DNS***
       - ***Filtering (Pi-Hole)***
       - ***Custom Resolution***
     - ***DHCP***
7. [**Maintenance & Backup**](#maintenance--backup)
   - ***Create VM Snapshots / Checkpoints***
   - ***Updating Devices***
   - ***Network Backup / Recovery***
8. [**Troubleshooting**](#troubleshooting)
   - ***Common Issues***
9. [**Conclusion**](#conclusion)
   - ***Achievements***
   - ***Lessons Learned***
   - ***Future Improvements***
10. [**Appendices**](#appendices)
    - ***Full Configurations***
    - ***References***

<hr/>

<div align="center" id="summary">
  <h1>Summary</h1>
</div>

⠀

*(Content goes here)*

<hr/>

<div align="center" id="introduction">
  <h1>Introduction</h1>
</div>

⠀

## Overview of Virtualization
*(Content goes here)*

## Objectives of SomethingNetwork
*(Content goes here)*

<hr/>

<div align="center" id="system-requirements">
  <h1>System Requirements</h1>
</div>

⠀

## Hardware Specifications
*(Placeholder Description)*

#### Minimum Specifications
- CPU:
- GPU:
- RAM:

#### Recommended Specifications
- CPU:
- GPU:
- RAM:

#### Our Specifications
- CPU:
- GPU:
- RAM:

## Software Used (OS, Hypervisors, Tools)
*(Placeholder Description)*

#### Operating Systems
- [**Linux**](https://www.linux.org/)
    - [***Debian 13 "Trixie"***](https://www.debian.org/download)
    - [***pfSense***](https://www.pfsense.org/)
    - [***Ubuntu Server***](https://ubuntu.com/download/server)
- [**Windows**](https://www.microsoft.com/en-us/windows/?r=1)
    - [***Windows 11***](https://www.microsoft.com/en-us/software-download/windows11)
 
#### Hypervisors
- [**Hyper-V**](https://en.wikipedia.org/wiki/Hyper-V)

#### Tools
- [**Search Engines**](https://en.wikipedia.org/wiki/Search_engine)
    - [***DuckDuckGo***](https://duckduckgo.com/)
    - [***Firefox***](https://www.firefox.com/en-US/)
    - [***Brave***](https://brave.com/)
- [**GitHub**](https://github.com/)
- [**Discord**](https://discord.com/)
- [**Teams**](https://teams.live.com/free/)

<div align="center" id="network-design">
  <h1>Network Design</h1>
</div>

⠀

## Logical Topology Diagram
*(Content goes here)*

## IP Addressing Scheme
*(Content goes here)*

## VLAN Configuration
*(Content goes here)*

## Routing
*(Content goes here)*

## Firewall
*(Content goes here)*

<hr/>

<div align="center" id="implementation">
  <h1>Implementation</h1>
</div>

⠀

## Hyper-V Setup
*(Placeholder Description)*

#### Virtual Switches
- **Wide Area Network (WAN)**
  - **Name:** *WAN*
  - **Connection Type:** *External (Select Host NIC)*
- **Local Area Network (LAN)**
  - **Name:** *LAN*
  - **Connection Type:** *Internal*

## Debian 13 Client Setup
*(Content goes here)*

#### Client Video Guide
[Video Guide](https://www.youtube.com/watch?v=AdMjQk7OZYQ)

## pfSense Setup

#### pfSense Video Guide
[Video Guide](https://www.youtube.com/watch?v=c7Hl1ILJIPo)

## Ubuntu Server Setup

#### Ubuntu Server Video Guide

## Configuring DNS/DHCP
*(Content goes here)*

## Portainer Setup
Run the docker.sh install script while SSH into Ubuntu server:
```
curl -fsSL https://raw.githubusercontent.com/Jordynns/SomethingNetwork/refs/heads/main/scripts/docker.sh | bash
```


## Pi-Hole Setup
Run this script to create a slice of network for Docker container services:
```
curl -fsSL https://raw.githubusercontent.com/Jordynns/SomethingNetwork/refs/heads/main/scripts/docker-network.sh | bash
```

After you have setup the network, head to Portainer in the WebGUI and create a stack. Name the stack "pihole" and copy the Docker compose YAML:
```
version: "3.9"
networks:
  pihole_ipvlan:
    external: true

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    restart: unless-stopped
    environment:
      TZ: "Etc/UTC"
      WEBPASSWORD: "changeme"
    volumes:
      - /docker/pihole/etc-pihole:/etc/pihole
      - /docker/pihole/etc-dnsmasq.d:/etc/dnsmasq.d
    networks:
      pihole_ipvlan:
        ipv4_address: 192.168.1.2
```

Change the password, this will create pihole on ip 192.168.1.2, To access the WebGUI head to https://192.168.1.2/admin

<hr/>

<div align="center" id="testing--validation">
  <h1>Testing & Validation</h1>
</div>

⠀

## Connectivity (Ping)
*(Content goes here)*

## Services
*(Placeholder Description)*

### DNS

### Filtering (Pi-Hole)
*(Content goes here)*

### Custom Resolution
*(Content goes here)*

### DHCP
*(Content goes here)*

<hr/>

<div align="center" id="maintenance--backup">
  <h1>Maintenance & Backup</h1>
</div>

⠀

### Create VM Snapshots / Checkpoints
*(Content goes here)*

### Updating Devices
*(Content goes here)*

### Network Backup / Recovery
*(Content goes here)*

<hr/>

<div align="center" id="troubleshooting">
  <h1>Troubleshooting</h1>
</div>

⠀

### Common Issues
*(Content goes here)*

<hr/>

<div align="center" id="conclusion">
  <h1>Conclusion</h1>
</div>

⠀

### Achievements
*(Content goes here)*

### Lessons Learned
*(Content goes here)*

### Future Improvements
*(Content goes here)*

<hr/>

<div align="center" id="appendices">
  <h1>Appendices</h1>
</div>

⠀

### Full Configurations
*(Content goes here)*

### References
*(Content goes here)*
