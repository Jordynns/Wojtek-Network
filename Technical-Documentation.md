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
  <h1>System Information</h1>
</div>

## Hardware Specifications

#### Our Specifications
- CPU: [**Intel(R) Core(TM) i9-14900**](https://www.intel.com/content/www/us/en/products/sku/236793/intel-core-i9-processor-14900-36m-cache-up-to-5-80-ghz/specifications.html)
- GPU: Intel(R) UHD Graphics 770
- RAM: 128GB DDR4 @ 3600MHz

## Software Used (OS, Hypervisors, Containers, Tools)

#### Operating Systems
- [**Linux**](https://www.linux.org/)
    - [***pfSense***](https://www.pfsense.org/)
    - [***Ubuntu Server***](https://ubuntu.com/download/server)
- [**Windows**](https://www.microsoft.com/en-us/windows/?r=1)
    - [***Windows 11***](https://www.microsoft.com/en-us/software-download/windows11)
 
#### Hypervisors
- [**Hyper-V**](https://en.wikipedia.org/wiki/Hyper-V)

### Containers
- [**Portainer**]
- [**Pi-Hole**]
- [**Jellyfin**]
- [**Dashy**]

#### Tools
- [**Search Engines**](https://en.wikipedia.org/wiki/Search_engine)
    - [***Firefox***](https://www.firefox.com/en-US/)
    - [***Brave***](https://brave.com/)
- [**GitHub**](https://github.com/)
- [**Discord**](https://discord.com/)
- [**Teams**](https://teams.live.com/free/)
- [**Cockpit**]
- [**Docker**]

<div align="center" id="network-design">
  <h1>Network Design</h1>
</div>

## Logical Topology Diagram
*(Content goes here)*

## IP Addressing Scheme

Each service has been allocated their own IP to allow for easier management and tracking of services

|       Service       	|               IP               	|                          Usage                          	|
|:-------------------:	|:------------------------------:	|:-------------------------------------------------------:	|
|       pfSense       	|          192.168.10.1          	|                 Default Gateway & Router                	|
|       Pi-hole      	  |          192.168.10.2          	|           Primary DNS & Ad-blocking/Filtering           	|
|    Ubuntu Server    	|          192.168.10.3          	|               Docker Host & NAS (Cockpit)               	|
|       Jellyfin      	|          192.168.10.4          	|                     Media Streaming                     	|
|        Dashy        	|          192.168.10.5          	|              Network Dashboard via Browser              	|
|      Bitwarden      	|          192.168.10.6          	|                 Secure Password Manager                 	|
| Nginx Proxy Manager 	|          192.168.10.20          | Reverse Proxy w/ Signed Certs for HTTPS Traffic (Local) 	|
|      DHCP Pool      	| 192.168.10.20 - 192.168.10.254 	|            Dynamic IP allocation for clients            	|


## Routing
The pfSense virtual machine works as the router which does Network Address Translation (NAT) to allow internal devices to connect to the Internet (WAN) via the Hyper-V NIC / Interface.

## Firewall

Basic pfSense Firewall configuration, essentially block all and allow what is needed

|   Protocol   	|    Source   	| Port 	| Destination  	| Port    	| Gateway 	| Description                          	|
|:------------:	|:-----------:	|:----:	|--------------	|---------	|---------	|--------------------------------------	|
| *             | * 	          |   *  	| LAN Address 	| 8443     	| *       	| Anti-Lockout Rule (pfSense Default)   |
| IPv4 TCP/UDP  | LAN Subnets 	|   *  	| 192.168.10.2 	| 53      	| *       	| Allow DNS - Pi-Hole                  	|
| IPv4 TCP/UDP 	| LAN Subnets 	|   *  	| *            	| 53      	| *       	| Reject to Prevent DNS Bypass          |
| IPv4 TCP      | LAN Subnets 	|   *  	| *            	| 80, 443 	| *       	| Allow Common Internet Ports (HTTP(S) 	|
| IPv4 UDP    	| LAN Subnets 	|   *  	| *            	| 123       | *       	| NTP Time Sync (SSL/HTTPS)        	    |
| IPv4 ICMP    	| LAN Subnets 	|   *  	| *            	| *       	| *       	| Enable Ping usage on the network      |
| IPv4 TCP/UDP  | 192.168.10.2 	|   *  	| * 	          | 53      	| *       	| Allow Pi-Hole Outbound DNS            |
| IPv4 *    	  | LAN Subnets 	|   *  	| *            	| *       	| *       	| Block all traffic not defined        	|

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
Run the docker.sh install script:
```
sudo curl -fsSL -o docker.sh https://raw.githubusercontent.com/Jordynns/Wojtek-Network/refs/heads/main/scripts/docker.sh | bash
sudo chmod +x docker.sh
./docker.sh
```

> [!TIP]
> Navigate to https://192.168.10.3:9000/ to access the Web-GUI

## Containers / Services
To Setup all containers, use the following docker-compose.yml and create a stack within Portainer:

```
version: "3.9"

services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
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

  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    restart: unless-stopped
    user: "1000:1000"
    networks:
      ip_vlan:
        ipv4_address: 192.168.10.4
    environment:
      JELLYFIN_HTTP_PORT: "80"
    volumes:
      - /srv/storage/jellyfin/cache:/cache
      - /srv/storage/jellyfin/config:/config
      - /srv/storage/jellyfin/media:/media:ro

  dashy:
    image: lissy93/dashy
    container_name: dashy
    restart: unless-stopped
    networks:
      ip_vlan:
        ipv4_address: 192.168.10.5
    environment:
      NODE_ENV: production
      UID: "1000"
      GID: "1000"
      PORT: "80"
    volumes:
      - /home/dashy/conf.yml:/app/user-data/conf.yml
      
  bitwarden:
   image: vaultwarden/server:latest
   container_name: bitwarden
   restart: unless-stopped
   networks:
     ip_vlan:
       ipv4_address: 192.168.10.6
   volumes:
     - /home/bitwarden/bw-data:/data
   environment:
    DOMAIN: "https://bitwarden.home.arpa"
    WEBSOCKET_ENABLED: "true"
    SIGNUPS_ALLOWED: "true"
    ADMIN_TOKEN: "Pa$$w0rd"

  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: unless-stopped
    networks:
      ip_vlan:
        ipv4_address: 192.168.10.20
    ports:
    - "80:80"
    - "443:443"
    - "81:81"
    volumes:
    - /home/nginx/data:/data
    - /home/nginx/letsencrypt:/etc/letsencrypt

networks:
  ip_vlan:
    external: true
```

## Reverse Proxy (Nginx Proxy Manager)

<hr/>

## Creation of Certificate Authority
Firstly you will need to create and generate a Local Certificate Authority, navigate to pfSense Web-GUI > System > Certificates > Authorities > +Add

- Descriptive Name: Local-CA
- Method: Create an internal Certificate Authority
- Key Type: RSA 2048
- Digest Alorithm: sha256
- Lifetime (days): 3650 (10 years)
- Common Name: internal-ca
- Personal Preference Settings:
  - Country Code: GB
  - State: Scotland
  - City: Glasgow
  - Organisation: Wojtek

> [!TIP]
> Download and install the Local-CA certificate on endpoints e.g. Windows 11 client
> Open it > Local Machine > Certificate Store > Trusted Root Certification Authorities > Finish

## Service Certificates & Keys

Next generate individual Certificates & Keys for each service e.g. Pi-Hole, Bitwarden, etc.. Navigate to pfSense Web-GUI > System > Certificates > Certificates > +Add

- Method: Create an internal Certificate
- Descriptive Name: ExampleService-cert
- Certificate Authority: Local-CA
- Key Type: RSA 2048
- Digest Algorithm: sha256
- Lifetime (days): 800
- Common Name: ExampleURL.home.arpa
- Personal Preference Settings:
  - Country Code: GB
  - State: Scotland
  - City: Glasgow
  - Organisation: Wojtek
- Certificate Type: Server Certificate

> [!TIP]
> Download both Certificate and Key for the Service

## Nginx Proxy Manager Configuration

Navigate towards the IP for Nginx Proxy Manager (192.168.10.20) and after creating/logging in navigate to Certificates > Add Certificate > Custom Certificate

- Name: ExampleService
- Certificate Key: ExampleService-cert.key
- Certificate: ExampleService-cert.crt
- Intermediate Certificate: Local-CA

After you have implemented the Service Certificate navigate to Hosts > Proxy Hosts > Add Proxy Host

- Details
  - Domain Names: ExampleService.home.arpa
  - Scheme: http
  - Forward Hostname / IP: 192.168.10.x
  - Forward Port: xx
  - Options:
    - Cache Assets: ❌ 
    - Block Common Exploits: ✅
    - Websockets Support: ✅
- SSL
  - SSL Certificate: ExampleService
  - Force SSL: ✅
  - HTTP/2 Support: ✅
  - HSTS Enabled: ❌
  - HSTS Sub-domains: ❌

> [!TIP]
> Be sure to make the domain name to resolve to Nginx Proxy Manager IP within Pi-Hole
> | Domain                      | IP Address       |
> |-----------------------------|------------------|
> | ExampleService.home.arpa    | 192.168.10.20    |

<div align="center" id="testing--validation">
  <h1>Testing & Validation</h1>
</div>

### Connectivity (Ping)
To test connectivity between Network <-> Server and Client <-> Server you can utilise the ping command

Windows 11 Client <-> Server:
```
ping 192.168.10.3
```

Server <-> Windows 11 Client:
```
ping 192.168.10.21
```

### DHCP
Connecting clients to the network shall dish out IPs in the range of 192.168.10.20 - 192.168.10.254... The Windows 11 client shall have the IP of 192.168.10.21+

<hr/>

<div align="center" id="maintenance--backup">
  <h1>Maintenance & Backup</h1>
</div>

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

### Full Configurations
*(Content goes here)*

### References
*(Content goes here)*
