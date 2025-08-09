# Inception 🐳

## Overview 🌐  
Inception sets up a secure Docker-based infrastructure with three containers:  
- **NGINX** 🔒: Web server with TLSv1.2/1.3  
- **WordPress** 📝: CMS running with PHP-FPM  
- **MariaDB** 💾: Database server  

## Features ✨  
- 🔐 TLS-secured communication  
- ⚙️ Automatic WordPress configuration on first run  
- 💾 Persistent storage via Docker volumes  
- 🛠️ Simple container management with Makefile commands  

## Prerequisites 📋  
- 🐳 Docker & Docker Compose  
- 🏠 Add `kyang.42.fr` to your hosts file  

## Installation & Setup 🚀  
Clone the repo, optionally configure `.env`, then run `make up` to start containers.

## Usage 🎮  
- `make up`: Start containers in detached mode  
- `make down`: Stop and remove containers  
- `make stop`: Stop containers without removing  
- `make start`: Start stopped containers  
- `make status`: Show running containers  

## Details ⚙️  
- NGINX serves WordPress securely on port 443  
- WordPress auto-configures on startup  
- MariaDB initialized with custom scripts  
- Persistent volumes store WordPress and database data  
- Services communicate over a custom Docker network  

