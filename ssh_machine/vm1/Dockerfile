# Dockerfile_ssh
FROM ubuntu:latest

# Update and install necessary packages
RUN apt update && apt install openssh-server binutils sudo -y

# Create SSH users with a home directory in /home/

# Admin user
RUN useradd -rm -d /home/joyce  -s /bin/bash -u 1001 joyce
# Normal user
RUN useradd -rm -d /home/will -s /bin/bash -u 1002 will

# Set passwords for the new users
# Password for admin user 'joyce'
RUN echo 'joyce:Magnets&Lights!1983' | chpasswd
# Password for normal user 'will'
RUN echo 'will:WizardWill#CastleByers' | chpasswd

#copy usb image in first user
COPY usbimage /home/will/usbimage
COPY key5.txt /home/will/key5.txt
COPY key8.txt /home/joyce/key8.txt
COPY welcome_will.txt /home/will/welcome.txt
COPY welcome_joyce.txt /home/joyce/welcome.txt

# Set proper ownership of home directory contents
RUN chown -R will:will /home/will && \
    chown -R joyce:joyce /home/joyce

# IMPORTANT: Restrict Joyce's home directory so only joyce (and root) can access it
# This forces the user to solve the privilege escalation challenge
RUN chmod 700 /home/joyce

# Expose the SSH port
EXPOSE 22

# Start the SSH service in the foreground
CMD ["service" "ssh" "start"]
