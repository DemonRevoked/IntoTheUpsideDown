# Dockerfile_ssh
FROM ubuntu:latest

# Update and install necessary packages
RUN apt update && apt install openssh-server nano sudo -y

# Create SSH users with a home directory in /home/

# Admin user
RUN useradd -rm -d /home/vecna -s /bin/bash -u 1001 vecna
# Normal user
RUN useradd -rm -d /home/max -s /bin/bash -u 1002 max

# Set passwords for the new users
# Password for admin user 'vecna'
RUN echo 'vecna:ClockChimes&Spiders#001' | chpasswd
# Password for normal user 'max'
RUN echo 'max:KateBush&Headphones!1986' | chpasswd

# Grant 'vecna' sudo privileges and allow editing of /etc/shadow
# REMOVE: RUN chmod 666 /etc/shadow
RUN echo 'vecna ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Tar Wildcard Challenge (Moderate)
# Install Cron
RUN apt-get install -y cron
# Create a backup script that root runs
RUN echo '#!/bin/bash\ncd /home/max/uploads && tar -cf /tmp/backup.tar *' > /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh
# Create a folder where the user can write files to be backed up
RUN mkdir -p /home/max/uploads && chown max:max /home/max/uploads
# Add to cron (runs every minute)
RUN echo '* * * * * root /usr/local/bin/backup.sh' >> /etc/crontab
# Ensure Cron service is running
CMD service ssh start && cron -f

#copy key file
COPY key7.txt /home/max/key7.txt
COPY key10.txt /home/vecna/key10.txt
COPY final.txt /home/vecna/final.txt
COPY welcome_max.txt /home/max/welcome.txt
COPY welcome_vecna.txt /home/vecna/welcome.txt

#copy flag files
COPY flag4.txt /home/max/flag4.txt
COPY maxflag.txt /home/max/flag.txt
COPY vecnaflag.txt /home/vecna/flag.txt

# Set proper ownership of home directory contents
RUN chown -R max:max /home/max && \
    chown -R vecna:vecna /home/vecna

# IMPORTANT: Restrict Vecna's home directory so only vecna (and root) can access it
# This forces the user to solve the tar wildcard privilege escalation challenge
RUN chmod 700 /home/vecna

#RUN chmod 666 /root/final.txt
# Expose the SSH port
EXPOSE 22

# Start the SSH service in the foreground
# CMD handled above
# CMD ["service", "ssh", "start"]
