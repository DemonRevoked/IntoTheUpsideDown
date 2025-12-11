# Into the Upside Down - Development Checklist

This checklist ensures all CTF artifacts contain the correct story-aligned content and data. Verify each item before deployment.

## 📋 Pre-Deployment Verification

### 🌐 Web Application Files

#### Main Landing Page
- [ ] **File**: `web_page/src/index.html`
- [ ] **Verify Content**:
  - Title: "Into the Upside Down"
  - Message: "Welcome, Brave Soul. You have entered the Upside Down of cybersecurity..."
  - Message: "The Mind Flayer's digital tentacles have corrupted our systems, and the gate is open."
  - Message: "Your mission is to navigate through the layers of this cursed dimension..."
  - Message: "Be warned: Vecna is watching."
  - Message: "Friends don't lie, but hackers do."

#### Admin Panel (Chapter 2: Foundation Level)
- [ ] **File**: `web_page/src/admin/index.php`
- [ ] **Verify Content**:
  - Checks for User-Agent: `Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0`
  - Checks for X-Forwarded-For: `127.0.0.1`
  - Title: "Hawkins Lab - Inner Circle"
  - Message: "Only those with the highest clearance—or the most powerful psionic abilities—can see this page."
  - Message: "You have successfully spoofed your identity to the system."
  - Message: "The experiments here are dangerous. Do not let them open the gate again."
  - Message: "You've established your foundation in this digital dimension."
  - Flag displayed: `CTCFlag{foundation_level_base}`
  - Comment: `<!-- needed key: /key1.txt-->`
- [ ] **File**: `web_page/src/admin/key1.txt`
- [ ] **Verify**: Contains dynamically generated KEY1 (32 characters)

#### Admin 403 Forbidden Page
- [ ] **File**: `web_page/src/admin/custom_403.php`
- [ ] **Verify Content**:
  - Title: "403 - RESTRICTED ACCESS"
  - Message: "UNAUTHORIZED PERSONNEL DETECTED."
  - Message: "This area is under Hawkins National Laboratory surveillance. Turn back before the Demogorgons find you."

#### Login Page (Chapter 3: Secondary Level)
- [ ] **File**: `web_page/src/login/index.php`
- [ ] **Verify Content**:
  - Title: "Hawkins Lab Login"
  - Form action: "Enter the Upside Down"
  - SQL Injection filter: Blocks `\s`, `-`, `#`
  - Error message: "Security Alert: Malicious input detected. Access Denied."
  - Comment: `<!--needed key : /key2.txt -->`
- [ ] **File**: `web_page/src/login/key2.txt`
- [ ] **Verify**: Contains dynamically generated KEY2 (32 characters)

#### Login Success Page
- [ ] **File**: `web_page/src/login/success_page.php`
- [ ] **Verify Content**:
  - Title: "Access Granted: Hawkins Lab"
  - Message: "Congratulations. You have bypassed the perimeter security of Hawkins National Laboratory."
  - Message: "You are now deep within the restricted zone. The gate is near, but the Mind Flayer knows you are here."
  - Message: "You've reached the secondary level of access. The truth is hidden in plain sight..."
  - Message: "But the deeper you go, the more you realize how extensive this breach truly is."
  - Flag displayed: `CTCFlag{secondary_level_access}`

#### Credentials Directory (Chapter 4: Hidden Level)
- [ ] **File**: `web_page/src/credentials/index.html`
- [ ] **Verify Content**:
  - Title: "Archives: Project MKUltra"
  - Message: "You have reached the archival records. Most files have been redacted or destroyed. However, some images remain."
  - Message: "Dr. Brenner was known to hide sensitive information inside standard image files. Use your tools to extract the truth from the static."
  - Message: "The key you seek is hidden where the eye cannot see."
  - Comment: `<!-- key : ./key3.txt -->`
- [ ] **File**: `web_page/src/credentials/key3.txt`
- [ ] **Verify**: Contains dynamically generated KEY3 (32 characters)
- [ ] **File**: `web_page/src/credentials/secret_image.png`
- [ ] **Verify**: Image file exists and contains steganographic data
- [ ] **File**: `web_page/src/credentials/secretmessage.txt`
- [ ] **Verify Content**:
  - Message: "Hello, This note is a quieter hint from Hawkins Lab..."
  - Message: "The old projects sometimes tucked details into ordinary images..."
  - Message: "You have reached the archival records of Project MKUltra..."
  - Message: "Dr. Brenner was known to hide sensitive information inside standard image files."
  - Message: "The message contains cryptic hex data that may reveal access credentials."
  - Message: "A digital gateway awaits on port 2222. Look for the one who sees beyond the illusions—the username begins with 'justin' and holds the key to the Perception Level."
  - Flag: `CTCFlag{hidden_level_archive}`
  - Hex data: `pass(justin)[->64->13->16] = 48 54 49 75 70 7a 6b 4b 6e 54 79 30 4d 46 41 55 70 61 57 6c 5a 47 56 6d`

#### Robots.txt (Chapter 5)
- [ ] **File**: `web_page/src/robots.txt`
- [ ] **Verify Content**:
  - Format: `Disallow: /ftp KEY4: <generated_key>`
  - KEY4 is dynamically generated (32 characters)

### 📁 FTP Server

#### FTP Configuration
- [ ] **File**: `docker-compose.yml`
- [ ] **Verify FTP Banner**:
  - Environment variable: `FTPD_BANNER=Welcome to the Upside Down FTP. The gate is locked. Password Hint: gate_access`
  - **Note**: Must include colon after "Password Hint"

#### FTP Files
- [ ] **File**: `ftp/secret.zip`
- [ ] **Verify**:
  - File exists
  - Password protected with: `gate_access`
  - Contains flag file with: `CTCFlag{gate_access_portal}`

### 🗄️ Database

#### Database Initialization
- [ ] **File**: `database/init.sql`
- [ ] **Verify Users Table** contains all Party members:
  - Eleven: `Waffles@011`
  - Hopper: `CoffeeAndContemplation`
  - Mike: `DungeonMaster83`
  - Dustin: `CompassGenius`
  - Lucas: `WristRocketMaster`
  - Nancy: `NancyWheeler1983`
  - Jonathan: `Photographer1983`
  - Steve: `HairSpray&Bat!1984`
  - Max: `KateBush&Headphones!1986`
  - Will: `WizardWill#CastleByers`

#### Database Credentials
- [ ] **File**: `docker-compose.yml`
- [ ] **Verify**:
  - DB_USER: `root`
  - DB_PASS: `example`
  - MYSQL_ROOT_PASSWORD: `example`
  - MYSQL_DATABASE: `ctf`

### 🔐 SSH Machine VM1 (Port 2223) - Communication Level

#### Dockerfile
- [ ] **File**: `ssh_machine/vm1/Dockerfile`
- [ ] **Verify**:
  - Users created: `joyce`, `will`
  - Passwords set correctly
  - Files copied: `usbimage`, `key5.txt`, `key8.txt`, `welcome_will.txt`, `welcome_joyce.txt`
  - Port exposed: 22 (mapped to 2223)

#### User Credentials
- [ ] **Will**: `will` / `WizardWill#CastleByers`
- [ ] **Joyce**: `joyce` / `Magnets&Lights!1983`

#### Will's Files
- [ ] **File**: `ssh_machine/vm1/welcome_will.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Noble Explorer..."
  - Message: "You have unlocked the power of communication across the void..."
  - Message: "Will was the first to be taken by the Upside Down..."
  - Message: "You are now in the Communication Level..."
- [ ] **File**: `flags/willflag.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Noble Explorer, You have journeyed far through the corrupted dimensions..."
  - Message: "Through wisdom and clarity, you have unlocked the power of communication across the void..."
  - Flag: `CTCFlag{communication_level_voice}`
- [ ] **File**: `ssh_machine/vm1/key5.txt`
- [ ] **Verify**: Dynamically generated KEY5 (32 characters)
- [ ] **File**: `ssh_machine/vm1/usbimage`
- [ ] **Verify**: Forensics file exists

#### Joyce's Files
- [ ] **File**: `ssh_machine/vm1/welcome_joyce.txt`
- [ ] **Verify Content**:
  - Message: "As you navigate through the corrupted dimensions of the Upside Down..."
  - Message: "Joyce Byers, the fierce mother who never gave up searching for her son..."
  - Message: "Foundation Protector level..."
- [ ] **File**: `flags/joyceflag.txt`
- [ ] **Verify Content**:
  - Message: "As you navigate through the corrupted dimensions of the Upside Down, you encounter Joyce Byers..."
  - Message: "Her determination to protect Will and her unwavering resolve..."
  - Flag: `CTCFlag{joyce_foundation_protector_Q1RDRmxhZ3tlbGl4}`
- [ ] **File**: `ssh_machine/vm1/key8.txt`
- [ ] **Verify**: Dynamically generated KEY8 (32 characters)

### 🔐 SSH Machine VM2 (Port 2222) - Perception Level

#### Dockerfile
- [ ] **File**: `ssh_machine/vm2/Dockerfile`
- [ ] **Verify**:
  - Users created: `steve`, `dustin`
  - Passwords set correctly
  - Files copied: `key6.txt`, `key9.txt`, `welcome_dustin.txt`, `welcome_steve.txt`, `backup_script.sh`
  - Sudoers entry: `dustin ALL=(ALL) NOPASSWD: /usr/local/bin/backup_script.sh`
  - Port exposed: 22 (mapped to 2222)

#### User Credentials
- [ ] **Dustin**: `dustin` / `PearlWhite#Grrr123`
- [ ] **Steve**: `steve` / `HairSpray&Bat!1984`

#### Dustin's Files
- [ ] **File**: `ssh_machine/vm2/welcome_dustin.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Valiant Explorer..."
  - Message: "You have pierced the veil between dimensions..."
  - Message: "Dustin's insight pierces through the illusions..."
  - Message: "You are now in the Perception Level..."
- [ ] **File**: `flags/dustinflag.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Valiant Explorer, Your path has been one of bravery and insight..."
  - Message: "You have pierced the veil between dimensions and tapped into the profound wisdom of the third eye..."
  - Flag: `CTCFlag{perception_level_sight}`
- [ ] **File**: `ssh_machine/vm2/key6.txt`
- [ ] **Verify**: Dynamically generated KEY6 (32 characters)

#### Steve's Files
- [ ] **File**: `ssh_machine/vm2/welcome_steve.txt`
- [ ] **Verify Content**:
  - Message: "Your journey through the intricate maze of the Upside Down..."
  - Message: "Steve Harrington, the babysitter who evolved from a self-centered jock..."
  - Message: "Foundation Enlightener realm..."
- [ ] **File**: `flags/steveflag.txt`
- [ ] **Verify Content**:
  - Message: "Your journey through the intricate maze of the Upside Down has led you to Steve Harrington..."
  - Message: "Known for his strategic thinking and unwavering loyalty..."
  - Flag: `CTCFlag{steve_foundation_enlightener_aXJfb2ZfaW1tb3J0}`
- [ ] **File**: `ssh_machine/vm2/key9.txt`
- [ ] **Verify**: Dynamically generated KEY9 (32 characters)

#### Backup Script
- [ ] **File**: `ssh_machine/vm2/backup_script.sh`
- [ ] **Verify**:
  - Script calls `date` using relative path (not `/bin/date`)
  - Executable permissions set
  - Located at `/usr/local/bin/backup_script.sh`

### 🔐 SSH Machine VM3 (Port 2224) - Summit Level & Foundation King

#### Dockerfile
- [ ] **File**: `ssh_machine/vm3/Dockerfile`
- [ ] **Verify**:
  - Users created: `vecna`, `max`
  - Passwords set correctly
  - Files copied: `key7.txt`, `key10.txt`, `final.txt`, `welcome_max.txt`, `welcome_vecna.txt`
  - Cron job configured: `* * * * * root /usr/local/bin/backup.sh`
  - Backup script: `tar -cf /tmp/backup.tar *` in `/home/max/uploads`
  - Port exposed: 22 (mapped to 2224)

#### User Credentials
- [ ] **Max**: `max` / `KateBush&Headphones!1986`
- [ ] **Vecna**: `vecna` / `ClockChimes&Spiders#001`

#### Max's Files
- [ ] **File**: `ssh_machine/vm3/welcome_max.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Brave Explorer..."
  - Message: "You have reached the summit level..."
  - Message: "Max Mayfield faced Vecna directly..."
  - Message: "You are now in the Summit Level..."
- [ ] **File**: `flags/maxflag.txt`
- [ ] **Verify Content**:
  - Message: "Greetings, Brave Explorer, Your journey through the Upside Down has brought you to the pinnacle..."
  - Message: "You have reached the summit level, where the boundaries between dimensions blur..."
  - Flag: `CTCFlag{summit_level_peak}`
- [ ] **File**: `ssh_machine/vm3/key7.txt`
- [ ] **Verify**: Dynamically generated KEY7 (32 characters)
- [ ] **Directory**: `/home/max/uploads`
- [ ] **Verify**: Directory exists and is writable by max user

#### Vecna's Files
- [ ] **File**: `ssh_machine/vm3/welcome_vecna.txt`
- [ ] **Verify Content**:
  - Message: "After navigating through layers of complex challenges..."
  - Message: "Vecna, the powerful entity that rules over the corrupted dimension..."
  - Message: "You are now in the Foundation King realm..."
  - Message: "The final keys are here. Collect them all, and you may yet close the gate."
- [ ] **File**: `flags/vecnaflag.txt`
- [ ] **Verify Content**:
  - Message: "After navigating through layers of complex challenges in the Upside Down, you finally encounter Vecna..."
  - Message: "As the Mind Flayer's primary agent, Vecna stands as a testament to your tenacity..."
  - Flag: `CTCFlag{vecna_foundation_king_YWxpdHlfYW1yaXR9}`
- [ ] **File**: `ssh_machine/vm3/key10.txt`
- [ ] **Verify**: Dynamically generated KEY10 (32 characters)
- [ ] **File**: `ssh_machine/vm3/final.txt`
- [ ] **Verify Content**:
  - Message: "Congratulations, Brave Explorer!"
  - Lists all 10 levels completed
  - Message: "You've collected all 10 Keys and discovered all 10 Flags."
  - Message: "The gate is closed. For now."
  - Message: "But remember: Vecna is always watching. The Upside Down never truly goes away."
  - Final quote: "Friends don't lie, but hackers do. And sometimes, that's exactly what you need to save the world."

### 📦 Docker Configuration

#### Docker Compose
- [ ] **File**: `docker-compose.yml`
- [ ] **Verify Services**:
  - `web_page`: Port 80
  - `ftpd`: Ports 20-21, 65500-65515
  - `db`: Port 3306
  - `vm1`: Port 2223 (SSH)
  - `vm2`: Port 2222 (SSH)
  - `vm3`: Port 2224 (SSH)
- [ ] **Verify Volume Mounts**:
  - Flag files mounted to correct user home directories
  - Key files mounted correctly
  - Welcome files mounted correctly

### 🔑 Key Generation

#### Key Generation Script
- [ ] **File**: `genkey.sh`
- [ ] **Verify**:
  - Generates 10 unique keys (KEY1-KEY10)
  - Each key is 32 characters
  - Keys are written to correct locations
  - Keys are also written to robots.txt for KEY4

### 📝 Documentation Files

#### Story File
- [ ] **File**: `story.md`
- [ ] **Verify**: Complete narrative from player perspective as Alex Chen

#### Walkthrough File
- [ ] **File**: `Walkthrough.md`
- [ ] **Verify**: 
  - All chapters match story.md
  - All technical steps are correct
  - All flags and keys are documented
  - Story context included for each challenge

#### README
- [ ] **File**: `README.md`
- [ ] **Verify**: 
  - Architecture overview
  - Deployment instructions
  - All flags and keys listed
  - Port mappings correct

## ✅ Final Verification Checklist

### Content Consistency
- [ ] All story messages match between story.md, Walkthrough.md, and actual files
- [ ] All flag messages match the story narrative
- [ ] All welcome messages are present and correct
- [ ] All level names are consistent (Foundation Level, Secondary Level, etc.)

### Technical Verification
- [ ] All SQL injection filters work correctly
- [ ] All privilege escalation exploits are functional
- [ ] All file permissions are correct
- [ ] All passwords match between database and SSH machines
- [ ] FTP banner displays correctly
- [ ] All keys are dynamically generated

### Flag Verification
- [ ] All 10 flags exist and contain correct format: `CTCFlag{...}`
- [ ] All flags are accessible via intended methods
- [ ] Flag messages match story context

### Key Verification
- [ ] All 10 keys are generated (KEY1-KEY10)
- [ ] All keys are 32 characters
- [ ] All keys are in correct locations
- [ ] KEY4 is in robots.txt with correct format

### User Experience
- [ ] Welcome messages enhance story immersion
- [ ] Error messages are consistent with story
- [ ] Success messages match story progression
- [ ] Final message provides satisfying conclusion

---

## 🚀 Deployment Checklist

Before deploying to production:

1. [ ] Run `./genkey.sh` to generate all keys
2. [ ] Verify all files exist and contain correct content
3. [ ] Test all exploits work as documented
4. [ ] Verify all flags are accessible
5. [ ] Verify all keys are accessible
6. [ ] Test complete player journey from start to finish
7. [ ] Verify story narrative flows correctly
8. [ ] Check all Docker containers build successfully
9. [ ] Verify all services start correctly
10. [ ] Test network connectivity between services

---

**Last Updated**: After story integration
**Status**: Ready for verification

