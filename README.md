<div align="center">
  <img src="logo.png" alt="Wojtek Network Logo" width="500"/>

  **A Secure, Fully Virtualized Enterprise-Grade Home Lab**

  [![Hyper-V](https://img.shields.io/badge/Hyper--V-Windows-blue?style=for-the-badge&logo=microsoft-hyper-v)](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/)
  [![pfSense](https://img.shields.io/badge/Firewall-pfSense-red?style=for-the-badge&logo=pfsense)](https://www.pfsense.org/)
  [![Docker](https://img.shields.io/badge/Container-Docker-lightblue?style=for-the-badge&logo=docker)](https://www.docker.com/)
  [![Ubuntu](https://img.shields.io/badge/OS-Ubuntu-orange?style=for-the-badge&logo=ubuntu)](https://ubuntu.com/)

  [🚀 Quick Start](#quick-start) •  [📗 User Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/User-Documentation.md) • [📘 Technical Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md)
</div>

---

<div align="center" id="overview">
  <h1>Overview</h1>
</div>

**Wojtek Network** is a fully virtualized home network environment built using **Microsoft Hyper-V**.  
The project aims to simulate a realistic, secure, and scalable home or small-office network by combining virtual machines, routing, containerised services, and centralised management tools.

The environment demonstrates real-world networking concepts including **network segmentation**, **firewalling**, **DNS filtering**, **DHCP**, **container orchestration**, and **service hosting**.

<div align="center" id="quick-start">
  <h1>🚀 Quick Start</h1>
</div>

Welcome to the **Wojtek Network**. Depending on your goal, choose a path below:

### 1. 📖 Understand the Goal
New here? Start by reviewing our **[Project Objectives](#-project-objectives)** to see the security standards and networking milestones we aimed to achieve.

### 2. 🏗️ Explore the Blueprint
Before deploying, visualize the flow of traffic. See the **[Logical Topology Diagram](#-architecture-overview)** to understand how pfSense segments the WAN from the LAN.

### 3. 🛠️ Deploy the Lab
Ready to build? Our **[Technical Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md)** provides a step-by-step implementation guide:
* **Level 1:** [Hyper-V & pfSense Setup](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md#pfsense-setup)
* **Level 2:** [Docker & Service Orchestration](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md#docker--portainer-setup)
* **Level 3:** [SSL & Reverse Proxy Config](https://github.com/Jordynns/Wojtek-Network/blob/main/Technical-Documentation.md#reverse-proxy)

### 4. 👤 Access the Services
If the network is already running, head over to the **[User Documentation](https://github.com/Jordynns/Wojtek-Network/blob/main/User-Documentation.md)** to learn how to map the NAS, connect to Jellyfin, and trust the Local Certificate Authority.

<div align="center" id="project-objectives">
  <h1>🎯 Project Objectives</h1>
</div>

- Design and deploy a **secure virtual network** using Hyper-V
- Implement **DHCP, routing and firewalling** with pfSense
- Provide **DNS filtering and ad-blocking** using Pi-hole
- Host services using **Docker & Portainer**
- Demonstrate **media hosting** via Jellyfin
- Validate connectivity, security, and reliability

<div align="center" id="architecture-overview">
  <h1>🧱 Architecture Overview</h1>
</div>

The network consists of multiple virtual machines connected through isolated virtual switches:

- **Hyper-V Host** – Core virtualization platform
- **pfSense Firewall** – Routing, NAT, firewall rules, DHCP
- **Ubuntu Server** – Docker host for services
- **Docker Services**
  - Portainer (container management)
  - Pi-hole (DNS filtering, ad-blocking & local DNS resolution)
  - Jellyfin (media server)
  - Dashy (dashboard for services & tools)

Traffic is segmented between **WAN** and **LAN**, with pfSense enforcing security boundaries.

<div align="center" id="team-information">
  <h1>👥 Team Information</h1>
</div>

<div align="center">
  
| Name | Primary Role | GitHub Profile |
| :--- | :--- | :--- |
| **Jordyn** | Network Implementation / Documentation | [@Jordynns](https://github.com/Jordynns) |
| **Marek** | Monitoring / MFA | [@marekslapa](https://github.com/marekslapa) |
| **Adam** | Website Design & Development | [@adamc02](https://github.com/adamc02) |
| **Shae** | Website Pages & MoM | [@Tadger65443](https://github.com/Tadger65443) |

**Course:** HNC NextGen Computing  
**Project:** Virtualised Network Simulation  
**Submission:** October 23, 2025

</div>

<div align="center" id="license-&-usage">
  <h1>📌 License & Usage</h1>
</div>

This project was developed **for educational purposes** as part of the HNC NextGen Computing course. The repository contains documentation and installation scripts that retrieve software from official upstream sources. Third-party software remains subject to its own licenses.

<div align="center">
  <sub>Designed, deployed, and documented by the Wojtek team 🖧</sub>
</div>
