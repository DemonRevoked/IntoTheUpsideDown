# Dockerfile_ssh
FROM demonrevoked/vuln:nmap-3.81

# Update and install necessary packages
RUN apt update && apt install openssh-server sudo -y

# Create SSH users with a home directory in /home/
# Admin user
RUN useradd -rm -d /home/steve  -s /bin/bash -u 1001 steve
# Normal user
RUN useradd -rm -d /home/dustin -s /bin/bash -u 1002 dustin

# Set passwords for the new users
# Password for admin user 'steve'
RUN echo 'steve:HairSpray&Bat!1984' | chpasswd
# Password for normal user 'dustin'
RUN echo 'dustin:PearlWhite#Grrr123' | chpasswd

# Copy files to user home directories
COPY key6.txt /home/dustin/key6.txt
COPY key9.txt /home/steve/key9.txt
COPY welcome_dustin.txt /home/dustin/welcome.txt
COPY welcome_steve.txt /home/steve/welcome.txt

# Set proper ownership of home directory contents
RUN chown -R dustin:dustin /home/dustin && \
    chown -R steve:steve /home/steve

# IMPORTANT: Restrict Steve's home directory so only steve (and root) can access it
# This forces the user to solve the privilege escalation challenge
RUN chmod 700 /home/steve

# Path Hijacking Challenge (Moderate)
COPY backup_script.sh /usr/local/bin/backup_script.sh
RUN chmod +x /usr/local/bin/backup_script.sh
# Allow dustin to run the backup script as root without a password
# IMPORTANT: Disable secure_path for dustin to enable PATH hijacking vulnerability
RUN echo 'Defaults:dustin !secure_path' >> /etc/sudoers
RUN echo 'Defaults:dustin env_keep += "PATH"' >> /etc/sudoers
RUN echo 'dustin ALL=(ALL) NOPASSWD: /usr/local/bin/backup_script.sh' >> /etc/sudoers

# Expose the SSH port
EXPOSE 22

# Start the SSH service in the foreground
CMD ["service" "ssh" "start"]
