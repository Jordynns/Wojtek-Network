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
   - ***Routing***
   - ***Firewall***
5. [**Implementation**](#implementation)
   - [***Hyper-V***](#hyper-v-setup)
     - [***Virtual Switches***](#virtual-switches)
   - [***pfSense***](#pfsense-setup)
       - [***Video Guide***](#pfsense-video-guide)
   - [***Docker / Portainer***](#docker-/-portainer-setup)
       - [***Pi-Hole***](#pihole-setup)
       - [***Jellyfin Setup***](#jellyfin-setup)
6. [**Testing & Validation**](#testing--validation)
   - ***Connectivity (Ping)***
   - ***Services***
     - ***DNS***
       - ***Filtering (Pi-Hole)***
       - ***Custom Domain Resolution***
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
- CPU: [**Intel(R) Core(TM) i9-14900**](https://www.intel.com/content/www/us/en/products/sku/236793/intel-core-i9-processor-14900-36m-cache-up-to-5-80-ghz/specifications.html)
- GPU: Intel(R) UHD Graphics 770
- RAM: 128GB DDR4 @ 3600MHz

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

## pfSense Setup

Hyper-V Settings:
- Generation: Generation 2
- Memory: 2048MB (Static)
- NIC: WAN (Public) + LAN (Internal)
- Storage: 8gb (Static)
- ISO: pfSense-CE-2.7.2-RELEASE-amd64.iso
- Processor: 1
- Security: Secure Boot (Off)

#### pfSense Video Guide
[Video Guide](https://www.youtube.com/watch?v=c7Hl1ILJIPo)

VLAN Setup: No
WAN: hn0
LAN: hn1
Assign Interfaces: Custom IPv4 subnet, 192.168.10.1 (DHCP range 192.168.1.20 - 192.168.1.254)

## Ubuntu Server Setup

Hyper-V Settings:
- Generation: Generation 2
- Memory: 4096MB (Static)
- NIC: LAN (Internal)
- Storage: 12gb+ (Static) + 50gb (Static) NAS Drive
- ISO: ubuntu-24.04.3-live-server-amd64.iso
- Processor: 6
- Security: Secure Boot (Off)

Post Install (GUI):
```
sudo apt install xubuntu-desktop
sudo apt install cockpit
```

Navigate to 192.168.10.3:9090, mount NAS drive to /srv/storage location in ext4

Run:
```
sudo shown -R 1000:1000 /srv/storage
sudo chown -R 775 /srv/storage
```

```
sudo apt install samba
```

Run:
```
sudo nano /etc/samba/smb.conf
```

and add the following:
```
[NAS]
  path = /srv/storage
     browseable = yes
     read only = no
     guest ok = no
     valid users = root
     force user = root
```

Then Run:
```
sudo smbpasswd -a root
sudo smbpasswd -e root
```

#### Ubuntu Server Video Guide

## Configuring DNS/DHCP
*(Content goes here)*

## Docker / Portainer Setup
Run the docker.sh install script while SSH into Ubuntu server:
```
curl -fsSL -o docker.sh https://raw.githubusercontent.com/Jordynns/SomethingNetwork/refs/heads/main/scripts/docker.sh | bash
chmod +x docker.sh
./docker.sh
```
Navigate to the IP below to access the Portainer WEB-GUI:
```
https://192.168.10.3:9443/
```

Run this script to create a slices of the network for Docker container services:
```
curl -fsSL https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/docker-network-creation.sh | bash
```

## Caddy Setup (Reverse Proxy)
Firstly run the Caddy setup script to create the relevant directories and Caddyfile for defining IPs and Domain names for local reverse proxy:
```
curl -fsSL https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/caddy-setup.sh | bash
```

Create a new Portainer Stack within the WEB-GUI:
```
services:
  caddy:
    image: caddy:latest
    container_name: caddy
    restart: unless-stopped
    networks:
      ip_vlan:
        ipv4_address: 192.168.10.20
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /home/Caddy/Caddyfile:/etc/caddy/Caddyfile
      - /home/Caddy/data:/data
      - /home/Caddy/config:/config
networks:
  ip_vlan:
    external: true
```

To have clean Domain Name addresses for each service, continue to setup pihole below and when you get to local DNS setup that is when you will be able to implement what Caddy does.

## PiHole Setup
Head to Portainer in the WebGUI and create a stack. Name the stack "pihole" and copy the Docker compose YAML:
```
version: "3.9"

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    restart: unless-stopped
    networks:
      ip_vlan:
        ipv4_address: 192.168.10.2
    environment:
      TZ: "Etc/UTC"
      WEBPASSWORD: "Pa$$w0rd"
      FTLCONF_LOCAL_IPV4: "192.168.10.2"
      DNSMASQ_LISTENING: "all"
      QUERY_LOGGING: "true"
    volumes:
      - /docker/pihole/etc-pihole:/etc/pihole
      - /docker/pihole/etc-dnsmasq.d:/etc/dnsmasq.d
    ports:
      - "80:80"
      - "443:443"
networks:
  ip_vlan:
    external: true
```
This will create pihole on ip 192.168.10.2, To access the WebGUI head to:
```
https://192.168.10.2/admin
```

To update or change the password use the following command (inside Portainer Docker terminal):
```
pihole setpassword
```

### Pihole Local DNS Records
On the side navigation bar, head to "Settings" > "Local DNS Records" and within the left side create a few records:
```
DOMAIN | IP
192.168.10.2 : pihole.home
192.168.10.3 : portainer.home
192.168.10.4 : jellyfin.home
192.168.10.x : cockpit.home
```

## Jellyfin Setup

On the Ubuntu Server, create a main "jellyfin" directory, within that Directory create three sub-directories "cache", "config", and "media" optional but best practice to host media is within the media directory is to include extra directories such as "Movies", "TV Shows", and/or "YouTube" which can help keep it organised.

Head into Portainer and create a new stack named "jellyfin" and paste the YAML:
```
version: "3.8"
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    user: 1000:1000
    networks:
      jellyfin_ipvlan:
        ipv4_address: 192.168.1.4
    volumes:
      - /home/jellyfin/cache:/cache
      - /home/jellyfin/config:/config
      - /home/jellyfin/media:/media:ro
    restart: unless-stopped
networks:
  jellyfin_ipvlan:
    external: true
```

This will create a media server which can be accessed locally from the IP(s):

TCP:
```
http://192.168.1.4:8096
```
UDP:
```
UDP: http://192.168.1.4:7359
```

Create a script: (ADMIN)
```
sudo chown -R 1000:1000 /home/jellyfin
sudo chmod -R 775 /home/jellyfin
```
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

Additionally, you can add some optional filter list(s) to increase blocking potential and security by adding the following:
```
https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/multi.txt
```

To update the lists after adding, head to Tools > Update Gravity and update the lists or run the command:
```
pihole -g
```

### Custom Domain Resolution
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
