<div align="center">
  <img src="logo.png" alt="Project Logo" width="400"/>
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

<div align="center" id="system-requirements">
  <h1>System Requirements</h1>
</div>

## Hardware Specifications

#### Our Specifications
- CPU: [**Intel(R) Core(TM) i9-14900**](https://www.intel.com/content/www/us/en/products/sku/236793/intel-core-i9-processor-14900-36m-cache-up-to-5-80-ghz/specifications.html)
- GPU: Intel(R) UHD Graphics 770
- RAM: 128GB DDR4 @ 3600MHz

## Software Used (OS, Hypervisors, Tools)

#### Operating Systems
- [**Linux**](https://www.linux.org/)
    - [***pfSense***](https://www.pfsense.org/)
    - [***Ubuntu Server***](https://ubuntu.com/download/server)
- [**Windows**](https://www.microsoft.com/en-us/windows/?r=1)
    - [***Windows 11***](https://www.microsoft.com/en-us/software-download/windows11)
 
#### Hypervisors
- [**Hyper-V**](https://en.wikipedia.org/wiki/Hyper-V)

#### Tools
- [**Search Engines**](https://en.wikipedia.org/wiki/Search_engine)
    - [***Firefox***](https://www.firefox.com/en-US/)
    - [***Brave***](https://brave.com/)
- [**GitHub**](https://github.com/)
- [**Discord**](https://discord.com/)
- [**Teams**](https://teams.live.com/free/)

<div align="center" id="network-design">
  <h1>Network Design</h1>
</div>

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

## Host Hyper-V Settings

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
- Storage: 6gb (Static)
- ISO: pfSense-CE-2.7.2-RELEASE-amd64.iso
- Processor: 1
- Security: Secure Boot (Off)

VLAN Setup: No
WAN: hn0
LAN: hn1
Assign Interfaces: Custom IPv4 subnet, 192.168.10.1 (DHCP range 192.168.10.20 - 192.168.10.254)

## Ubuntu Server Setup

Hyper-V Settings:
- Generation: Generation 2
- Memory: 4096MB (Static)
- NIC: LAN (Internal)
- Storage: 42gb+ (Static) + 5-20gb (Static) NAS Drive
- ISO: ubuntu-24.04.3-live-server-amd64.iso
- Processor: 6
- Security: Secure Boot (Off)

Post Install:
```
sudo apt update && apt upgrade -y
```

Optional (GUI):
```
sudo apt install xubuntu-desktop -y
```

## NAS Setup
Install cockpit

```
sudo apt install cockpit -y
```

After install navigate to 192.168.10.3:9090 and mount NAS drive to /srv/storage location in ext4

Run:
```
sudo apt install samba
sudo adduser nasuser
sudo smbpasswd -a nasuser
sudo smbpasswd -e nasuser
sudo chown -R nasuser:nasuser /srv/storage
sudo chmod -R 775 /srv/storage
```

Update /etc/samba/smb.conf file with additional lines [smb.conf](https://github.com/Jordynns/Wojtek-Network/blob/main/config/samba/smb.conf)


Login with:
```
nasuser:*****
```

## Docker / Portainer Setup
Generate the required file paths for Docker Containers
```
sudo curl -fsSL -o docker.sh https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/file-path-gen.sh | bash
sudo chmod +x docker.sh
./docker.sh
```

Run the docker.sh install script:
```
sudo curl -fsSL -o docker.sh https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/docker.sh | bash
sudo chmod +x docker.sh
./docker.sh
```

Run this script to create a slices of the network for Docker container services:
```
curl -fsSL https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/docker-network-creation.sh | bash
```

Navigate to the IP below to access the Portainer WEB-GUI:
```
https://192.168.10.3:9443/
```

<div align="center" id="testing--validation">
  <h1>Testing & Validation</h1>
</div>

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

### Custom Domain Resolution
Within pihole WEB-GUI head to the side navigation bar, then head to "Settings" > "Local DNS Records" and within the left side create a few records:
| Domain          | IP Address       |
|-----------------|------------------|
| pihole.home     | 192.168.10.2     |
| portainer.home  | 192.168.10.3     |
| jellyfin.home   | 192.168.10.4     |
| cockpit.home    | 192.168.10.x     |


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

## Common Issues

### Mapping NAS
To Map the NAS on Windows Run in CMD:
```
net use Z: \\192.168.10.3\nas /persistent:yes
```

### Pi-Hole Password Wrong
To update or change the password use the following command (inside Portainer Docker terminal):
```
pihole setpassword
```

### Pi-Hole Filter Lists Not Updating
To update the lists after adding, head to Tools > Update Gravity and update the lists or run the command:
```
pihole -g
```

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
