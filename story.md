# Into the Upside Down: A Digital Journey

## Your Character: Alex Chen - The Digital Investigator

You are **Alex Chen**, a cybersecurity researcher and former Hawkins National Laboratory intern. After the events of 1986, you've been tracking strange digital anomalies that seem to be leaking from the Upside Down into our world's network infrastructure. Your mission: investigate the corrupted systems, find all the keys to close the digital gate, and prevent Vecna's influence from spreading through cyberspace.

You're not alone in this fight—the Party's digital footprints are scattered throughout the system, and you'll need to follow their trail to understand what happened and how to stop it.

---

## Chapter 1: The Digital Gate Opens

*The year is 1987. The physical gate to the Upside Down may be closed, but something else has opened—a digital breach in Hawkins Lab's network infrastructure.*

You receive an encrypted message on your terminal. The sender is unknown, but the content is clear: "The Mind Flayer's digital tentacles have corrupted our systems, and the gate is open. Find the keys to close it. Vecna is watching."

Your investigation begins at the main web interface of Hawkins Lab. As you navigate to the server, you're greeted by a stark warning:

> "Welcome, Brave Soul. You have entered the Upside Down of cybersecurity. The Mind Flayer's digital tentacles have corrupted our systems, and the gate is open. Your mission is to navigate through the layers of this cursed dimension, defeat the demogorgons guarding the firewalls, and find the keys to close the gate. Be warned: Vecna is watching."

The message is clear: this isn't just a network breach—it's something far more sinister. The Upside Down has found a way to manifest in the digital realm.

---

## Chapter 2: Breaking Into the Inner Circle

*"Friends don't lie, but hackers do."*

Your first objective is to access the **Hawkins Lab Inner Circle**—the admin panel that contains classified information. However, when you try to access `/admin/`, you're met with a 403 Forbidden page:

> "UNAUTHORIZED PERSONNEL DETECTED. This area is under Hawkins National Laboratory surveillance. Turn back before the Demogorgons find you."

The system is checking for something specific. You realize it's looking for both a particular User-Agent string and an internal IP address via the `X-Forwarded-For` header. This is a security measure designed to only allow access from within the lab's internal network.

By spoofing the correct headers, you bypass the restriction and gain access to the Inner Circle. Here, you discover **KEY1** and your first flag: `CTCFlag{foundation_level_base}`. You've established your foundation in this digital dimension.

---

## Chapter 3: The Login Bypass

*"The truth is hidden in plain sight."*

Next, you need to access the main login system. The Hawkins Lab login page requires authentication, but you notice something unusual—the system filters certain characters, blocking spaces, dashes, and hash symbols. This is a security measure, but it's not perfect.

Standard SQL injection payloads fail, but you discover that inline comments (`/**/`) can bypass the filter. Using the payload `admin'/**/OR/**/'1'='1`, you successfully bypass authentication and gain access to the system.

In the login directory, you find **KEY2** and the flag: `CTCFlag{secondary_level_access}`. You're making progress, but the deeper you go, the more you realize how extensive this breach truly is.

---

## Chapter 4: The Hidden Archives

*"Dr. Brenner was known to hide sensitive information inside standard image files."*

Your investigation leads you to the credentials directory, where you discover references to **Project MKUltra**—the classified government program that Eleven was part of. The page warns you:

> "You have reached the archival records. Most files have been redacted or destroyed. However, some images remain. Dr. Brenner was known to hide sensitive information inside standard image files. Use your tools to extract the truth from the static."

You download the secret image and use steganography tools (`steghide`, `binwalk`) to extract hidden data. Within the image, you find a secret message and **KEY3**. The flag reveals itself: `CTCFlag{hidden_level_archive}`.

The message contains cryptic hex data that may reveal access credentials. A digital gateway awaits on port 2222, and the username begins with "justin".

---

## Chapter 5: The Robots' Secret

*"Sometimes the smallest clues lead to the biggest discoveries."*

While exploring the web server, you check the `robots.txt` file—a standard practice in web reconnaissance. Hidden within this seemingly innocuous file, you discover **KEY4**. The system administrators left this key in plain sight, perhaps as a test or a backup access method.

You're collecting keys, but you still don't know what they're for. Each key seems to be part of a larger puzzle.

---

## Chapter 6: The FTP Portal

*"The gate is locked, but the key is in the message."*

Your network scan reveals an FTP server running on the target. You connect anonymously and are greeted by a cryptic banner:

> "Welcome to the Upside Down FTP. The gate is locked. Password Hint: gate_access"

On the server, you find a file called `secret.zip`. The banner's hint is clear: the password is `gate_access`. You download and extract the zip file, revealing another piece of the puzzle.

Inside, you find the flag: `CTCFlag{gate_access_portal}`. This confirms that the FTP server is indeed a portal between dimensions—a digital gateway that needs to be closed.

---

## Chapter 7: The Database of The Party

*"The Party's credentials are scattered across the digital void."*

You discover that the system is connected to a MySQL database. Using default credentials (root/example), you gain access and begin enumerating the database structure.

In the `users` table, you find the credentials of The Party members—the kids from Hawkins who fought the Upside Down:

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

These credentials will be crucial for accessing the SSH machines where the real secrets are hidden. The Party's digital presence is scattered across multiple systems, and you'll need to follow their trail.

---

## Chapter 8: VM1 - The Communication Level

*"Will's voice echoes through the digital void."*

You SSH into the first machine (port 2223) using Will's credentials (`will` / `WizardWill#CastleByers`). Will was the first to be taken by the Upside Down, and his connection to the dimension runs deep.

In Will's home directory, you discover a file called `usbimage`—a forensics challenge. Analyzing this image reveals hidden data, and you find **KEY5** and **KEY8**.

More importantly, you discover Will's flag with a message:

> "Greetings, Noble Explorer, You have journeyed far through the corrupted dimensions, and your perseverance has borne fruit. Through wisdom and clarity, you have unlocked the power of communication across the void, a gift bestowed upon those who possess the courage to bridge worlds. Embrace this power and let your voice resonate through the dimensional barriers."

**Flag**: `CTCFlag{communication_level_voice}`

You also access Joyce's account (`joyce` / `Magnets&Lights!1983`). Joyce Byers, Will's mother, never gave up searching for her son. Her flag reveals:

> "As you navigate through the corrupted dimensions of the Upside Down, you encounter Joyce Byers, the fierce mother who never gave up searching for her son. Her determination to protect Will and her unwavering resolve in the face of impossible odds have made her a guardian of the foundation."

**Flag**: `CTCFlag{joyce_foundation_protector_Q1RDRmxhZ3tlbGl4}`

---

## Chapter 9: VM2 - The Perception Level

*"Dustin's insight pierces through the illusions."*

The second machine (port 2222) requires different credentials. You use Dustin's account (`dustin` / `PearlWhite#Grrr123`) or Steve's (`steve` / `HairSpray&Bat!1984`).

Here, you face a privilege escalation challenge. The system has a backup script that runs with sudo privileges, but it calls the `date` command using a relative path. This is a classic path hijacking vulnerability.

You exploit it by:
1. Creating a malicious `date` script in `/tmp`
2. Modifying your PATH to prioritize `/tmp`
3. Running the backup script, which executes your malicious code
4. Gaining root access

As root, you discover **KEY6** and **KEY9**, along with the flags.

Dustin's flag reveals the power of perception:

> "Greetings, Valiant Explorer, Your path has been one of bravery and insight, leading you to awaken the power of perception. You have pierced the veil between dimensions and tapped into the profound wisdom of the third eye, seeing beyond the illusions of reality."

**Flag**: `CTCFlag{perception_level_sight}`

Steve's flag acknowledges your strategic thinking:

> "Your journey through the intricate maze of the Upside Down has led you to Steve Harrington, the babysitter who evolved from a self-centered jock to a protector of the Party. Known for his strategic thinking and unwavering loyalty, Steve has become a beacon of light in the darkness."

**Flag**: `CTCFlag{steve_foundation_enlightener_aXJfb2ZfaW1tb3J0}`

---

## Chapter 10: VM3 - The Summit and The King

*"Max reached the summit, but Vecna rules from the shadows."*

The final machine (port 2224) is the most dangerous. Here, you'll encounter both Max and Vecna—the entity that rules the Upside Down.

You first access Max's account (`max` / `KateBush&Headphones!1986`). Max Mayfield faced Vecna directly, using Kate Bush's "Running Up That Hill" to break free from his curse. Her connection to the dimension is powerful.

In Max's home directory, you discover an `uploads` folder where a root cron job runs `tar -cf /tmp/backup.tar *`. This is a tar wildcard injection vulnerability.

You exploit it by:
1. Creating a malicious shell script
2. Creating files with tar's `--checkpoint` and `--checkpoint-action` options
3. Waiting for the cron job to execute
4. Gaining root access through the injected command

As root, you find **KEY7** and Max's flag:

> "Greetings, Brave Explorer, Your journey through the Upside Down has brought you to the pinnacle of dimensional understanding. You have reached the summit level, where the boundaries between dimensions blur and ultimate knowledge awaits."

**Flag**: `CTCFlag{summit_level_peak}`

But the ultimate challenge awaits: Vecna's account (`vecna` / `ClockChimes&Spiders#001`). Vecna is the Mind Flayer's primary agent, the entity that rules over the corrupted dimension. Accessing his account requires the same privilege escalation, but the stakes are higher.

In Vecna's directory, you discover **KEY10**—the final key needed to close the gate.

Vecna's flag is a testament to your tenacity:

> "After navigating through layers of complex challenges in the Upside Down, you finally encounter Vecna, the powerful entity that rules over the corrupted dimension. As the Mind Flayer's primary agent, Vecna stands as a testament to your tenacity and prowess in reaching the deepest levels of Hawkins Lab's secrets. The path to this entity was filled with trials, but you have shown great resolve and ingenuity. Vecna grants you a symbol of ultimate power, a reward for your unyielding spirit in conquering the foundation."

**Flag**: `CTCFlag{vecna_foundation_king_YWxpdHlfYW1yaXR9}`

---

## Epilogue: Closing the Gate

*"You've collected all the keys. The gate can now be closed."*

You've successfully navigated through all layers of the Upside Down's digital manifestation:

- **Foundation Level**: Admin panel access
- **Secondary Level**: Login bypass
- **Hidden Level**: Archive steganography
- **Gate Level**: FTP portal
- **Communication Level**: Will's voice across dimensions
- **Perception Level**: Dustin's third eye
- **Summit Level**: Max's peak understanding
- **Foundation Protector**: Joyce's unwavering resolve
- **Foundation Enlightener**: Steve's strategic wisdom
- **Foundation King**: Vecna's ultimate power

You've collected all **10 Keys** and discovered all **10 Flags**. The digital gate to the Upside Down can now be closed, but the experience has changed you. You've seen how the boundaries between dimensions can blur, how digital and physical realities can intersect, and how the courage of a few can stand against overwhelming darkness.

As Alex Chen, you've not just completed a cybersecurity investigation—you've walked in the digital footsteps of The Party, faced the same challenges they did in the physical world, and emerged victorious.

The gate is closed. For now.

But remember: **Vecna is always watching. The Upside Down never truly goes away. It just waits for another gate to open.**

---

## Your Journey Summary

**Character**: Alex Chen - Digital Investigator & Former Hawkins Lab Intern

**Mission**: Investigate the digital breach of the Upside Down, collect all keys and flags, and close the gate before Vecna's influence spreads.

**Challenges Overcome**:
- ✅ User-Agent & IP Header Bypass
- ✅ SQL Injection Filter Bypass
- ✅ Steganography & Image Analysis
- ✅ FTP Encrypted Archive Extraction
- ✅ Database Enumeration
- ✅ Digital Forensics (USB Image Analysis)
- ✅ Path Hijacking Privilege Escalation
- ✅ Tar Wildcard Injection Privilege Escalation

**Keys Collected**: 10/10
**Flags Discovered**: 10/10

**Status**: Mission Complete. The digital gate is closed. But stay vigilant—the Upside Down always finds another way.

---

*"Friends don't lie, but hackers do. And sometimes, that's exactly what you need to save the world."*

