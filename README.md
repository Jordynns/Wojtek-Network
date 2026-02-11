<div align="center">
  <img src="logo.png" alt="Project Logo" width="400"/>
  <div align="center">

  <!-- Community -->
  <img src="https://img.shields.io/github/contributors/jordynns/wojtek-network?style=flat-square" />
  <img src="https://img.shields.io/github/stars/jordynns/wojtek-network?style=flat-square" />

  <!-- Project Health -->
  <img src="https://img.shields.io/github/last-commit/jordynns/wojtek-network?style=flat-square" />
  <img src="https://img.shields.io/github/repo-size/jordynns/wojtek-network?style=flat-square" />
  <img src="https://img.shields.io/github/license/jordynns/wojtek-network?style=flat-square" />

</div>
</div>

---

## 📘 Project Summary

**Wojtek Network** is a fully virtualized home network environment built using **Microsoft Hyper-V**.  
The project simulates a realistic, secure, and scalable home or small-office network by combining virtual machines, firewall routing, containerized services, and centralized management tools.

The environment demonstrates real-world networking concepts including **network segmentation**, **firewalling**, **DNS filtering**, **DHCP**, **container orchestration**, and **service hosting**.

---

## 🎯 Project Objectives

- Design and deploy a **secure virtual network** using Hyper-V
- Implement **routing and firewalling** with pfSense
- Provide **DNS filtering and ad-blocking** using Pi-hole
- Host services using **Docker & Portainer**
- Demonstrate **media hosting** via Jellyfin
- Validate connectivity, security, and reliability
- Apply best practices for **maintenance, backups, and recovery**

---

## 🧱 Architecture Overview

The network consists of multiple virtual machines connected through isolated virtual switches:

- **Hyper-V Host** – Core virtualization platform
- **pfSense Firewall** – Routing, NAT, firewall rules, DHCP
- **Debian 13 Client** – Management / client workstation
- **Ubuntu Server** – Docker host for services
- **Docker Services**
  - Portainer (container management)
  - Pi-hole (DNS filtering & ad-blocking)
  - Jellyfin (media server)

Traffic is segmented between **WAN** and **LAN**, with pfSense enforcing security boundaries.

---

## 🛠️ Technologies Used

### Virtualization & Networking
- Microsoft Hyper-V
- Virtual Switches (WAN / LAN)
- pfSense CE

### Operating Systems
- Debian 13 “Trixie”
- Ubuntu Server 24.04 LTS
- Windows 11 (Host)

### Services & Tools
- Docker
- Portainer
- Pi-hole
- Jellyfin
- SSH (RSA key authentication)

---

## 📄 Documentation

### 👤 User Documentation
End-user setup, usage instructions, and basic troubleshooting.

➡️ **[Read User Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/User-Documentation.md)**

---

### 🛠️ Technical Documentation
Full technical breakdown including architecture, configuration, implementation steps, and validation.

➡️ **[Read Technical Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md)**

This repository contains documentation and installation scripts that retrieve
software from official upstream sources. Third-party software remains subject
to its own licenses.

---

## 🧪 Testing & Validation

The network has been validated through:
- VM-to-VM connectivity testing (ICMP / Ping)
- DNS resolution and filtering verification
- Service availability testing (Portainer, Pi-hole, Jellyfin)
- Firewall and routing validation via pfSense

---

## 👥 Team Information

**Course:** HNC NextGen Computing  
**Project Type:** Virtualized Network  
**Submission Date:** 23/10/2025  

### Team Members
- [Jordyn](https://github.com/Jordynns)
- [Marek](https://github.com/marekslapa)
- [Adam](https://github.com/adamc02)
- [Shae](https://github.com/Tadger65443)

---

## 📌 License & Usage

This project was developed **for educational purposes** as part of the HNC NextGen Computing course.

---

<div align="center">
  <sub>Designed, deployed, and documented by the Wojtek team 🖧</sub>
</div>
