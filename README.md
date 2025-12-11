# Into the Upside Down - CTF Machine

A comprehensive Capture The Flag (CTF) machine featuring multiple attack vectors and Upside Down-themed challenges. This CTF machine simulates a multi-layered environment with web applications, SSH machines, FTP services, and database interactions, classified as **Moderate** difficulty.

## 🏗️ Architecture Overview

The CTF machine consists of the following components:

- **Web Application** (Port 80): PHP-based web interface (Hawkins Lab) with SQL injection filter bypass challenges.
- **FTP Server** (Ports 20-21, 65500-65515): File transfer service with encrypted secrets.
- **MySQL Database** (Port 3306): User authentication (The Party credentials) and data storage.
- **SSH Machines** (Ports 2222-2224): Three separate Linux machines with privilege escalation challenges.
- **Flag System**: Multiple flags hidden across different services and user accounts.

## 🚀 Quick Deployment

### Prerequisites

- Docker and Docker Compose installed
- Bash shell environment
- `sshpass` utility for SSH automation

### Local Deployment

1. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd IntoTheUpsideDown
   ```

2. **Generate Dynamic Keys**
   ```bash
   chmod +x genkey.sh
   ./genkey.sh
   ```
   This script generates unique keys for each challenge and starts the CTF environment.

3. **Manual Docker Compose Deployment**
   ```bash
   docker-compose up --build -d
   ```

4. **Verify Services**
   ```bash
   docker-compose ps
   ```

## 📋 Service Details

### Web Application (Port 80)
- **Technology**: PHP 7.4 with Apache
- **Features**: 
  - Filtered SQL Injection (Moderate)
  - User-Agent & IP Restricted Admin Panel (Moderate)
- **Key Locations**: `/admin/`, `/login/`, `/credentials/`

### FTP Server (Ports 20-21, 65500-65515)
- **Technology**: vsftpd
- **Features**:
  - Anonymous access
  - Banner with Password Hint
  - Encrypted Zip File

### MySQL Database (Port 3306)
- **Users Table**: Contains character credentials from the Upside Down dimension
  - Eleven, Hopper, Mike, Dustin, Lucas

### SSH Machines

#### VM1 (Port 2223) - Joyce & Will
- **Users**: joyce, will
- **Features**: Forensics (USB Image)

#### VM2 (Port 2222) - Steve & Dustin
- **Users**: steve, dustin
- **Features**: Path Hijacking Privilege Escalation (Moderate)

#### VM3 (Port 2224) - Vecna & Max
- **Users**: vecna, max
- **Features**: Tar Wildcard Injection Privilege Escalation (Moderate)

## 🔧 Advanced Deployment

### Custom Configuration

#### Environment Variables
```bash
# FTP Configuration
FTPD_BANNER="Welcome to the Upside Down FTP. The gate is locked. Password Hint: gate_access"
```

#### Port Mapping
- Web: `80:80`
- FTP: `20-21:20-21`, `65500-65515:65500-65515`
- Database: `3306:3306`
- SSH VM1: `2223:22`
- SSH VM2: `2222:22`
- SSH VM3: `2224:22`

## 🏴 Flags

This CTF contains **10 Flags** hidden across different services and user accounts:

### Web Application Flags (3)
1. `CTCFlag{foundation_level_base}` - Admin panel access
2. `CTCFlag{secondary_level_access}` - Login bypass
3. `CTCFlag{hidden_level_archive}` - Credentials/steganography

### FTP Flag (1)
4. `CTCFlag{gate_access_portal}` - FTP encrypted zip file

### SSH Machine Flags (6)
5. `CTCFlag{communication_level_voice}` - Will (VM1)
6. `CTCFlag{joyce_foundation_protector_Q1RDRmxhZ3tlbGl4}` - Joyce (VM1)
7. `CTCFlag{perception_level_sight}` - Dustin (VM2)
8. `CTCFlag{steve_foundation_enlightener_aXJfb2ZfaW1tb3J0}` - Steve (VM2)
9. `CTCFlag{summit_level_peak}` - Max (VM3)
10. `CTCFlag{vecna_foundation_king_YWxpdHlfYW1yaXR9}` - Vecna (VM3)

## 🔑 Keys

This CTF contains **10 Keys** scattered throughout the infrastructure:

1. **KEY1**: `tqagehxF5IKihGp7ram9VuAinaTsjyql` - Admin panel (`/admin/key1.txt`)
2. **KEY2**: `fjD2rfaDcBmN9MulBQSRV0hnjI2gxUab` - Login bypass (`/login/key2.txt`)
3. **KEY3**: `5d26CrfDtO1QMwdMTcRCMqbFaiy4X4na` - Credentials directory (`/credentials/key3.txt`)
4. **KEY4**: `hAshnZnqlAt5VZR2rrAUeMMVjiu62Dnb` - Robots.txt (`/robots.txt`)
5. **KEY5**: `9kDk7sPpBcshmMLYd5kg0ARqndQw4xTr` - VM1 (`/home/will/key5.txt` or `/home/joyce/key5.txt`)
6. **KEY6**: `wU3r4zDfSwrPv0zRUL0pjBiQlaCs8gKj` - VM2 (`/home/dustin/key6.txt` or `/home/steve/key6.txt`)
7. **KEY7**: `mV8y6bNjS3wjzS9tsa4wDNsZqsFt3xHp` - VM3 (`/home/max/key7.txt`)
8. **KEY8**: `eB1v9pLkWFn1M4HLUK65Mr7TtjPz7dMr` - VM1 (`/home/will/key8.txt` or `/home/joyce/key8.txt`)
9. **KEY9**: `cR5x3wQsbQLNR3PpAwb0MhJ0voXy6nLp` - VM2 (`/home/dustin/key9.txt` or `/home/steve/key9.txt`)
10. **KEY10**: `gT7z8vFmhCJt6xk0vJkYr82XpbYw2kNd` - VM3 (`/home/vecna/key10.txt`)

> **Note**: Keys are dynamically generated when running `genkey.sh`. The values shown above are examples from the current deployment.

## 🛡️ Security Considerations

- **Default Credentials**: All default passwords should be changed in production.
- **Network Isolation**: Consider using Docker networks for better isolation.
- **Resource Limits**: Set appropriate CPU and memory limits for containers.
- **Educational Use**: This machine contains intentional vulnerabilities. Do NOT expose it to the public internet without a firewall.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This CTF machine is designed for educational purposes only. Ensure you have proper authorization before deploying in any environment.
